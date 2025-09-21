################################################
##### HARDCODED VALUES 
################################################

# This resource block provisions a VPC in the AWS cloud environment
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Main_VPC"   # Tag assigned to the VPC
  }
}

# This resource block provisions a subnet inside the above VPC
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id   # Reference to the VPC created above
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main_Subnet"   # Tag assigned to the subnet
  }
}

# This resource block provisions an EC2 instance inside the created subnet
resource "aws_instance" "main" {
  ami           = "ami-0360c520857e3138f"   # Amazon Machine Image ID
  instance_type = "t2.micro"                # Instance size
  subnet_id     = aws_subnet.main.id        # Reference to the subnet created above

  tags = {
    Name = "Main_Instance"   # Tag assigned to the instance
  }
}
