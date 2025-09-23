###########################################################################
#### FROM THE PROVIDED CSV FILE WE NEED TO IMPORT THE DATA INTO TERRAFORM
#### AND TRANSFORM IT INTO A LANGUAGE IT CAN UNDERSTAND. SINCE THIS IS 
#### A CSV FILE WE WILL BE USING CSVDECODE. THIS PRODUCES A LIST OF MAPS
#### UNCOMMENT EACH FUCTION AND ITS OUTPUT TO EXPLORE HOW THEY WORK
###########################################################################

locals {
  transformed_csv_data = csvdecode(file("./00_ec2_raw_data.csv")) 
}

/*

# THIS IS USED TO OUTPUT THE TRANSFORMED DATA THAT WILL BE STORED IN "transformed_csv_data"
output "transformed_csv_data" {
  value = local.transformed_csv_data
}

*/

/*

locals {
  number_of_instances = length(local.transformed_csv_data)   # Count items in the list
}
output "Number_of_Instance" {
  value = local.number_of_instances
}

*/

/*

locals {
  Instance_Names = [for k, v in local.transformed_csv_data : v.name ]   # For each map, return the value of "name"
}

output "Instance_Names" {
  value = local.Instance_Names
}

*/

/*

locals {
  list_of_unique_instance_type = toset([for k, v in local.transformed_csv_data : v.instance_type ])   # Return instance_type for each map, convert to set
}

output "List_of_Unique_Instances" {
  value = local.list_of_unique_instance_type
}
output "Note" {
  value = "Notice! There are no duplicates in the output list"
}

*/

/*

locals {
  Instances_AZ = [for k, v in local.transformed_csv_data : "Name:${v.name} AZ:${v.availability_zone}"]   # Format string with name + AZ
}

output "List_of_Instances_and_their_AZ" {
  value = local.Instances_AZ
}

*/

/*

locals {
  Instances_AZ_us_east_1a = [for k, v in local.transformed_csv_data : "Name:${v.name} AZ:${v.availability_zone}" if v.availability_zone == "us-east-1a"]   # Filter only if AZ == us-east-1a
}

output "List_of_Instance_in_us-east-1a" {
  value = local.Instances_AZ_us_east_1a
}

*/

/*

locals {
  list_of_map_of_set_of_attribute_for_each_instance = {for k, v in local.transformed_csv_data : v.name => {   # Use instance name as key
    "Name"          = v.name            # Map name
    "Instance_Type" = v.instance_type   # Map instance type
    "Ami_ID"        = v.ami             # Map AMI ID
  }}
}

output "List_of_Instances_in_us-east-1" {
  value = local.list_of_map_of_set_of_attribute_for_each_instance
}

*/
