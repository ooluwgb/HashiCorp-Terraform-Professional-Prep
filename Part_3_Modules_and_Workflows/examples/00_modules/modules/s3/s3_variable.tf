#######################################################
###### VARIABLES
#######################################################

# Bucket name (required, no default)
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

  validation {
    condition     = length(var.bucket_name) > 3 && length(var.bucket_name) <= 63
    error_message = "The bucket name must be between 3 and 63 characters."
  }
}

# Object key
variable "object_key" {
  description = "The key (path/filename) for the S3 object"
  type        = string
  default     = "example.txt"
}

# Object content
variable "content" {
  description = "The content to store inside the S3 object"
  type        = string
  default     = "Hello from The_Architect"
}
