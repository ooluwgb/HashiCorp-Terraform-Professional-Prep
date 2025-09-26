#######################################################################################
# TERRAFORM CONFIGURATION
#######################################################################################
# Specifies the required Terraform version, AWS provider, and S3 backend for state storage.

terraform {
  required_version = ">= 1.13.3"

  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "terraformstatefileformyproject"
    key    = "security/terraform.tfstate"
    region = "us-east-1"
  }
}
