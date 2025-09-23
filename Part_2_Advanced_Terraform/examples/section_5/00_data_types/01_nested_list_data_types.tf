#####################################
##### LIST DATA TYPE
#####################################

# List of lists
variable "list_of_lists" {
  type = list(list(string))
  default = [
    ["item1", "item2"],
    ["item3", "item4"]
  ]
}

# List of any (here using strings for consistency)
variable "list_of_any" {
  type = list(string)
  default = [
    "hello",
    "123",
    "true",
    "[nested,list]"
  ]
}

# List of strings
variable "list_of_strings" {
  type    = list(string)
  default = ["apple", "banana", "cherry"]
}

# List of numbers
variable "list_of_numbers" {
  type    = list(number)
  default = [10, 20, 30, 40]
}

# List of sets
variable "list_of_sets" {
  type = list(set(string))
  default = [
    ["a", "b"],
    ["c", "d"],
    ["e", "f"]
  ]
}

# List of maps
variable "list_of_maps" {
  type = list(map(string))
  default = [
    { name = "John", city = "New York" },
    { name = "Jane", city = "London" }
  ]
}

# List of objects
variable "list_of_objects" {
  type = list(object({
    id        = number
    name      = string
    is_active = bool
  }))
  default = [
    {
      id        = 1
      name      = "user01"
      is_active = true
    },
    {
      id        = 2
      name      = "user02"
      is_active = false
    }
  ]
}
