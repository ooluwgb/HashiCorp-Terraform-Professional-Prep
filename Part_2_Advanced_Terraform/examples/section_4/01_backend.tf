terraform {
  backend "s3" {
    bucket       = "<BUCKET_NAME>"      # Placeholder for S3 bucket name
    key          = "<STATE_FILE_PATH>"  # Placeholder for state file path
    region       = "us-east-1"   
    use_lockfile = true
    encrypt      = true
  }
}
