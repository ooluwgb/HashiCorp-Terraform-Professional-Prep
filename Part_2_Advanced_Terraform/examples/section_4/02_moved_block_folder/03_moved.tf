/* #<<<<<<<<<<<<<<<<<<<<<<<< REMOVE THOSE SYMBOLS BEFORE THE # SIGN ON THIS LINE AFTER YOU APPLYIED AND CREATED THE ORIGINAL RESOURCE


# Move the "aws_vpc main" to "aws_vpc moved"
moved {
  from = aws_vpc.main
  to   = aws_vpc.moved
}

# Move the "aws_security_group allow_tls" to "aws_security_group moved"
moved {
  from = aws_security_group.allow_tls
  to   = aws_security_group.moved
}

# Move the "aws_vpc_security_group_ingress_rule allow_tls_ipv4" to "aws_vpc_security_group_ingress_rule moved_ipv4"
moved {
  from = aws_vpc_security_group_ingress_rule.allow_tls_ipv4
  to   = aws_vpc_security_group_ingress_rule.moved_ipv4
}

# Move the "aws_vpc_security_group_ingress_rule allow_tls_ipv6" to "aws_vpc_security_group_ingress_rule moved_ipv6"
moved {
  from = aws_vpc_security_group_ingress_rule.allow_tls_ipv6
  to   = aws_vpc_security_group_ingress_rule.moved_ipv6
}

# Move the "aws_vpc_security_group_egress_rule allow_all_traffic_ipv4" to "aws_vpc_security_group_egress_rule moved_ipv4"
moved {
  from = aws_vpc_security_group_egress_rule.allow_all_traffic_ipv4
  to   = aws_vpc_security_group_egress_rule.moved_ipv4 
}

# Move the "aws_vpc_security_group_egress_rule allow_all_traffic_ipv6" to "aws_vpc_security_group_egress_rule moved_ipv6"
moved {
  from = aws_vpc_security_group_egress_rule.allow_all_traffic_ipv6
  to   = aws_vpc_security_group_egress_rule.moved_ipv6
}



*/ #<<<<<<<<<<<<<<<<<<<<<<<< REMOVE THOSE SYMBOLS BEFORE THE # SIGN ON THIS LINE AFTER YOU APPLYIED AND CREATED THE ORIGINAL RESOURCE