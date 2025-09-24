#######################################################
###### VPC VARIABLES
#######################################################

variable "cidr_block" {
  description = "The CIDR block for the VPC, e.g., \"10.0.0.0/16\""
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "Main"
}


#######################################################
###### SUBNET VARIABLES
#######################################################

variable "subnets_cidr" {
  description = "CIDR blocks for subnets"
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
  description = "Name of the security group"
  type        = string
  default     = "security_group"
}

variable "sg_description" {
  description = "Description for the security group"
  type        = string
  default     = "security_group"
}

variable "ingress" {
  description = "Ingress rules: port or port range, protocol, and CIDR"
  type = list(object({
    port        = string
    ip_protocol = string
    cidr_ipv4   = string
  }))

  default = [
    { port = "80",       ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" },
    { port = "22",       ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" },
    { port = "8080-8090", ip_protocol = "tcp", cidr_ipv4 = "0.0.0.0/0" }
  ]
  validation {
    condition = alltrue([
      for rule in var.ingress : (
        rule.ip_protocol == "-1" ? length(rule.port) >= "1" : true
      )
    ])
    error_message = "If ip_protocol is -1 (all protocols), then port must be 0."
   }
}

variable "egress" {
  description = "Egress rules: port or port range, protocol, and CIDR"
  type = list(object({
    port        = string
    ip_protocol = string
    cidr_ipv4   = string
  }))

  default = [
    { port = "0", ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0" }
  ]
}
