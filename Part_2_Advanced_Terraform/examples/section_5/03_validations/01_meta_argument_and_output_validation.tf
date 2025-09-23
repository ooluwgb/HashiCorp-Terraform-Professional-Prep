#############################################################################
###### RESOURCE CREATION WITH VALIDATION AND LIFECYCLE CONDITIONS
#############################################################################

# The AMI ID must refer to an AMI that contains an operating system
# for the x86_64 architecture.
resource "aws_instance" "example" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.example.id

  lifecycle {
    precondition {
      condition     = data.aws_ami.example.architecture == "x86_64"
      error_message = "The selected AMI must be for the x86_64 architecture."
    }
  }
}


#############################################################################
###### CREATE INSTANCE
#############################################################################

resource "aws_instance" "web" {
  ami           = var.image_id
  instance_type = var.instance_type
}


#############################################################################
###### SECURITY GROUP FOR WEB TRAFFIC
#############################################################################

# Security group for web traffic in the default VPC
resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Allow HTTP and HTTPS traffic"
}

# Ingress rule: HTTP
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP"
}

# Ensure the security group allows HTTP (80) or HTTPS (443)
output "instance_public_ip" {
  value = aws_instance.web.public_ip

  precondition {
    condition     = length([for rule in aws_security_group.web.ingress : rule if rule.to_port == 80 || rule.to_port == 443]) > 0
    error_message = "Security group must allow HTTP (port 80) or HTTPS (port 443) traffic."
  }
}


#############################################################################
###### DATA SOURCE: VALIDATE AMI
#############################################################################

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
    # Validate that the AMI is available and has x86_64 architecture
    postcondition {
      condition     = self.architecture == "x86_64" && self.state == "available"
      error_message = "The Ubuntu AMI must be x86_64 architecture and in 'available' state."
    }
  }
}


#############################################################################
###### DATA SOURCE: VALIDATE INSTANCE TYPE
#############################################################################

# Ensure the selected instance type is Free Tier eligible
data "aws_ec2_instance_type" "example" {
  instance_type = var.instance_type

  lifecycle {
    postcondition {
      condition     = self.free_tier_eligible == true
      error_message = "The chosen instance_type is not Free Tier eligible."
    }
  }
}
