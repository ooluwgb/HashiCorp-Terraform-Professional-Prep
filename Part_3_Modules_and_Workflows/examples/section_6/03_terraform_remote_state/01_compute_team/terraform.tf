#######################################################################################
# TERRAFORM CONFIGURATION
#######################################################################################
# Specifies the required Terraform version, providers, and S3 backend for state storage.

terraform {
  required_version = ">= 1.13.3"

  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }

  backend "s3" {
    bucket = "terraformstatefileformyproject"
    key    = "compute/terraform.tfstate"
    region = "us-east-1"
  }
}

#######################################################################################
# AWS PROVIDERS (MULTI-REGION & ALIAS SETUP)
#######################################################################################

# Default provider for US West 1
provider "aws" {
  region = "us-west-1"
  alias  = "west1"
}

# Provider for US East 1
provider "aws" {
  region = "us-east-1"
  alias  = "east1"
}

# Provider for US West 2 with explicit access and secret keys
provider "aws" {
  region     = "us-west-2"
  access_key = data.terraform_remote_state.security.outputs.ghost_access_key   
  secret_key = data.terraform_remote_state.security.outputs.ghost_secret_key   
  alias      = "west2"
}

# Provider for Canada Central using shared config/credentials files
provider "aws" {
  shared_config_files      = ["${var.security_dir}${data.terraform_remote_state.security.outputs.aws_cli_conf_file}"]
  shared_credentials_files = ["${var.security_dir}${data.terraform_remote_state.security.outputs.aws_cli_creds_file}"]
  profile                  = "canada"
  alias                    = "ca-central-1"
}

# Provider for EU North with AssumeRole and shared config
provider "aws" {
  assume_role {
    role_arn     = data.terraform_remote_state.security.outputs.eu_north_role_arn
    session_name = "SESSION_NAME"
  }
  shared_config_files      = ["${var.security_dir}${data.terraform_remote_state.security.outputs.aws_cli_conf_file}"]
  shared_credentials_files = ["${var.security_dir}${data.terraform_remote_state.security.outputs.aws_cli_creds_file}"]
  profile                  = "the_architect"
  region                   = "eu-north-1"
  alias                    = "eu_north"
}
