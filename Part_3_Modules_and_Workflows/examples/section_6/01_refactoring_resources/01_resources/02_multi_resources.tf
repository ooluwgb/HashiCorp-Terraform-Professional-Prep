##############################################################################################################
##############################################################################################################
##########################################      COMPUTE RESOURCES       ######################################
##############################################################################################################
##############################################################################################################

#######################################################
# Generate random pet name for unique bucket names
#######################################################
resource "random_pet" "example" {
  length    = 2
  separator = "-"
}

#######################################################
# DATA SOURCES
#######################################################

# Validate instance type for Free Tier eligibility
check "free_tier_eligible" {
  data "aws_ec2_instance_type" "example" {
    instance_type = var.instance_type
  }
  assert {
    condition     = data.aws_ec2_instance_type.example.free_tier_eligible == true
    error_message = "WARNING: THIS IS NOT A FREE TIER INSTANCE TYPE. YOU WILL INCUR CHARGES IF LEFT RUNNING TOO LONG."
  }
}

# Fetch the latest Ubuntu 22.04 AMI
data "aws_ami" "example" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's AWS account ID

  lifecycle {
    postcondition {
      condition     = self.architecture == "x86_64" && self.state == "available"
      error_message = "The Ubuntu AMI must be x86_64 architecture and in 'available' state."
    }
  }
}

#######################################################
# LAUNCH TEMPLATE
#######################################################
resource "aws_launch_template" "this" {
  name_prefix   = "asg-template-"
  image_id      = data.aws_ami.example.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  tags = {
    Name = "asg-template"
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.allow_tls.id]
  }

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }
}

#######################################################
# AUTOSCALING GROUP
#######################################################
resource "aws_autoscaling_group" "this" {
  name                      = "asg_name"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  # Use subnet IDs from aws_subnet.main (COMMENT OUT IF YOU FACE ANY ISSUES)
  vpc_zone_identifier = [for s in aws_subnet.main : s.id]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

  tag {
    key                 = "Name"
    value               = "asg-instance"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}

##############################################################################################################
###############################################    IAM RESOURCES    ##########################################
##############################################################################################################

#################################################################################
# CALLER IDENTITY AND SESSION CONTEXT
#################################################################################
data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

#################################################################################
# IAM POLICY AND ATTACHMENTS
#################################################################################
data "aws_iam_policy_document" "s3_policy_document" {
  statement {
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_policy" "s3_policy" {
  name   = "example_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.s3_policy_document.json
}

resource "aws_iam_user" "test_user" {
  for_each = var.User_Name
  name     = each.value
}

resource "aws_iam_user_policy_attachment" "depends_on" {
  for_each   = var.User_Name
  user       = aws_iam_user.test_user[each.key].name
  policy_arn = aws_iam_policy.s3_policy.arn
}

#################################################################################
# IAM ROLE AND INSTANCE PROFILE
#################################################################################
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
      }
    ]
  })

  tags = {
    Name = "EC2_Role"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2_Instance_Profile"
  role = aws_iam_role.ec2_role.name
}

#################################################################################
# IAM ROLE POLICY TO DESCRIBE EC2 FOR THE ROLE ABOVE
#################################################################################
resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:Describe*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.policy.arn
}

##############################################################################################################
###################################################    S3    #################################################
##############################################################################################################

resource "aws_s3_bucket" "example" {
  bucket = "the-architect-${random_pet.example.id}-${var.bucket_name}"

  tags = {
    Name        = "the-architect-${random_pet.example.id}-${var.bucket_name}"
    Environment = "The_Architect"
  }
}

resource "aws_s3_object" "object" {
  bucket  = aws_s3_bucket.example.bucket
  key     = "file.txt"
  content = "Hello From The Architect"
}

##############################################################################################################
###################################################    VPC    ################################################
##############################################################################################################

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "main" {
  for_each   = var.subnets_cidr
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = {
    Name = "${var.vpc_name}-subnet-${each.key}"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "${var.vpc_name}-${var.sg_name}"
  description = var.sg_description
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-${var.sg_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  for_each          = { for idx, rule in var.ingress : idx => rule }
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = tonumber(try(split("-", each.value.port)[0], each.value.port))
  to_port           = tonumber(try(split("-", each.value.port)[1], each.value.port))
  ip_protocol       = each.value.ip_protocol
}

# Egress rules
# Handles cases for all protocols (-1) and specific ones separately.
resource "aws_vpc_security_group_egress_rule" "all_protocols" {
  for_each          = { for idx, rule in var.egress : idx => rule if rule.ip_protocol == "-1" }
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = each.value.cidr_ipv4
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "by_protocol" {
  for_each          = { for idx, rule in var.egress : idx => rule if rule.ip_protocol != "-1" }
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = tonumber(try(split("-", each.value.port)[0], each.value.port))
  to_port           = tonumber(try(split("-", each.value.port)[1], each.value.port))
  ip_protocol       = each.value.ip_protocol
}
