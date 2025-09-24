#######################################################
###### S3 BUCKET AND OBJECT
#######################################################

# AWS S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "The_Architect"
  }
}

# AWS S3 object
resource "aws_s3_object" "object" {
  bucket  = aws_s3_bucket.example.bucket
  key     = var.object_key
  content = var.content
}
