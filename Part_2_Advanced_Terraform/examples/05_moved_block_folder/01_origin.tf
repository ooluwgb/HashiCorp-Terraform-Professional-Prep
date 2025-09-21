#########################################################################
#### TO TEST THIS OUT YOU MUST FOLLOW 3 STEPS:
#### STEP 1: TERRAFORM APPLY – Create the original resources.
#### STEP 2: UNCOMMENT/COMMENT – Switch between resource and moved blocks.
#### STEP 3: MOVED STEP – Run terraform apply again. No resource 
####         should be created or destroyed (only moved in state).
##########################################################################

 #<<<<<<<<<<<<<<<<<<<<<<<< ADD THESE SYMBOLS WITHIN THE QOUTES ""/*"" BEFORE THE # SIGN ON THIS LINE AFTER YOU APPLYIED AND CREATED THE ORIGINAL RESOURCE


#For step one you need to apply and create these resources

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    assign_generated_ipv6_cidr_block = true
    tags = {
        Name = "VPC"
    }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



   #<<<<<<<<<<<<<<<<<<<<<<<< ADD THESE SYMBOLS WITHIN THE QUOTES ""*/"" BEFORE THE # SIGN ON THIS LINE AFTER YOU APPLYIED AND CREATED THE ORIGINAL RESOURCE