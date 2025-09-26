#######################################################
###### VPC VARIABLES
#######################################################

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC."
  type        = string
  default     = "The_Architect"
}

variable "subnets_cidr" {
  description = "CIDR blocks for the subnets."
  type        = set(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

  validation {
    condition     = length(var.subnets_cidr) <= 6
    error_message = "Maximum of six subnets allowed."
  }
}

#######################################################
###### SECURITY GROUP VARIABLES
#######################################################

variable "sg_name" {
  description = "Name of the security group."
  type        = string
  default     = "security_group"
}

variable "sg_description" {
  description = "Description for the security group."
  type        = string
  default     = "security_group"
}

variable "ingress" {
  description = "Ingress rules: port or port range, protocol, and CIDR."
  type = list(object({
    port        = string
    ip_protocol = string
    cidr_ipv4   = string
  }))

  default = [
    { port = "80",        ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" },
    { port = "22",        ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" },
    { port = "8080-8090", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" }
  ]

  validation {
    condition = alltrue([
      for rule in var.ingress : (
        rule.ip_protocol == "-1" ? rule.port == "0" : true
      )
    ])
    error_message = "If ip_protocol is -1 (all protocols), then port must be 0."
  }
}

variable "egress" {
  description = "Egress rules: port or port range, protocol, and CIDR."
  type = list(object({
    port        = string
    ip_protocol = string
    cidr_ipv4   = string
  }))

  default = [
    { port = "0", ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0" }
  ]
}

#######################################################
###### IAM VARIABLES
#######################################################

variable "User_Name" {
  description = "IAM user names to create."
  type        = set(string)
  default     = ["S3_User"]
}

#######################################################
###### S3 VARIABLES
#######################################################

variable "bucket_name" {
  description = "Name of the S3 bucket."
  type        = string
}

#######################################################
###### COMPUTE VARIABLES
#######################################################

variable "instance_type" {
  description = "EC2 instance type for the launch template and Auto Scaling Group."
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Minimum number of instances in the Auto Scaling Group."
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of instances in the Auto Scaling Group."
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group."
  type        = number
  default     = 2
}
