variable "vpc_name" {
    type        = string
    description = "The name used for the VPC"
    default     = "Sub_VPC"
}

variable "vpc_cidr" {
    type        = string
    description = "The CIDR block used for the VPC"
    default     = "10.0.0.0/16"   
}

variable "subnet_name" {
    type        = string
    description = "The name used for the subnet" 
    default     = "Sub_Subnet"  
}

variable "subnet_cidr" {
    type        = string
    description = "The CIDR block used for the subnet"
    default     = "10.0.0.0/24" 
}

variable "instance_ami" {
    type        = string
    description = "The AMI value used to create the instance"
    default     = "ami-0360c520857e3138f"
}

variable "instance_type" {
    type        = string
    description = "The instance type that defines the size/class of the instance"
    default     = "t2.micro"
}

variable "instance_name" {
    type        = string
    description = "The name used for the instance"
    default     = "Sub_Instance"
}
