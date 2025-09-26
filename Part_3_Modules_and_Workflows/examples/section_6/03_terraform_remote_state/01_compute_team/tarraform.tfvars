#######################################################################################
# VARIABLE VALUES (TFVARS)
#######################################################################################
# These values override the defaults defined in variables.tf.

bucket_name   = "the-architect"       # Base name for the S3 bucket
instance_type = "t3.micro"            # EC2 instance type for the launch template
security_dir  = "../00_security_team/" # Directory where the security team keeps their code
