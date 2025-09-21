########################################
########### USE OF COUNT
########################################

# Note: the label "count" is arbitrary, you can choose any valid name.
resource "aws_vpc" "count" {
    count      = 2
    cidr_block = "10.0.0.0/16"
}

########################################
########### USE OF FOR_EACH
########################################

locals {
    user_name = ["User_1", "User_2"]
}

# Note: the label "for_each" is arbitrary, you can choose any valid name.
resource "aws_iam_user" "for_each" {
    for_each = toset(local.user_name)   # Converts the list to a set for iteration
    name     = each.value               # Creates one IAM user per element
}

########################################
########### USE OF PROVIDER
########################################

# Defining providers with aliases for multiple region deployments
provider "aws" {
    region = "us-west-1"
    alias  = "west"
}

provider "aws" {
    region = "us-east-1"
    alias  = "east"
}

###############################################################
# Provision resources in the west region using the west provider

resource "aws_vpc" "west_provider" {
    cidr_block = "10.0.0.0/16"
    provider   = aws.west
}

resource "aws_subnet" "west_provider" {
    vpc_id     = aws_vpc.west_provider.id
    provider   = aws.west
    cidr_block = "10.0.1.0/24"
}

###############################################################
# Provision resources in the east region using the east provider

resource "aws_vpc" "east_provider" {
    cidr_block = "10.0.0.0/16"
    provider   = aws.east
}

resource "aws_subnet" "east_provider" {
    vpc_id     = aws_vpc.east_provider.id
    provider   = aws.east
    cidr_block = "10.0.1.0/24"
}

########################################
########### USE OF LIFECYCLE
########################################

resource "aws_s3_bucket" "lifecycle" {
    bucket = "itigtusaveryuniquenamehere"   ## PLEASE CHANGE THE NAME ELSE YOUR CODE WILL FAIL!

    tags = {
      Name        = "My_Lifecycle_Bucket"
      Environment = "Playground"
    }

    lifecycle {
        ignore_changes = [tags]   ## Ignores any changes made to tags after creation
    }
}

########################################
########### USE OF DEPENDS ON
########################################

# This user must be created before the attachment process can take place
resource "aws_iam_user" "test_user" {
    name = "Test_User"
}

# This requires that the user is already created before trying to attach the policy
# NOTE: Do not confuse "aws_iam_policy_attachment" with "aws_iam_user_policy_attachment"
# They perform different functions, and "aws_iam_policy_attachment" can break your code if misused
resource "aws_iam_user_policy_attachment" "depends_on" {
  user       = aws_iam_user.test_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"   ## This ARN is obtained from AWS for admin access
}

##################################################################
##################################################################
######## DO NOT UNCOMMENT THIS, FOR LEARNING PURPOSES ONLY ########
##################################################################
##################################################################

/*
# This will break your code because "aws_iam_policy_attachment" acts as a universal manager for the policy.
# It will remove the admin permission policy from the Terraform user since Terraform is not included in the listed users.
resource "aws_iam_policy_attachment" "depends_on" {
    name       = "User_Admin_Policy"
    users      = ["Test_User"]
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    depends_on = [ aws_iam_user.test_user ]
}
*/

/*
# This will work because the Terraform user is added to the list of users.
# BUT note: once you run `terraform destroy`, it will also remove the permission Terraform needs to manage resources.
# Terraform will then lose access to remote state and may leave behind a stale lock.
resource "aws_iam_policy_attachment" "depends_on" {
    name       = "User_Admin_Policy"
    users      = ["Test_User", "terraform_use"]
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    depends_on = [ aws_iam_user.test_user ]
}
*/
