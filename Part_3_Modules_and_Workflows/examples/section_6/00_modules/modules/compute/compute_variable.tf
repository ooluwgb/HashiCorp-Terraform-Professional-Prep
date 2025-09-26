#######################################################
###### VARIABLES FOR CHILD MODULE
#######################################################



# Instance type (validated for Free Tier in data source)
variable "instance_type" {
  description = "The EC2 instance type for the launch template"
  type        = string
  default     = "t3.micro"
}

# Security group IDs
variable "security_group_ids" {
  description = "List of security group IDs to associate with instances"
  type        = list(string)
}

# IAM instance profile
variable "instance_profile" {
  description = "IAM instance profile name to associate with instances"
  type        = string
}

# Subnet IDs for the autoscaling group
variable "subnet_ids" {
  description = "List of subnet IDs for the autoscaling group"
  type        = list(string)
}

# Autoscaling group min size
variable "asg_min_size" {
  description = "Minimum number of instances in the autoscaling group"
  type        = number
  default     = 1
}

# Autoscaling group max size
variable "asg_max_size" {
  description = "Maximum number of instances in the autoscaling group"
  type        = number
  default     = 3
}

# Autoscaling group desired capacity
variable "asg_desired_capacity" {
  description = "Desired number of instances in the autoscaling group"
  type        = number
  default     = 2
}
