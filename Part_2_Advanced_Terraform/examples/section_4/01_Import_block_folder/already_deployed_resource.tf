########################################
########### USE TO GRAB THE AMI ID
########################################

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

    owners = ["099720109477"]
}



#The data that was retrieved will be used to create an instance below

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "Created_Using_Ami_From_Data"
  }
}


########################################
########### USE OF COUNT
########################################

resource "aws_vpc" "count" {                        #Note that the count on this line is a label it can be any value you choose
    count = 2
    cidr_block = "10.0.0.0/16"
}

########################################
########### USE OF FOR_EACH
########################################

locals {
    user_name = ["User_1", "User_2"]
}


resource "aws_iam_user" "for_each" {                #Note that the for_each on this line is a label it can be any value you choose
    for_each = toset(local.user_name)                    #We will cover the for_each in section 5
    name = each.value
}


########################################
########### USE OF PROVIDER
########################################

provider "aws" {
    region = "us-west-1"
    alias = "west"
}

provider "aws" {
    region = "us-east-1"
    alias = "east"
}

###############################################################
#Provision resources in the west region using the west provider

resource "aws_vpc" "west_provider" {
    cidr_block = "10.0.0.0/16"
    provider = aws.west
}

resource "aws_subnet" "west_provider" {
    vpc_id = aws_vpc.west_provider.id
    provider = aws.west
    cidr_block = "10.0.1.0/24"
}

###############################################################
#Provision resources in the east region using the east provider

resource "aws_vpc" "east_provider" {
    cidr_block = "10.0.0.0/16"
    provider = aws.east
}

resource "aws_subnet" "east_provider" {
    vpc_id = aws_vpc.east_provider.id
    provider = aws.east
    cidr_block = "10.0.1.0/24"
}


########################################
########### USE OF LIFECYCLE
########################################

resource "aws_s3_bucket" "lifecycle" {
    bucket = "itigtusaveryuniquenamehere"                ##PLEASE CHANGE THE NAME ELSE YOUR CODE WILL FAIL!!!!!

    tags = {
      Name = "My_Lifecycle_Bucket"
      Environment = "Playground"
    }
    lifecycle {
        ignore_changes = [tags]                                         ##This ignores any changes made to the tags
    }
}


########################################
########### USE OF DEPENDS ON
########################################

#This user must be created before the attachment process can take place
resource "aws_iam_user" "test_user" {
    name = "Test_User"
}


#This requires that the user is already created before trying to add the policy to the user
#Note that the "aws_iam_policy_attachment" should note be confused for "aws_iam_user_policy_attachment"
#They perform different fuctions and "aws_iam_policy_attachment" can break your code if not used right
resource "aws_iam_user_policy_attachment" "depends_on" {
  user       = aws_iam_user.test_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"                    ##This arn is gotten from aws for admin access
}








##################################################################
##################################################################
######## DO NOT UNCOMMENT THIS, ITS FOR LEARNING PURPOSES ########
##################################################################
##################################################################


/*
#This will break your code because the "aws_iam_policy_attachment" acts as a universal manager for the policy
#Hence it will remove the admin permission policy from the terraform user because terraform is not added as part of the listed users
resource "aws_iam_policy_attachment" "depends_on" {
    name = "User_Admin_Policy"
    users = ["Test_User"]
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"             
    depends_on = [ aws_iam_user.test_user ]

}

*/


/*
#This will work just because the terraform user is added to the list to the users
#But note that once you run terraform destroy it will destroy the permission to manage resources
#Terraform will lose access to to remote state and also will leave a stale lock


resource "aws_iam_policy_attachment" "depends_on" {
    name = "User_Admin_Policy"
    users = ["Test_User", "terraform_use"]
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"             
    depends_on = [ aws_iam_user.test_user ]

}

*/