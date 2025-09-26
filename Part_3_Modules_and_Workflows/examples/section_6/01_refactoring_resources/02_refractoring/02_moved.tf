################################################################################
##########################   TERRAFORM STATE MOVES   ###########################
################################################################################
# These `moved` blocks tell Terraform how to map existing resources
# from the flat root configuration into their new module addresses.
# This prevents Terraform from destroying and recreating infrastructure.
################################################################################

#######################################################
###### VPC MODULE MIGRATION
#######################################################

# Move the VPC resource into the VPC module
moved {
  from = aws_vpc.main
  to   = module.vpc.aws_vpc.main
}

# Move Subnet-1 into the VPC module
moved {
  from = aws_subnet.main["10.0.1.0/24"]
  to   = module.vpc.aws_subnet.main["10.0.1.0/24"]
}

# Move Subnet-2 into the VPC module
moved {
  from = aws_subnet.main["10.0.2.0/24"]
  to   = module.vpc.aws_subnet.main["10.0.2.0/24"]
}

# Move Security Group into the VPC module
moved {
  from = aws_security_group.allow_tls
  to   = module.vpc.aws_security_group.allow_tls
}

# Move Security Group Egress Rule (all protocols) into the VPC module
moved {
  from = aws_vpc_security_group_egress_rule.all_protocols["0"]
  to   = module.vpc.aws_vpc_security_group_egress_rule.allow_all_traffic_ipv4["0"]
}

# Move Security Group Ingress Rule: HTTP (80)
moved {
  from = aws_vpc_security_group_ingress_rule.allow_tls_ipv4["0"]
  to   = module.vpc.aws_vpc_security_group_ingress_rule.allow_tls_ipv4["0"]
}

# Move Security Group Ingress Rule: SSH (22)
moved {
  from = aws_vpc_security_group_ingress_rule.allow_tls_ipv4["1"]
  to   = module.vpc.aws_vpc_security_group_ingress_rule.allow_tls_ipv4["1"]
}

# Move Security Group Ingress Rule: Custom Range (8080–8090)
moved {
  from = aws_vpc_security_group_ingress_rule.allow_tls_ipv4["2"]
  to   = module.vpc.aws_vpc_security_group_ingress_rule.allow_tls_ipv4["2"]
}

#######################################################
###### COMPUTE MODULE MIGRATION
#######################################################

# Move Auto Scaling Group into the Compute module
moved {
  from = aws_autoscaling_group.this
  to   = module.compute.aws_autoscaling_group.this
}

# Move Launch Template into the Compute module
moved {
  from = aws_launch_template.this
  to   = module.compute.aws_launch_template.this
}

# Move EC2 instance in ca-central-1 into the Compute module
moved {
  from = aws_instance.ca_central
  to   = module.ec2_per_region.aws_instance.ca_central
}

# Move EC2 instance in us-east-1 into the Compute module
moved {
  from = aws_instance.east1
  to   = module.ec2_per_region.aws_instance.east1
}

# Move EC2 instance in eu-north-1 into the Compute module
moved {
  from = aws_instance.eu_north
  to   = module.ec2_per_region.aws_instance.eu_north
}

# Move EC2 instance in us-west-1 into the Compute module
moved {
  from = aws_instance.west1
  to   = module.ec2_per_region.aws_instance.west1
}

# Move EC2 instance in us-west-2 into the Compute module
moved {
  from = aws_instance.west2
  to   = module.ec2_per_region.aws_instance.west2
}

#######################################################
###### IAM MODULE MIGRATION
#######################################################

# Move IAM Instance Profile into the IAM module
moved {
  from = aws_iam_instance_profile.ec2_profile
  to   = module.iam.aws_iam_instance_profile.ec2_profile
}

# Move IAM Role into the IAM module
moved {
  from = aws_iam_role.ec2_role
  to   = module.iam.aws_iam_role.ec2_role
}

# Move IAM Policy (EC2 Describe*) into the IAM module
moved {
  from = aws_iam_policy.policy
  to   = module.iam.aws_iam_policy.policy
}

# Move IAM Policy (S3*) into the IAM module
moved {
  from = aws_iam_policy.s3_policy
  to   = module.iam.aws_iam_policy.s3_policy
}

# Move IAM Role Policy Attachment into the IAM module
moved {
  from = aws_iam_role_policy_attachment.test-attach
  to   = module.iam.aws_iam_role_policy_attachment.test-attach
}

# Move IAM User into the IAM module
moved {
  from = aws_iam_user.test_user["S3_User"]
  to   = module.iam.aws_iam_user.test_user["S3_User"]
}

# Move IAM User Policy Attachment into the IAM module
moved {
  from = aws_iam_user_policy_attachment.depends_on["S3_User"]
  to   = module.iam.aws_iam_user_policy_attachment.depends_on["S3_User"]
}

#######################################################
###### S3 MODULE MIGRATION
#######################################################

# Move S3 Bucket into the S3 module
moved {
  from = aws_s3_bucket.example
  to   = module.s3.aws_s3_bucket.example
}

# Move S3 Object into the S3 module
moved {
  from = aws_s3_object.object
  to   = module.s3.aws_s3_object.object
}
