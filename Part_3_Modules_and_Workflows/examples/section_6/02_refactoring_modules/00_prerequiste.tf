###############################################################################
# PROVIDERS
###############################################################################
terraform {
  required_version = ">= 1.13.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

# Use your current admin profile/keys here
provider "aws" {
  region = "us-east-1" # IAM is global; region doesn't matter much
}

data "aws_caller_identity" "current" {}

###############################################################################
# LOCALS
###############################################################################
locals {
  aws_dir   = "${path.module}/.aws"
  credsfile = "${local.aws_dir}/creds"
  conffile  = "${local.aws_dir}/conf"
  ghost_txt = "${local.aws_dir}/the_ghost_credentials.txt"

  ghost_user     = "ghost_user"
  canada_user    = "canada_user"
  architect_user = "the_architect"

  ghost_region  = "us-west-2"
  canada_region = "ca-central-1"
  role_region   = "eu-north-1"
}

###############################################################################
# DIR SETUP
###############################################################################
resource "local_file" "aws_dir_keeper" {
  filename        = "${local.aws_dir}/.keep"
  content         = ""
  file_permission = "0600"
}

###############################################################################
# POLICIES
###############################################################################
# ghost_user: Access to Instances only in us-west-2
data "aws_iam_policy_document" "ec2_run_west2" {
  statement {
    effect  = "Allow"
    actions = ["ec2:*"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = [local.ghost_region]
    }
  }
}

resource "aws_iam_policy" "ec2_run_west2" {
  name   = "Allow-RunInstances-us-west-2"
  policy = data.aws_iam_policy_document.ec2_run_west2.json
}

# canada_user: RunInstances only in ca-central-1
data "aws_iam_policy_document" "ec2_run_cacentral1" {
  statement {
    effect  = "Allow"
    actions = ["ec2:*"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = [local.canada_region]
    }
  }
}

resource "aws_iam_policy" "ec2_run_cacentral1" {
  name   = "Allow-RunInstances-ca-central-1"
  policy = data.aws_iam_policy_document.ec2_run_cacentral1.json
}

# role: Run+Terminate only in eu-north-1
data "aws_iam_policy_document" "role_eunorth1_ec2_rw" {
  statement {
    effect  = "Allow"
    actions = ["ec2:*"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = [local.role_region]
    }
  }
}

resource "aws_iam_policy" "role_eunorth1_ec2_rw" {
  name   = "Allow-EC2-CreateDelete-eu-north-1"
  policy = data.aws_iam_policy_document.role_eunorth1_ec2_rw.json
}

###############################################################################
# USERS + ACCESS KEYS
###############################################################################
# ghost_user
resource "aws_iam_user" "ghost" {
  name = local.ghost_user
}

resource "aws_iam_user_policy_attachment" "ghost_attach" {
  user       = aws_iam_user.ghost.name
  policy_arn = aws_iam_policy.ec2_run_west2.arn
}

resource "aws_iam_access_key" "ghost" {
  user = aws_iam_user.ghost.name
}

# canada_user
resource "aws_iam_user" "canada" {
  name = local.canada_user
}

resource "aws_iam_user_policy_attachment" "canada_attach" {
  user       = aws_iam_user.canada.name
  policy_arn = aws_iam_policy.ec2_run_cacentral1.arn
}

resource "aws_iam_access_key" "canada" {
  user = aws_iam_user.canada.name
}

# the_architect
resource "aws_iam_user" "architect" {
  name = local.architect_user
}

resource "aws_iam_access_key" "architect" {
  user = aws_iam_user.architect.name
}

###############################################################################
# ROLE (eu-north-1 create/delete), TRUST THE ARCHITECT
###############################################################################
data "aws_iam_policy_document" "eu_north_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${local.architect_user}"]
    }
  }
}

resource "aws_iam_role" "eu_north_role" {
  name               = "eu-north-ec2-create-delete-role"
  assume_role_policy = data.aws_iam_policy_document.eu_north_trust.json
}

resource "aws_iam_role_policy_attachment" "eu_north_role_attach" {
  role       = aws_iam_role.eu_north_role.name
  policy_arn = aws_iam_policy.role_eunorth1_ec2_rw.arn
}

# architect needs permission to assume the role
data "aws_iam_policy_document" "architect_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [aws_iam_role.eu_north_role.arn]
  }
}

resource "aws_iam_policy" "architect_assume_role" {
  name   = "Allow-Assume-EUNorth1-Role"
  policy = data.aws_iam_policy_document.architect_assume_role.json
}

resource "aws_iam_user_policy_attachment" "architect_attach" {
  user       = aws_iam_user.architect.name
  policy_arn = aws_iam_policy.architect_assume_role.arn
}

###############################################################################
# FILES
###############################################################################
# ghost only: simple text file
resource "local_file" "ghost_txt" {
  filename        = local.ghost_txt
  file_permission = "0600"
  content = <<EOT
access_key = "${aws_iam_access_key.ghost.id}"
secret_key = "${aws_iam_access_key.ghost.secret}"

eu-north-1 assumable role ARN:
${aws_iam_role.eu_north_role.arn}
EOT
}

# canada + architect: CLI creds file
resource "local_file" "creds" {
  depends_on      = [local_file.aws_dir_keeper]
  filename        = local.credsfile
  file_permission = "0600"

  content = <<EOT
[canada]
aws_access_key_id     = ${aws_iam_access_key.canada.id}
aws_secret_access_key = ${aws_iam_access_key.canada.secret}

[the_architect]
aws_access_key_id     = ${aws_iam_access_key.architect.id}
aws_secret_access_key = ${aws_iam_access_key.architect.secret}
EOT
}

# config file with regions
resource "local_file" "conf" {
  depends_on      = [local_file.aws_dir_keeper]
  filename        = local.conffile
  file_permission = "0600"

  content = <<EOT
[profile canada]
region = ${local.canada_region}
output = json

[profile the_architect]
region = ${local.role_region}
output = json
EOT
}

###############################################################################
# OUTPUTS
###############################################################################
output "ghost_txt_file" {
  value = local.ghost_txt
}

output "aws_cli_creds_file" {
  value = local.credsfile
}

output "aws_cli_conf_file" {
  value = local.conffile
}

output "eu_north_role_arn" {
  value = aws_iam_role.eu_north_role.arn
}
