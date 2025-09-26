#######################################################################################
# MODULE CALLS
#######################################################################################

# Call the Network and Identity module
module "network_identity" {
  source       = "../../02_refactoring_modules/modules/network_and_identity"
  subnets_cidr = var.subnets_cidr
}

# Call the Prerequisite module
module "prequiste" {
  source = "../../02_refactoring_modules/modules/prerequiste"
}
