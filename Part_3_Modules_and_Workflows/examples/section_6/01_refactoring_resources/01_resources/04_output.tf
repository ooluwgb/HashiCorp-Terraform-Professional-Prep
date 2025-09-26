#######################################################
###### VPC OUTPUTS
#######################################################

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_ids" {
  description = "The IDs of the created subnets"
  value       = [for s in aws_subnet.main : s.id]
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.allow_tls.id
}


#######################################################
###### S3 OUTPUTS
#######################################################

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.example.bucket
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.example.arn
}


#######################################################
###### IAM OUTPUTS
#######################################################

output "iam_user_names" {
  description = "The IAM user names created"
  value       = [for u in aws_iam_user.test_user : u.name]
}

output "iam_role_name" {
  description = "The IAM role created for EC2"
  value       = aws_iam_role.ec2_role.name
}

output "iam_instance_profile" {
  description = "The IAM instance profile name for EC2"
  value       = aws_iam_instance_profile.ec2_profile.name
}


#######################################################
###### COMPUTE OUTPUTS
#######################################################

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.this.id
}

output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.name
}
