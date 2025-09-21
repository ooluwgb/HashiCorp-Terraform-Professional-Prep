################################################################################
########### LIST OF IDS AND NAMES NEEDED FOR IMPORT
########### Update these values after each terraform apply/destroy cycle,
########### because they change when Terraform recreates resources.
########### Standard way to provide variable values.
################################################################################

vpc_0_ID                 = "<VPC_0_ID>"
vpc_1_ID                 = "<VPC_1_ID>"
user_1_name              = "<USER_1_NAME>"
user_2_name              = "<USER_2_NAME>"
vpc_west_id              = "<VPC_WEST_ID>"
subnet_west_id           = "<SUBNET_WEST_ID>"
vpc_east_id              = "<VPC_EAST_ID>"
subnet_east_id           = "<SUBNET_EAST_ID>"
bucket_id                = "<BUCKET_ID>"
test_user_id             = "<TEST_USER_ID>"
policy_attachment_id     = "<USER_NAME/POLICY_ARN"                      #NOTE THIS IS A COMBINATION OF USER'S NAME AND THE POLICY THAT WAS ATTACHED TO THE USER SEPERATED BY A "/" SYMBOL 
instance_id              = "<INSTANCE_ID>"
