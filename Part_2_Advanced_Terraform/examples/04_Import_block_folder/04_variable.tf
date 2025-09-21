##################################################################################################
####### VARIABLES FOR IMPORT PROCESS
####### These make it easy to fill in required IDs for import. 
####### Best practice: use variables for values that change frequently.
##################################################################################################

variable "vpc_0_ID" {
  type        = string
  description = "The ID of the first VPC created with count (e.g., vpc-xxxxxxxx)."
}

variable "vpc_1_ID" {
  type        = string
  description = "The ID of the second VPC created with count (e.g., vpc-xxxxxxxx)."
}

variable "user_1_name" {
  type        = string
  description = "The name of the first IAM user created with for_each (e.g., User_1)."
}

variable "user_2_name" {
  type        = string
  description = "The name of the second IAM user created with for_each (e.g., User_2)."
}

variable "vpc_west_id" {
  type        = string
  description = "The ID of the VPC created with the west provider alias."
}

variable "subnet_west_id" {
  type        = string
  description = "The ID of the subnet created with the west provider alias."
}

variable "vpc_east_id" {
  type        = string
  description = "The ID of the VPC created with the east provider alias."
}

variable "subnet_east_id" {
  type        = string
  description = "The ID of the subnet created with the east provider alias."
}

variable "bucket_id" {
  type        = string
  description = "The ID (or name) of the S3 bucket with lifecycle configuration."
}

variable "test_user_id" {
  type        = string
  description = "The name of the IAM user used in the policy attachment example."
}

variable "policy_attachment_id" {
  type        = string
  description = "The ID of the IAM policy attachment."
}

variable "instance_id" {
  type        = string
  description = "The ID of the EC2 instance created using a data source."
}
