#######################################################################################
# INPUT VARIABLE
#######################################################################################
# Defines the CIDR blocks for the subnets to be created.

variable "subnets_cidr" {
  description = "CIDR blocks for the subnets."
  type        = set(string)
}
