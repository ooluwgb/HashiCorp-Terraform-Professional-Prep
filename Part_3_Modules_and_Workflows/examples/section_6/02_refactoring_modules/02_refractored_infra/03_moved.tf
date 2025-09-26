################################################################################
############################   TERRAFORM STATE MOVES   #########################
################################################################################
# These `moved` blocks tell Terraform how to map existing resources
# from the old module structure into the new refactored modules.
# This avoids resource destruction/recreation during refactor.
################################################################################


#######################################################
###### COMPUTE RESOURCES (moved → module.infrastructure)
#######################################################

# Auto Scaling Group
moved {
  from = module.compute.aws_autoscaling_group.this
  to   = module.infrastructure.aws_autoscaling_group.this
}

# Launch Template
moved {
  from = module.compute.aws_launch_template.this
  to   = module.infrastructure.aws_launch_template.this
}

# EC2 Instances per region
moved {
  from = module.ec2_per_region.aws_instance.ca_central
  to   = module.infrastructure.aws_instance.ca_central
}

moved {
  from = module.ec2_per_region.aws_instance.east1
  to   = module.infrastructure.aws_instance.east1
}

moved {
  from = module.ec2_per_region.aws_instance.eu_north
  to   = module.infrastructure.aws_instance.eu_north
}

moved {
  from = module.ec2_per_region.aws_instance.west1
  to   = module.infrastructure.aws_instance.west1
}

moved {
  from = module.ec2_per_region.aws_instance.west2
  to   = module.infrastructure.aws_instance.west2
}

# S3 Bucket + Object
moved {
  from = module.s3.aws_s3_bucket.example
  to   = module.infrastructure.aws_s3_bucket.example
}

moved {
  from = module.s3.aws_s3_object.object
  to   = module.infrastructure.aws_s3_object.object
}


#######################################################
###### NETWORK & IDENTITY RESOURCES (moved → module.network_identity)
#######################################################

# VPC
moved {
  from = module.vpc.aws_vpc.main
  to   = module.network_identity.aws_vpc.main
}

# Subnets
moved {
  from = module.vpc.aws_subnet.main["10.0.1.0/24"]
  to   = module.network_identity.aws_subnet.main["10.0.1.0/24"]
}

moved {
  from = module.vpc.aws_subnet.main["10.0.2.0/24"]
  to   = module.network_identity.aws_subnet.main["10.0.2.0/24"]
}

# Security Group
moved {
  from = module.vpc.aws_security_group.allow_tls
  to   = module.network_identity.aws_security_group.allow_tls
}

# Security Group Rules
moved {
  from = module.vpc.aws_vpc_security_group_egress_rule.allow_all_traffic_ipv4["0"]
  to   = module.network_identity.aws_vpc_security_group_egress_rule.allow_all_traffic_ipv4["0"]
}

moved {
  from = module.vpc.aws_vpc_security_group_ingress_rule.allow_tls_ipv4["0"]
  to   = module.network_identity.aws_vpc_security_group_ingress_rule.allow_tls_ipv4["0"]
}

moved {
  from = module.vpc.aws_vpc_security_group_ingress_rule.allow_tls_ipv4["1"]
  to   = module.network_identity.aws_vpc_security_group_ingress_rule.allow_tls_ipv4["1"]
}

moved {
  from = module.vpc.aws_vpc_security_group_ingress_rule.allow_tls_ipv4["2"]
  to   = module.network_identity.aws_vpc_security_group_ingress_rule.allow_tls_ipv4["2"]
}


#######################################################
###### IAM RESOURCES (moved → module.network_identity)
#######################################################

# Instance Profile
moved {
  from = module.iam.aws_iam_instance_profile.ec2_profile
  to   = module.network_identity.aws_iam_instance_profile.ec2_profile
}

# IAM Role
moved {
  from = module.iam.aws_iam_role.ec2_role
  to   = module.network_identity.aws_iam_role.ec2_role
}

# IAM Policies
moved {
  from = module.iam.aws_iam_policy.policy
  to   = module.network_identity.aws_iam_policy.policy
}

moved {
  from = module.iam.aws_iam_policy.s3_policy
  to   = module.network_identity.aws_iam_policy.s3_policy
}

# IAM Role Policy Attachment
moved {
  from = module.iam.aws_iam_role_policy_attachment.test-attach
  to   = module.network_identity.aws_iam_role_policy_attachment.test-attach
}

# IAM User
moved {
  from = module.iam.aws_iam_user.test_user["S3_User"]
  to   = module.network_identity.aws_iam_user.test_user["S3_User"]
}

# IAM User Policy Attachment
moved {
  from = module.iam.aws_iam_user_policy_attachment.depends_on["S3_User"]
  to   = module.network_identity.aws_iam_user_policy_attachment.depends_on["S3_User"]
}