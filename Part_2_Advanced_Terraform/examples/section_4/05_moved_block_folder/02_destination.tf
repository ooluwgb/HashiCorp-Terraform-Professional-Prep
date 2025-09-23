##############################################################
###### TO UNCOMMENT THE RESOURCE CONFIGURATION BELOW: 
###### REMOVE THE "/*" AT THE BEGINNING AND THE END OF THE CODE
##############################################################

/* #<<<<<<<<<<<<<<<<<<<<<<<< REMOVE THOSE SYMBOLS BEFORE THE # SIGN ON THIS LINE AFTER YOU APPLYIED AND CREATED THE ORIGINAL RESOURCE

resource "aws_vpc" "moved" {
    cidr_block = "10.0.0.0/16"
    assign_generated_ipv6_cidr_block = true
    tags = {
        Name = "VPC"
    }
}


resource "aws_security_group" "moved" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.moved.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "moved_ipv4" {
  security_group_id = aws_security_group.moved.id
  cidr_ipv4         = aws_vpc.moved.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "moved_ipv6" {
  security_group_id = aws_security_group.moved.id
  cidr_ipv6         = aws_vpc.moved.ipv6_cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "moved_ipv4" {
  security_group_id = aws_security_group.moved.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "moved_ipv6" {
  security_group_id = aws_security_group.moved.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



*/ #<<<<<<<<<<<<<<<<<<<<<<<< REMOVE THOSE SYMBOLS BEFORE THE # SIGN ON THIS LINE AFTER YOU APPLYIED AND CREATED THE ORIGINAL RESOURCE

 