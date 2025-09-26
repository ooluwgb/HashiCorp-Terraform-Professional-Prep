##############################################################
###### ROOT MODULE OUTPUTS
##############################################################

# IAM outputs
output "instance_profile" {
  description = "The IAM instance profile created in IAM module"
  value       = module.iam.instance_profile
}

# VPC outputs
output "vpc_id" {
  description = "The VPC ID created in VPC module"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "The Subnet IDs created in VPC module"
  value       = module.vpc.subnet_ids
}

output "security_group_id" {
  description = "The Security Group ID created in VPC module"
  value       = module.vpc.security_group_id
}

# S3 outputs
output "bucket_name" {
  description = "The S3 bucket name created in S3 module"
  value       = module.s3.bucket_name
}

# Compute outputs
output "launch_template_id" {
  description = "The Launch Template ID created in Compute module"
  value       = module.compute.launch_template_id
}

output "autoscaling_group_id" {
  description = "The AutoScaling Group ID created in Compute module"
  value       = module.compute.autoscaling_group_id
}
