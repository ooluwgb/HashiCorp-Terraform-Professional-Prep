#######################################################################################
# INPUT VARIABLES
#######################################################################################

# Base name for the S3 bucket.
variable "bucket_name" {
  type    = string
  default = "the-architect"
}

# The EC2 instance type used for the launch template.
variable "instance_type" {
  description = "The EC2 instance type for the launch template."
  type        = string
  default     = "t3.micro"
}

# Directory where the security team keeps their code/configuration.
variable "security_dir" {
  description = "The directory where the security team keeps their code."
  default     = "../00_security_team/"
}
