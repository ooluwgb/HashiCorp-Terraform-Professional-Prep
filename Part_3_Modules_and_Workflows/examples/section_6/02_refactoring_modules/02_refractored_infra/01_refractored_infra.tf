#######################################################################################
# RANDOM NAME GENERATOR
#######################################################################################
# Generates a random pet name to create unique bucket names.
resource "random_pet" "example" {
  length    = 2
  separator = "-"
}

#######################################################################################
# NETWORK & IDENTITY MODULE
#######################################################################################
module "network_identity" {
  source = "../modules/network_and_identity"
}

#######################################################################################
# INFRASTRUCTURE MODULE
#######################################################################################
module "infrastructure" {
  source             = "../modules/infrastructure"
  instance_profile   = module.network_identity.instance_profile
  security_group_ids = [module.network_identity.security_group_id]
  subnet_ids         = module.network_identity.subnet_ids
  bucket_name        = "the-architect-${random_pet.example.id}-${var.bucket_name}"

  providers = {
    aws.west1        = aws.west1
    aws.east1        = aws.east1
    aws.west2        = aws.west2
    aws.ca-central-1 = aws.ca-central-1
    aws.eu_north     = aws.eu_north
  }
}
