#####################################
##### MAP DATA TYPE
#####################################

# Map of strings
variable "map_of_strings" {
  type = map(string)
  default = {
    fruit1 = "apple"
    fruit2 = "banana"
    fruit3 = "cherry"
  }
}

# Map of numbers
variable "map_of_numbers" {
  type = map(number)
  default = {
    one   = 1
    two   = 2
    three = 3
  }
}

# Map of booleans
variable "map_of_bools" {
  type = map(bool)
  default = {
    featureA = true
    featureB = false
    featureC = true
  }
}

# Map of lists
variable "map_of_lists" {
  type = map(list(string))
  default = {
    fruits  = ["apple", "banana", "cherry"]
    animals = ["cat", "dog", "lion"]
  }
}

# Map of sets
variable "map_of_sets" {
  type = map(set(string))
  default = {
    group1 = ["a", "b"]
    group2 = ["c", "d"]
  }
}

# Map of maps
variable "map_of_maps" {
  type = map(map(string))
  default = {
    user1 = { name = "John",  city = "New York" }
    user2 = { name = "Jane",  city = "London"   }
    user3 = { name = "Alice", city = "Paris"    }
  }
}

# Map of objects
variable "map_of_objects" {
  type = map(object({
    id        = number
    is_active = bool
    tags      = list(string)
  }))
  default = {
    user1 = {
      id        = 1
      is_active = true
      tags      = ["dev", "team1"]
    }
    user2 = {
      id        = 2
      is_active = false
      tags      = ["ops", "team2"]
    }
  }
}
