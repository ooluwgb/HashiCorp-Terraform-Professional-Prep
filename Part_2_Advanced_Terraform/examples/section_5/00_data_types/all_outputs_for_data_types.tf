################################################################################
############################    OUTPUTS    #####################################
################################################################################


################################################################################
#################    OUTPUTS FROM 00_data_types.tf    ##########################
################################################################################

# Output for the local variable "list"
output "local_list_output" {
  description = "Displays the value of the local variable 'list'."
  value       = local.list
}

# Output for the variable "list"
output "var_list_output" {
  description = "Displays the value of the variable 'list'."
  value       = var.list
}

# Output for the local variable "set"
output "local_set_output" {
  description = "Displays the value of the local variable 'set'."
  value       = local.set
}

# Output for the variable "set"
output "var_set_output" {
  description = "Displays the value of the variable 'set'."
  value       = var.set
}

# Output for the local variable "map"
output "local_map_output" {
  description = "Displays the value of the local variable 'map'."
  value       = local.map
}

# Output for the variable "map"
output "var_map_output" {
  description = "Displays the value of the variable 'map'."
  value       = var.map
}

# Output for the local variable "object"
output "local_object_output" {
  description = "Displays the value of the local variable 'object'."
  value       = local.object
}

# Output for the variable "user_object"
output "var_user_object_output" {
  description = "Displays the value of the variable 'user_object'."
  value       = var.user_object
}


################################################################################
#########    OUTPUTS FROM 00_data_types/01_nested_list_data_types.tf    ########
################################################################################

# Output for the variable "list_of_lists"
output "var_list_of_lists_output" {
  description = "Displays the value of the variable 'list_of_lists'."
  value       = var.list_of_lists
}

# Output for the variable "list_of_any"
output "var_list_of_any_output" {
  description = "Displays the value of the variable 'list_of_any'."
  value       = var.list_of_any
}

# Output for the variable "list_of_strings"
output "var_list_of_strings_output" {
  description = "Displays the value of the variable 'list_of_strings'."
  value       = var.list_of_strings
}

# Output for the variable "list_of_numbers"
output "var_list_of_numbers_output" {
  description = "Displays the value of the variable 'list_of_numbers'."
  value       = var.list_of_numbers
}

# Output for the variable "list_of_sets"
output "var_list_of_sets_output" {
  description = "Displays the value of the variable 'list_of_sets'."
  value       = var.list_of_sets
}

# Output for the variable "list_of_maps"
output "var_list_of_maps_output" {
  description = "Displays the value of the variable 'list_of_maps'."
  value       = var.list_of_maps
}

# Output for the variable "list_of_objects"
output "var_list_of_objects_output" {
  description = "Displays the value of the variable 'list_of_objects'."
  value       = var.list_of_objects
}


################################################################################
#########    OUTPUTS FROM 00_data_types/02_nested_map_data_types.tf    #########
################################################################################

# Output for the variable "map_of_strings"
output "var_map_of_strings_output" {
  description = "Displays the value of the variable 'map_of_strings'."
  value       = var.map_of_strings
}

# Output for the variable "map_of_numbers"
output "var_map_of_numbers_output" {
  description = "Displays the value of the variable 'map_of_numbers'."
  value       = var.map_of_numbers
}

# Output for the variable "map_of_bools"
output "var_map_of_bools_output" {
  description = "Displays the value of the variable 'map_of_bools'."
  value       = var.map_of_bools
}

# Output for the variable "map_of_lists"
output "var_map_of_lists_output" {
  description = "Displays the value of the variable 'map_of_lists'."
  value       = var.map_of_lists
}

# Output for the variable "map_of_sets"
output "var_map_of_sets_output" {
  description = "Displays the value of the variable 'map_of_sets'."
  value       = var.map_of_sets
}

# Output for the variable "map_of_maps"
output "var_map_of_maps_output" {
  description = "Displays the value of the variable 'map_of_maps'."
  value       = var.map_of_maps
}

# Output for the variable "map_of_objects"
output "var_map_of_objects_output" {
  description = "Displays the value of the variable 'map_of_objects'."
  value       = var.map_of_objects
}


################################################################################
########    OUTPUTS FROM 00_data_types/03_nested_object_data_types.tf    #######
################################################################################

# Output for the variable "simple_object"
output "var_simple_object_output" {
  description = "Displays the value of the variable 'simple_object'."
  value       = var.simple_object
}

# Output for the variable "object_with_bools"
output "var_object_with_bools_output" {
  description = "Displays the value of the variable 'object_with_bools'."
  value       = var.object_with_bools
}

# Output for the variable "object_with_list"
output "var_object_with_list_output" {
  description = "Displays the value of the variable 'object_with_list'."
  value       = var.object_with_list
}

# Output for the variable "object_with_set"
output "var_object_with_set_output" {
  description = "Displays the value of the variable 'object_with_set'."
  value       = var.object_with_set
}

# Output for the variable "object_with_map"
output "var_object_with_map_output" {
  description = "Displays the value of the variable 'object_with_map'."
  value       = var.object_with_map
}

# Output for the variable "object_of_objects"
output "var_object_of_objects_output" {
  description = "Displays the value of the variable 'object_of_objects'."
  value       = var.object_of_objects
}

# Output for the variable "object_with_list_of_objects"
output "var_object_with_list_of_objects_output" {
  description = "Displays the value of the variable 'object_with_list_of_objects'."
  value       = var.object_with_list_of_objects
}

# Output for the variable "object_with_map_of_objects"
output "var_object_with_map_of_objects_output" {
  description = "Displays the value of the variable 'object_with_map_of_objects'."
  value       = var.object_with_map_of_objects
}

# Output for the variable "deeply_nested_object"
output "var_deeply_nested_object_output" {
  description = "Displays the value of the variable 'deeply_nested_object'."
  value       = var.deeply_nested_object
}
