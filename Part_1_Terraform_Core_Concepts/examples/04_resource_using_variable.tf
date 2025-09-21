################################################
##### USING VARIABLES 
################################################


# This resource block provisions a VPC in the AWS cloud environment
resource "aws_vpc" "variable_vpc" {
  cidr_block = var.vpc_cidr                             # CIDR block is provided through a variable

  tags = {
    Name = var.vpc_name                                 # VPC name is provided through a variable
  }
}

# This resource block provisions a subnet inside the above VPC
resource "aws_subnet" "variable_subnet" {
  vpc_id     = aws_vpc.variable_vpc.id                  # Reference to the VPC created above
  cidr_block = var.subnet_cidr                          # Subnet CIDR block is provided through a variable

  tags = {
    Name = var.subnet_name                              # Subnet name is provided through a variable
  }
}

# This resource block provisions an EC2 instance inside the created subnet
resource "aws_instance" "variable_instance" {
  ami           = var.instance_ami                      # AMI ID is provided through a variable
  instance_type = var.instance_type                     # Instance size is provided through a variable
  subnet_id     = aws_subnet.variable_subnet.id         # Reference to the subnet created above

  tags = {
    Name = var.instance_name                            # Instance name is provided through a variable
  }
}
