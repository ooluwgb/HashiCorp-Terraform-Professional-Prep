#######################################################
###### VPC
#######################################################

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}


#######################################################
###### SUBNETS
#######################################################

resource "aws_subnet" "main" {
  for_each   = var.subnets_cidr
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = {
    Name = "${var.vpc_name}-subnet-${each.key}"
  }
}


#######################################################
###### SECURITY GROUP
#######################################################

resource "aws_security_group" "allow_tls" {
  name        = "${var.vpc_name}-${var.sg_name}"
  description = var.sg_description
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-${var.sg_name}"
  }
}


#######################################################
###### INGRESS RULES
#######################################################

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  for_each          = { for idx, rule in var.ingress : idx => rule }
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = tonumber(try(split("-", each.value.port)[0], each.value.port))
  to_port           = tonumber(try(split("-", each.value.port)[1], each.value.port))
  ip_protocol       = each.value.ip_protocol
}


#######################################################
###### EGRESS RULES
#######################################################

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  for_each          = { for idx, rule in var.egress : idx => rule }
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = each.value.cidr_ipv4
  #from_port         = tonumber(try(split("-", each.value.port)[0], each.value.port))
  #to_port           = tonumber(try(split("-", each.value.port)[1], each.value.port))
  ip_protocol       = each.value.ip_protocol
}
