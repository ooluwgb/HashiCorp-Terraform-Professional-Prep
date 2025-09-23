#######################################################
###### USING THE DATA TO CREATE RESOURCES
#######################################################

# BECAUSE THE for_each META-ARGUMENT ONLY ACCEPTS SETS OF STRINGS OR MAPS,
# WE WILL TRANSFORM THE ORIGINAL "transformed_csv_data" INTO A MAP.
# THE ORIGINAL LOCALS IS IN THE 01_expressions.tf FILE.

locals {
  intances = {for k, v in local.transformed_csv_data : v.name => v}   # Use instance name as the unique key
  # intances = {for k, v in local.transformed_csv_data : k => v}      # Alternative: use the CSV row index (key) if no unique identifier exists
}

resource "aws_instance" "csv_data" {
  for_each          = local.intances
  ami               = each.value.ami
  instance_type     = each.value.instance_type
  availability_zone = each.value.availability_zone
}
