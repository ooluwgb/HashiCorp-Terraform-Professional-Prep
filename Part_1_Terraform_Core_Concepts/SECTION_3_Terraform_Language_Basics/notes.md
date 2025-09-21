# SECTION THREE

## Terraform Resources Block  
## Terraform Variable Block  
## Terraform Locals Block  
## Terraform Output Block  

---

## TERRAFORM RESOURCE BLOCK

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCK → RESOURCE  

The resource block is used to define a piece of infrastructure and its specific settings for Terraform to create.  
Once the necessary valid resource configurations are declared:  
- `terraform plan` is used to verify what Terraform will create  
- `terraform apply` is used to apply the changes proposed by the plan  

```hcl
resource "resource_type" "label" {
  provider_argument = "value"
  provider          = <provider>.<alias>
  depends_on        = "value"
  for_each          = "value"
  count             = "value"

  lifecycle {
    create_before_destroy = <boolean>
    prevent_destroy       = <boolean>
    ignore_changes        = [ <attribute> ]
  }

  precondition {
    condition     = <expression>
    error_message = "<message>"
  }

  postcondition {
    condition     = <expression>
    error_message = "<message>"
  }
}
```

**EXAMPLE**  

```hcl
# This resource block creates an EC2 instance (VM)
resource "aws_instance" "this" {
  ami                     = "ami-0dcc1e21636832c5d"
  instance_type           = "m5.large"
  host_resource_group_arn = "arn:aws:resource-groups:us-west-2:123456789012:group/win-testhost"
  tenancy                 = "host"
}

# This resource block creates a VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}
```

---

## TERRAFORM VARIABLE BLOCK

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCK → VARIABLE  

This is used to parameterize configuration. It makes the code reusable by being able to pass in different variables.  

```hcl
variable "<LABEL>" {
  type        = <TYPE>
  default     = <DEFAULT_VALUE>   # Set a default value for the variable
  description = "<DESCRIPTION>"
  sensitive   = <true|false>
  nullable    = <true|false>      # Specify if the value of the variable can be null
  ephemeral   = <true|false>      # Prevent from storing in state

  validation {
    condition     = <EXPRESSION>
    error_message = "<ERROR_MESSAGE>"
  }
}
```

**EXAMPLE**  

```hcl
variable "availability_zone_names" {
  type        = list(string)
  description = "List of availability zones where resources will be deployed."
  default     = ["us-west-1a"]
}
```

---

## TERRAFORM LOCALS BLOCK

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCK → LOCALS  

This is used to define values and reuse them within the Terraform configuration.  

```hcl
locals {
  <LOCAL_NAME>      = <EXPRESSION>
  <OTHER_LOCAL_NAME> = <OTHER_EXPRESSION>
}
```

**EXAMPLE**  

```hcl
locals {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.micro"
}
```

---

## TERRAFORM OUTPUT BLOCK

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCK → OUTPUT  

This is used to expose information about the infrastructure.  

```hcl
output "<LABEL>" {
  value       = <EXPRESSION>
  description = "<STRING>"       # Comment about the output
  sensitive   = <true|false>     # For sensitive data
  ephemeral   = <true|false>     # Prevent from storing in state
  depends_on  = [<REFERENCE>]

  precondition {
    condition     = <EXPRESSION>
    error_message = "<STRING>"
  }
}
```

**EXAMPLE**  

```hcl
output "db_password" {
  value       = aws_db_instance.db.password
  description = "The database password."
  sensitive   = true
}
```
