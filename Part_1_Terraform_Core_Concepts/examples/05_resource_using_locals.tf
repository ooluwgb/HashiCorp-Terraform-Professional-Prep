################################################
##### USING LOCALS
################################################

locals {
  vpc_cidr      = "10.2.0.0/16"
  vpc_name      = "Local_VPC"
  subnet_cidr   = "10.2.1.0/24"
  subnet_name   = "Local_Subnet"
  instance_ami  = "ami-0360c520857e3138f"
  instance_type = "t2.micro"
  instance_name = "Local_Instance"
}

# This resource block provisions a VPC in the AWS cloud environment
resource "aws_vpc" "local_vpc" {
  cidr_block = local.vpc_cidr

  tags = {
    Name = local.vpc_name   # VPC name defined in locals
  }
}

# This resource block provisions a subnet inside the above VPC
resource "aws_subnet" "local_subnet" {
  vpc_id     = aws_vpc.local_vpc.id   # Reference to the VPC created above
  cidr_block = local.subnet_cidr      # Subnet CIDR from locals

  tags = {
    Name = local.subnet_name          # Subnet name defined in locals
  }
}

# This resource block provisions an EC2 instance inside the created subnet
resource "aws_instance" "local_instance" {
  ami           = local.instance_ami      # AMI from locals
  instance_type = local.instance_type     # Instance type from locals
  subnet_id     = aws_subnet.local_subnet.id   # Reference to the subnet created above

  tags = {
    Name = local.instance_name            # Instance name from locals
  }
}
