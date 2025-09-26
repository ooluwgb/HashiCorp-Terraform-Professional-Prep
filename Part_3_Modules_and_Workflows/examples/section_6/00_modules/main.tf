##############################################################
###### ROOT MODULE – CALLING CHILD MODULES
##############################################################

# Generate random integer for unique bucket names
resource "random_integer" "example" {
  min = 100000
  max = 999999
}

##############################################################
###### IAM MODULE
##############################################################

module "iam" {
  source = "./modules/iam"
}

##############################################################
###### VPC MODULE
##############################################################

module "vpc" {
  source = "./modules/vpc"
}

##############################################################
###### S3 MODULE
##############################################################

module "s3" {
  source      = "./modules/s3"
  bucket_name = "${var.bucket_name}-${random_integer.example.result}" # required variable
  depends_on  = [random_integer.example]
}

##############################################################
###### COMPUTE MODULE
##############################################################

module "compute" {
  source             = "./modules/compute"
  subnet_ids         = module.vpc.subnet_ids             # list output from VPC module
  security_group_ids = [module.vpc.security_group_id]    # wrap if child exposes a single SG ID string
  instance_profile   = module.iam.instance_profile       # exposed by IAM module outputs
}
