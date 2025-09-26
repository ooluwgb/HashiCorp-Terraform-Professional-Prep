output "S3_Users" {
  value = var.User_Name
}

output "instance_profile" {
  value = aws_iam_instance_profile.ec2_profile.name
}

