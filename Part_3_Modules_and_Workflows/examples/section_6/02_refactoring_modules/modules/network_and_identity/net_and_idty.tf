#######################################################
###### VPC
#######################################################

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}


#######################################################
###### SUBNETS
#######################################################

resource "aws_subnet" "main" {
  for_each   = var.subnets_cidr
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = {
    Name = "${var.vpc_name}-subnet-${each.key}"
  }
}


#######################################################
###### SECURITY GROUP
#######################################################

resource "aws_security_group" "allow_tls" {
  name        = "${var.vpc_name}-${var.sg_name}"
  description = var.sg_description
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-${var.sg_name}"
  }
}


#######################################################
###### INGRESS RULES
#######################################################

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  for_each          = { for idx, rule in var.ingress : idx => rule }
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = tonumber(try(split("-", each.value.port)[0], each.value.port))
  to_port           = tonumber(try(split("-", each.value.port)[1], each.value.port))
  ip_protocol       = each.value.ip_protocol
}


#######################################################
###### EGRESS RULES
#######################################################

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  for_each          = { for idx, rule in var.egress : idx => rule }
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = each.value.cidr_ipv4
  #from_port         = tonumber(try(split("-", each.value.port)[0], each.value.port))
  #to_port           = tonumber(try(split("-", each.value.port)[1], each.value.port))
  ip_protocol       = each.value.ip_protocol
}


#################################################################################
###### CALLER IDENTITY AND SESSION CONTEXT
#################################################################################

# Caller identity
data "aws_caller_identity" "current" {}

# Session context
data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}


#################################################################################
###### IAM POLICY AND ATTACHMENTS
#################################################################################

# Policy document
data "aws_iam_policy_document" "s3_policy_document" {
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }
}

# IAM policy
resource "aws_iam_policy" "s3_policy" {
  name   = "example_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.s3_policy_document.json
}

# IAM user
resource "aws_iam_user" "test_user" {
  for_each = var.User_Name
  name = each.value
}

# IAM policy attachment for the user
resource "aws_iam_user_policy_attachment" "depends_on" {
  for_each = var.User_Name
  user       = each.value
  policy_arn = aws_iam_policy.s3_policy.arn
  depends_on = [ aws_iam_user.test_user ]
}


#################################################################################
###### IAM ROLE AND INSTANCE PROFILE
#################################################################################

# IAM role
resource "aws_iam_role" "ec2_role" {
  name = "test_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "EC2_Role"
  }
}

# IAM instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2_Instance_Profile"
  role = aws_iam_role.ec2_role.name
}


#################################################################################
###### IAM ROLE POLICY TO DESCRIBE EC2 FOR THE ROLE ABOVE
#################################################################################

resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.policy.arn
}
