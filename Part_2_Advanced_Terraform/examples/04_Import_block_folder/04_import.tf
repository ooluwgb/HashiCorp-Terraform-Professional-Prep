#######################################################################################
############# IMPORTING RESOURCES CREATED IN PREVIOUS SECTIONS
#######################################################################################
# NOTE: For this to work, the resources in the previous section must still exist.
# You will need to obtain the required IDs for each resource from AWS or from the state file.
# To generate configuration for all these imports, run:
#   terraform plan -generate-config-out="generated_resources.tf"
# Then run:
#   terraform apply
# to actually import the resources into the state file.
#
# EASY WAY: Copy the configuration file directly from the previous section.

#######################################################################################
# Import the two AWS VPCs created with count
#######################################################################################
import {
    to = aws_vpc.count[0]
    id = var.vpc_0_ID    # ID of the first VPC created with count
}

import {
    to = aws_vpc.count[1]
    id = var.vpc_1_ID    # ID of the second VPC created with count
}

#######################################################################################
# Import the two IAM users created with for_each
#######################################################################################
import {
    to = aws_iam_user.for_each["User_1"]
    id = var.user_1_name   # Name of the first IAM user
}

import {
    to = aws_iam_user.for_each["User_2"]
    id = var.user_2_name   # Name of the second IAM user
}

#######################################################################################
# Import resources created with provider aliases (west and east regions)
#######################################################################################
import {
    to = aws_vpc.west_provider
    id = var.vpc_west_id   # ID of the VPC deployed with west provider
}

import {
    to = aws_subnet.west_provider
    id = var.subnet_west_id   # ID of the subnet deployed with west provider
}

import {
    to = aws_vpc.east_provider
    id = var.vpc_east_id   # ID of the VPC deployed with east provider
}

import {
    to = aws_subnet.east_provider
    id = var.subnet_east_id   # ID of the subnet deployed with east provider
}

#######################################################################################
# Import S3 bucket with lifecycle rules
#######################################################################################
import {
    to = aws_s3_bucket.lifecycle
    id = var.bucket_id   # Name/ID of the imported S3 bucket
}

#######################################################################################
# Import IAM user created for policy attachment example
#######################################################################################
import {
    to = aws_iam_user.test_user
    id = var.test_user_id   # Name of the IAM user
}

#######################################################################################
# Import IAM user policy attachment
#######################################################################################
import {
    to = aws_iam_user_policy_attachment.depends_on
    id = var.policy_attachment_id   # ID of the IAM policy attachment
}

#######################################################################################
# Import EC2 instance created with data source
#######################################################################################
import {
    to = aws_instance.example
    id = var.instance_id   # ID of the EC2 instance
}
