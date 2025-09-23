#####################################
##### OBJECT DATA TYPE
#####################################

# Simple object
variable "simple_object" {
  description = "An object with simple attributes."
  type = object({
    id    = number
    name  = string
    email = string
  })
  default = {
    id    = 1
    name  = "Alice"
    email = "alice@example.com"
  }
}

# Object with booleans
variable "object_with_bools" {
  description = "An object with boolean flags."
  type = object({
    is_admin   = bool
    is_active  = bool
    is_premium = bool
  })
  default = {
    is_admin   = true
    is_active  = false
    is_premium = true
  }
}

# Object with a list
variable "object_with_list" {
  description = "An object containing a list of strings."
  type = object({
    name  = string
    roles = list(string)
  })
  default = {
    name  = "Bob"
    roles = ["developer", "admin", "tester"]
  }
}

# Object with a set
variable "object_with_set" {
  description = "An object containing a set of tags."
  type = object({
    id   = number
    tags = set(string)
  })
  default = {
    id   = 101
    tags = ["dev", "staging"]
  }
}

# Object with a map
variable "object_with_map" {
  description = "An object containing a map of attributes."
  type = object({
    user_id  = number
    settings = map(string)
  })
  default = {
    user_id  = 200
    settings = {
      theme = "dark"
      lang  = "en"
    }
  }
}

# Object of objects
variable "object_of_objects" {
  description = "An object where each attribute is another object."
  type = object({
    database = object({
      engine = string
      size   = number
    })
    cache = object({
      type  = string
      nodes = number
    })
  })
  default = {
    database = {
      engine = "postgres"
      size   = 20
    }
    cache = {
      type  = "redis"
      nodes = 3
    }
  }
}

# Object with a list of objects
variable "object_with_list_of_objects" {
  description = "An object containing a list of objects."
  type = object({
    team_name = string
    members   = list(object({
      name  = string
      role  = string
      score = number
    }))
  })
  default = {
    team_name = "Team Alpha"
    members = [
      { name = "Carol", role = "lead", score = 95 },
      { name = "Dave",  role = "dev",  score = 88 }
    ]
  }
}

# Object with a map of objects
variable "object_with_map_of_objects" {
  description = "An object containing a map of objects."
  type = object({
    service_name = string
    configs      = map(object({
      enabled = bool
      limit   = number
    }))
  })
  default = {
    service_name = "ServiceX"
    configs = {
      config1 = { enabled = true,  limit = 100 }
      config2 = { enabled = false, limit = 50  }
    }
  }
}

# Deeply nested object (object > map > list > object)
variable "deeply_nested_object" {
  description = "An object with complex nested structures."
  type = object({
    project      = string
    environments = map(list(object({
      region   = string
      replicas = number
    })))
  })
  default = {
    project = "MyProject"
    environments = {
      dev = [
        { region = "us-east-1", replicas = 2 },
        { region = "us-west-1", replicas = 1 }
      ]
      prod = [
        { region = "us-east-1", replicas = 5 },
        { region = "us-west-2", replicas = 3 }
      ]
    }
  }
}
