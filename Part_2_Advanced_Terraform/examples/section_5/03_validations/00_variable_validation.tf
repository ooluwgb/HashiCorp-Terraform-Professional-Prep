#############################################################################
###### VALIDATION EXAMPLES
#############################################################################

# Validate that the AMI ID provided is valid
variable "image_id" {
  type        = string
  description = "The ID of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"   # Must start with "ami-"
    error_message = "The image_id value must be a valid AMI ID, starting with \"ami-\"."
  }
}


# Validate that the instance type is Free Tier eligible
variable "instance_type" {
  type        = string
  description = "The instance type to use for the server."

  validation {
    condition = contains(   # Must be one of the allowed types
      ["t2.micro", "t3.micro", "t4g.micro"],
      var.instance_type
    )
    error_message = "The instance_type value must be one of the Free Tier eligible types: t2.micro, t3.micro, or t4g.micro."
  }
}
