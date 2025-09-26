#######################################################
###### OUTPUTS
#######################################################

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.this.id
}

output "autoscaling_group_id" {
  description = "The ID of the autoscaling group"
  value       = aws_autoscaling_group.this.id
}

#######################################################
###### OUTPUTS
#######################################################

# Output bucket name
output "bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.example.bucket
}

# Output object key
output "object_key" {
  description = "The key of the S3 object"
  value       = aws_s3_object.object.key
}

# Output object content
output "object_content" {
  description = "The content of the S3 object"
  value       = aws_s3_object.object.content
}
