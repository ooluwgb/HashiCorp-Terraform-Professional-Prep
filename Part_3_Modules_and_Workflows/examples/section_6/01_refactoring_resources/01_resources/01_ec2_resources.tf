###############################################################################
# US WEST 1
###############################################################################
# Retrieves the latest Ubuntu 22.04 AMI and launches an EC2 instance in us-west-1.
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
# US EAST 1
###############################################################################
# Retrieves the latest Ubuntu 22.04 AMI and launches an EC2 instance in us-east-1.
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
# US WEST 2
###############################################################################
# Retrieves the latest Ubuntu 22.04 AMI and launches an EC2 instance in us-west-2.
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
# CANADA CENTRAL
###############################################################################
# Retrieves the latest Ubuntu 22.04 AMI and launches an EC2 instance in ca-central-1.
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
# EU NORTH 1
###############################################################################
# Retrieves the latest Ubuntu 22.04 AMI and launches an EC2 instance in eu-north-1.
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
