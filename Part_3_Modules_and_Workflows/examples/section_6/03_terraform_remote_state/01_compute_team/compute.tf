#######################################################################################
# DATA SOURCE: REMOTE STATE FOR SECURITY
#######################################################################################
# Retrieves outputs from a previously created Terraform state stored in S3.
# Make sure the bucket, key, and region match your existing remote state location.
data "terraform_remote_state" "security" {
  backend = "s3"
  config = {
    bucket = "terraformstatefileformyproject"
    key    = "security/terraform.tfstate"
    region = "us-east-1"
  }
}

#######################################################################################
# RANDOM PET NAME GENERATOR
#######################################################################################
# Generates a random, human-readable name suffix (e.g., "curious-cat") for unique resources.
resource "random_pet" "example" {
  length    = 2
  separator = "-"
}

#######################################################################################
# MAIN INFRASTRUCTURE MODULE
#######################################################################################
# Deploys infrastructure using the module in ../../02_refactoring_modules/modules/infrastructure.
# Passes in values retrieved from the remote state and custom variables.
module "infrastructure" {
  source = "../../02_refactoring_modules/modules/infrastructure"

  # Security and networking
  instance_profile    = data.terraform_remote_state.security.outputs.instance_profile
  security_group_ids  = [data.terraform_remote_state.security.outputs.security_group_id]
  subnet_ids          = data.terraform_remote_state.security.outputs.subnet_ids 

  # Resource naming and sizing
  bucket_name   = "the-architect-${random_pet.example.id}-${var.bucket_name}"
  instance_type = var.instance_type

  # Provider configurations
  providers = {
    aws.west1         = aws.west1
    aws.east1         = aws.east1
    aws.west2         = aws.west2
    aws.ca-central-1  = aws.ca-central-1
    aws.eu_north      = aws.eu_north
  }
}
