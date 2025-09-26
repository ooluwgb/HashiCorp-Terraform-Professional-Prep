#######################################################################################
# OUTPUT VALUES
#######################################################################################
# Exposes keys, config files, and network identity details for use in other modules.

# Access credentials
output "ghost_access_key" {
  value = module.prequiste.ghost_access_key
}

output "ghost_secret_key" {
  value      = module.prequiste.ghost_secret_key
  sensitive  = true
}

# AWS CLI configuration file paths
output "aws_cli_creds_file" {
  value = module.prequiste.aws_cli_creds_file
}

output "aws_cli_conf_file" {
  value = module.prequiste.aws_cli_conf_file
}

# IAM role ARN for EU North region
output "eu_north_role_arn" {
  value = module.prequiste.eu_north_role_arn
}

# S3 user details
output "S3_Users" {
  value = module.network_identity.S3_Users
}

# Instance profile for attached roles
output "instance_profile" {
  value = module.network_identity.instance_profile
}

#######################################################################################
# NETWORKING OUTPUTS
#######################################################################################

# VPC ID
output "vpc_id" {
  description = "The ID of the created VPC."
  value       = module.network_identity.vpc_id
}

# Subnet IDs
output "subnet_ids" {
  description = "The IDs of the created subnets."
  value       = module.network_identity.subnet_ids
}

# Security Group ID
output "security_group_id" {
  description = "The ID of the created security group."
  value       = module.network_identity.security_group_id
}
