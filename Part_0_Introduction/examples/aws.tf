terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

############################################
# VPC + SUBNET
############################################
resource "aws_vpc" "intro" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "Introduction" }
}

resource "aws_subnet" "intro" {
  vpc_id     = aws_vpc.intro.id
  cidr_block = "10.0.1.0/24"
  tags = { Name = "Introduction" }
}

############################################
# SECURITY GROUP
############################################
resource "aws_security_group" "intro" {
  name        = "introduction-sg"
  description = "Introduction SG"
  vpc_id      = aws_vpc.intro.id
  tags        = { Name = "Introduction" }
}

# Ingress via aws_vpc_security_group_ingress_rule
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.intro.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}


############################################
# IAM
############################################
data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

data "aws_iam_policy_document" "intro" {
  statement {
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "intro" {
  name   = "intro-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.intro.json
  tags   = { Name = "Introduction" }
}

resource "aws_iam_role" "intro" {
  name = "intro-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { Service = "ec2.amazonaws.com" },
        Action    = "sts:AssumeRole"
      }
    ]
  })
  tags = { Name = "Introduction" }
}

resource "aws_iam_instance_profile" "intro" {
  name = "intro-profile"
  role = aws_iam_role.intro.name
  tags = { Name = "Introduction" }
}
/*
#USE CAREFULLY IT OVERIDES TERRAFORM USER POLICY IF ITS ADMIN POLICY
resource "aws_iam_policy_attachment" "intro" {
  name       = "intro-policy-attachment"
  roles      = [aws_iam_role.intro.name]
  policy_arn = aws_iam_policy.intro.arn
}
*/

############################################
# S3
############################################
resource "aws_s3_bucket" "intro" {
  bucket = "intro-bucket-${random_id.suffix.hex}"
  tags   = { Name = "Introduction" }
}

resource "aws_s3_object" "intro" {
  bucket  = aws_s3_bucket.intro.bucket
  key     = "hello.txt"
  content = "Hello from Introduction"
}

resource "random_id" "suffix" {
  byte_length = 4
}

############################################
# COMPUTE (EC2 + LT + ASG)
############################################
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "intro" {
  name_prefix   = "intro-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  iam_instance_profile {
    name = aws_iam_instance_profile.intro.name
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.intro.id]
  }
  tags = { Name = "Introduction" }
}

resource "aws_autoscaling_group" "intro" {
  name                 = "intro-asg"
  max_size             = 1
  min_size             = 1
  desired_capacity     = 1
  vpc_zone_identifier  = [aws_subnet.intro.id]
  launch_template {
    id      = aws_launch_template.intro.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "Introduction"
    propagate_at_launch = true
  }
}

resource "aws_instance" "intro" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.intro.id
  vpc_security_group_ids = [aws_security_group.intro.id]
  iam_instance_profile   = aws_iam_instance_profile.intro.name
  tags                   = { Name = "Introduction" }
}
