#######################################################
###### OUTPUTS
#######################################################

# Output VPC ID
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

# Output Subnet IDs
output "subnet_ids" {
  description = "The IDs of the created subnets"
  value       = [for s in aws_subnet.main : s.id]
}

# Output Security Group ID
output "security_group_id" {
  description = "The ID of the created security group"
  value       = aws_security_group.allow_tls.id
}
