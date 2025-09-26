terraform {
    required_version = ">= 1.13.3"
    required_providers {
        aws = {
            version = ">= 2.7.0"
            source = "hashicorp/aws"
        }
    }
    backend "s3" {
      bucket = "terraformstatefileformyproject"
      key = "refractored_modules/terraform.tfstate"
      region = "us-east-1"
    }
}

provider "aws" {
    region = "us-west-1"
    alias = "west1"
}

provider "aws" {
  region = "us-east-1"
  alias = "east1"
}

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIA5WA5UXXXXXXXXXX"                    #Check the .aws folder in 02_refactoring_modules for the txt file
  secret_key = "6iDjFDLOlCkdA7I6YhgkgyxyxKsSEfmcn7dDq"  #Check the .aws folder in 02_refactoring_modules for the txt file 
  alias = "west2"
}

provider "aws" {
  shared_config_files      = ["../.aws/conf"]
  shared_credentials_files = ["../.aws/creds"]
  profile                  = "canada"
  alias = "ca-central-1"
}

provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::XXXXXXXXXXXX:role/eu-north-ec2-create-delete-role"
    session_name = "SESSION_NAME"
  }
  shared_config_files      = ["../.aws/conf"]
  shared_credentials_files = ["../.aws/creds"]
  profile = "the_architect"
  region = "eu-north-1"
  alias = "eu_north"
}