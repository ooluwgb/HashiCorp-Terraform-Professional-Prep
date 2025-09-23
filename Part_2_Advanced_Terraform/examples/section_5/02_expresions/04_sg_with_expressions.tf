#############################################################################
######### WE IMPORT THE CSV DATA INTO USABLE DATA FOR TERRAFORM
#############################################################################

locals {
  transformed_sg_csv_data = csvdecode(file("./03_sg_raw_data.csv"))
  ingress_data            = {for k, v in local.transformed_sg_csv_data : k => v if v.direction == "in" }   # Keep only ingress rules
  egress_data             = {for k, v in local.transformed_sg_csv_data : k => v if v.direction == "out" }  # Keep only egress rules
}


#############################################################################
######### TESTING OUTPUT
#############################################################################

# Print out the transformed data for testing
output "sg_content" {
  value = local.transformed_sg_csv_data
}


#############################################################################
######### CREATE A DEDICATED VPC
#############################################################################

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}


#############################################################################
######### CREATE SECURITY GROUP AND RULES FROM EXPRESSIONS
#############################################################################

# Security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

# Ingress rules
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  for_each          = local.ingress_data
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = each.value.cidr_blocks
  from_port         = try(split("-", each.value.port)[0], each.value.port)   # Extract start port if range
  ip_protocol       = each.value.protocol
  to_port           = try(split("-", each.value.port)[1], each.value.port)   # Extract end port if range
  description       = each.value.description
}

# Egress rules
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  for_each          = local.egress_data
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = each.value.cidr_blocks
  from_port         = try(split("-", each.value.port)[0], each.value.port)   # Extract start port if range
  ip_protocol       = each.value.protocol
  to_port           = try(split("-", each.value.port)[1], each.value.port)   # Extract end port if range
  description       = each.value.description
}
