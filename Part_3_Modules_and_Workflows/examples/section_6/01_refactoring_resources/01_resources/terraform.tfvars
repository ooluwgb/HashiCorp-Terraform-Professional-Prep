#######################################################################################
# VARIABLE VALUES (TFVARS)
#######################################################################################
# These values override the defaults defined in variables.tf.

bucket_name   = "the-architect"          # Base name for the S3 bucket
instance_type = "t3.micro"               # EC2 instance type
subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24"] # CIDR blocks for the subnets
vpc_name      = "The_Architect"          # Name to assign to the VPC
