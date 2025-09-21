provider "aws" {
    region = "us-east-1"
    alias  = "east"       # Alias for AWS provider in the us-east-1 region
}

provider "aws" {
    region = "us-west-2"
    alias  = "west"       # Alias for AWS provider in the us-west-2 region
}

/*
######################################################################
## TO USE HARDCODED CREDENTIALS (Not recommended for production)
######################################################################
# This approach directly sets AWS credentials in the provider block.
# It is insecure and should only be used for testing purposes.
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"   # Replace with IAM access key
  secret_key = "my-secret-key"   # Replace with IAM secret key
}
*/

/*
######################################################################
## TO USE SHARED CONFIG FILES 
######################################################################
# This approach uses AWS CLI-style config and credentials files.
# Safer than hardcoding since it reuses AWS profiles stored locally.
provider "aws" {
  shared_config_files      = ["/Users/tf_user/.aws/conf"]   # Path to AWS config file
  shared_credentials_files = ["/Users/tf_user/.aws/creds"]  # Path to AWS credentials file
  profile                  = "customprofile"                # Named profile to use
}
*/
