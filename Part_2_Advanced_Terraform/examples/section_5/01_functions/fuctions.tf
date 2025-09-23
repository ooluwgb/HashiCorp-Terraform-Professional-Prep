#####################################
##### RAW DATA FOR FUNCTION DEMOS
#####################################

locals {
  raw_string     = "Hello World"
  raw_number_str = "12345"
  raw_bad_number = "oops"
  raw_number     = 98765
  raw_list       = ["apple", "banana", "cherry"]
  raw_set_input  = ["a", "b", "a", "c"]
  raw_map_input  = { name = "Alice", role = "Admin" }
  raw_mixed_str  = "user42id"
}


#####################################
##### FUNCTION DEMONSTRATIONS
#####################################

# Use of upper() function
# Converts all letters in a string to uppercase.
output "upper_function" {
  value = upper(local.raw_string)
}

# Use of lower() function
# Converts all letters in a string to lowercase.
output "lower_function" {
  value = lower(local.raw_string)
}

# Use of length() function
# Returns the length of a string or the number of elements in a collection.
output "length_function" {
  value = length(local.raw_string)
}

# Use of tonumber() function
# Converts a string representing a number into an actual number.
output "tonumber_function" {
  value = tonumber(local.raw_number_str)
}

# Use of can() function
# Returns true if the expression can be evaluated without error.
output "can_function" {
  value = can(tonumber(local.raw_bad_number))
}

# Use of tolist() function
# Converts a given value into a list.
output "tolist_function" {
  value = tolist(local.raw_list)
}

# Use of toset() function
# Converts a given value into a set (removes duplicates).
output "toset_function" {
  value = toset(local.raw_set_input)
}

# Use of tostring() function
# Converts a number into a string.
output "tostring_function" {
  value = tostring(local.raw_number)
}

# Use of try() function
# Returns the first valid expression, otherwise a fallback value.
output "try_function" {
  value = try(tonumber(local.raw_bad_number), 0)
}

# Use of regex() function
# Extracts the first match of the pattern from a string.
output "regex_function" {
  value = regex("[0-9]+", local.raw_mixed_str)
}
