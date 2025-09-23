#####################################
##### LIST DATA TYPE
#####################################

locals {
  list = ["user0", "user1", "user2", "James", "Paul", "James"] 
  # Quotes and commas are mandatory, as well as the required square brackets.
  # Multiple repetitions of data are allowed.
  # NOTE: This is a list of all strings.
}

variable "list" {
  description = "A list of usernames"
  type        = list(string)
  default     = ["user0", "user1", "user2", "James", "Paul", "James"]
}


#####################################
##### SET DATA TYPE
#####################################

locals {
  set = ["user0", "user1", "user2", "James", "Paul"] 
  # Quotes and commas are mandatory, as well as the required square brackets.
  # Multiple repetitions of data are allowed, but they will be ignored.
  # NOTE: This is a set of all strings.
}

variable "set" {
  description = "A unique set of usernames."
  type        = set(string)
  default     = ["user0", "user1", "user2", "James", "Paul"]
}


#####################################
##### MAP DATA TYPE
#####################################

# A map is not strict with the structure of keys and values.
locals {
  map = {
    Name   = "UserName"   # String
    Age    = 24           # Number
    Gender = "male"       # String
    Minor  = false        # Boolean
  }
}

variable "map" {
  description = "A map containing user details."
  type        = map(any)
  default = {
    Name   = "UserName"
    Age    = 24
    Gender = "male"
    Minor  = false
  }
}


#####################################
##### OBJECT DATA TYPE
#####################################

locals {
  object = {
    name = "UserName"
    age  = 24
    city = "Anytown"
  }
}

variable "user_object" {
  description = "An object containing user information."
  type = object({                   # For the object data type, you must define the structure.
    name = string
    age  = number
    city = string
  })
  default = {
    name = "UserName"
    age  = 24
    city = "Anytown"
  }
}
