# SECTION SIX

## Terraform Modules  
## Terraform Modules Variable  
## Terraform Modules Outputs  
## Terraform Random Provider  
## Terraform Import (Modules)  
## Terraform Moved Block (Modules)  
## Terraform Provider (Modules)(Default Tags)  

---

## TERRAFORM MODULES

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → BUILD AND USE MODULES  

A module is a collection of resource definitions that Terraform manages together.  
The `source` argument is required.  
Modules can also use arguments like `count` and `for_each`.  

```hcl
module "vpc" {
  source = "git::https://example.com/vpc.git?ref=v1.2.0"
  #source = "path_to_a_local_module_directory"             #This is also valid
}
```

---

## TERRAFORM MODULES VARIABLE

These are lists of variables that might be optional or required for the module.  
This depends on the child module (the resource configuration).  

- Variables required in a module are set in the child module.  
- The module block passes the variables to the child module.  
- Variables can also be set in the root module to be referenced in the root module block.  
- Same syntax for variables is used to set the variables.  

---

## TERRAFORM MODULES OUTPUTS

The outputs in the child module are used to expose values to the root module so that other root modules can reference them.  
All outputs needed in the root module must also be configured in the child module.  
The same syntax used for regular outputs is used for module outputs.  

---

## TERRAFORM RANDOM PROVIDER

**TYPE:** REGISTRY  
**DOCUMENTATION:** REGISTRY → BROWSE PROVIDERS → RANDOM → DOCUMENTATION  

The `random` provider allows the use of randomness within Terraform configurations.  
This is a logical provider, which means it works entirely within Terraform’s logic and doesn’t interact with external services.  

```hcl
# INSTALL THE PROVIDER
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

# CREATE THE RANDOM PET ID
resource "random_pet" "example" {
  length    = 2
  separator = "-"
}

# USE THE RANDOM PET ID
variable "random_pet" {
  default = random_pet.example.id
}
```

---

## TERRAFORM IMPORT BLOCK (MODULES)

This follows the same concept of the import block discussed in Section Four.  
The only difference is that the destination resource is inside a module.  

```hcl
import {
  to = module.instances.aws_instance.example   # Destination resource block within the module
  id = "i-abcd1234"
}
```

---

## TERRAFORM MOVED BLOCK (MODULES)

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → BUILD AND USE MODULES → DEVELOP MODULES → REFACTOR MODULES  

To prevent Terraform from destroying an existing resource and recreating it at another address,  
use the `moved` block to update the resource address without destroying it.  

Use cases include:  
- Move a resource or module  
- Rename a resource  
- Create multiple instances  
- Rename a module call  
- Split a module  

```hcl
moved {
  from = aws_instance.a
  to   = aws_instance.b
}
```

```hcl
moved {
  from = aws_instance.a
  to   = module.x.aws_instance.a
}
```

---

## TERRAFORM BLOCK (MODULE REQUIRED PROVIDER WITH ALIAS)(DEFAULT TAGS)

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → BUILD AND USE MODULES → DEVELOP MODULES → PROVIDER WITHIN MODULES  

Although provider configurations are shared between modules, each module must declare its own provider requirements.  

### Without Alias Configuration  

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
      configuration_aliases = [ aws.alternate ]
    }
  }
}
```

### With Alias Configuration (root module passes specific aliases)  

```hcl
provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
}

provider "aws" {
  alias  = "usw2"
  region = "us-west-2"
}

module "tunnel" {
  source    = "./tunnel"
  providers = {
    aws.src = aws.usw1
    aws.dst = aws.usw2
  }
}

#This block goes in the child module
terraform { 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
      configuration_aliases = [ aws.src, aws.dst ]
    }
  }
}
```

### With Expression and Default Tags  

```hcl
locals {
  common_tags = {
    Environment = "production"
    Project     = "web-app"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}
```
