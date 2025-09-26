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
