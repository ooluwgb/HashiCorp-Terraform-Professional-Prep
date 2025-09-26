#######################################################
###### DATA SOURCES
#######################################################

# Validate instance type for Free Tier eligibility
data "aws_ec2_instance_type" "example" {
  instance_type = var.instance_type

  lifecycle {
    postcondition {
      condition     = self.free_tier_eligible == true
      error_message = "The chosen instance_type is not Free Tier eligible."
    }
  }
}

# Fetch latest Ubuntu 22.04 AMI
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
###### LAUNCH TEMPLATE
#######################################################

resource "aws_launch_template" "this" {
  name_prefix   = "asg-template-"
  image_id      = data.aws_ami.example.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile
  }

  tags = {
    Name = "asg-template"
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_group_ids
  }

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }
}


#######################################################
###### AUTOSCALING GROUP
#######################################################

resource "aws_autoscaling_group" "this" {
  name                      = "asg_name"
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  desired_capacity          = var.asg_desired_capacity
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  vpc_zone_identifier       = var.subnet_ids              ##IF YOU ARE HAVING ISSUES WITH DEPLOYING DUE TO US-EAST-1E COMMENT THIS LINE

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


#######################################################
###### S3 BUCKET AND OBJECT
#######################################################

# AWS S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "The_Architect"
  }
}

# AWS S3 object
resource "aws_s3_object" "object" {
  bucket  = aws_s3_bucket.example.bucket
  key     = var.object_key
  content = var.content
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
      configuration_aliases = [ aws.west1, aws.east1, aws.west2, aws.ca-central-1, aws.eu_north ]
    }
  }
}


###############################################################################
# us-west-1
###############################################################################
data "aws_ami" "west1" {
  provider    = aws.west1
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "west1" {
  provider      = aws.west1
  ami           = data.aws_ami.west1.id
  instance_type = var.instance_type

  tags = {
    Name     = "ec2-us-west-1"
    Provider = "west1"
  }
}

###############################################################################
# us-east-1
###############################################################################
data "aws_ami" "east1" {
  provider    = aws.east1
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "east1" {
  provider      = aws.east1
  ami           = data.aws_ami.east1.id
  instance_type = var.instance_type

  tags = {
    Name     = "ec2-us-east-1"
    Provider = "east1"
  }
}

###############################################################################
# us-west-2
###############################################################################
data "aws_ami" "west2" {
  provider    = aws.west2
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "west2" {
  provider      = aws.west2
  ami           = data.aws_ami.west2.id
  instance_type = var.instance_type

  tags = {
    Name     = "ec2-us-west-2"
    Provider = "west2"
  }
}

###############################################################################
# ca-central-1
###############################################################################
data "aws_ami" "ca_central" {
  provider    = aws.ca-central-1
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "ca_central" {
  provider      = aws.ca-central-1
  ami           = data.aws_ami.ca_central.id
  instance_type = var.instance_type

  tags = {
    Name     = "ec2-ca-central-1"
    Provider = "ca-central-1"
  }
}

###############################################################################
# eu-north-1
###############################################################################
data "aws_ami" "eu_north" {
  provider    = aws.eu_north
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "eu_north" {
  provider      = aws.eu_north
  ami           = data.aws_ami.eu_north.id
  instance_type = var.instance_type

  tags = {
    Name     = "ec2-eu-north-1"
    Provider = "eu_north"
  }
}
