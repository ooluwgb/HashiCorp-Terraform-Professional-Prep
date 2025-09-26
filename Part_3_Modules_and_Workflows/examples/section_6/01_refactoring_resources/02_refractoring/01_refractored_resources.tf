##############################################################
###### ROOT MODULE – CALLING CHILD MODULES
##############################################################

# Generate a random pet name for unique bucket names
resource "random_pet" "example" {
  length    = 2
  separator = "-"
}

##############################################################
###### IAM MODULE
##############################################################

module "iam" {
  source = "../../00_modules/modules/iam"
}

##############################################################
###### VPC MODULE
##############################################################

module "vpc" {
  source = "../../00_modules/modules/vpc"
}

##############################################################
###### S3 MODULE
##############################################################

module "s3" {
  source      = "../../00_modules/modules/s3"
  bucket_name = "the-architect-${random_pet.example.id}-${var.bucket_name}" # Required variable
}

# You can move this variable definition into a separate variables file if preferred.
variable "bucket_name" {
  type    = string
  default = "the-architect"
}

##############################################################
###### COMPUTE MODULE
##############################################################

module "compute" {
  source             = "../../00_modules/modules/compute"
  subnet_ids         = module.vpc.subnet_ids             # List output from VPC module
  security_group_ids = [module.vpc.security_group_id]    # Wrap if child exposes a single SG ID string
  instance_profile   = module.iam.instance_profile       # Exposed by IAM module outputs
}

##############################################################
###### EC2 PER REGION
##############################################################

module "ec2_per_region" {
  source = "../../00_modules/modules/ec2"
  providers = {
    aws.west1        = aws.west1
    aws.east1        = aws.east1
    aws.west2        = aws.west2
    aws.ca-central-1 = aws.ca-central-1
    aws.eu_north     = aws.eu_north
  }
}
