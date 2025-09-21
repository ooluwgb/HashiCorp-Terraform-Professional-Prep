# SECTION FOUR

## Terraform Block (Backend)  
## Terraform Meta-Argument  
## Terraform Data Block  
## Terraform Import Block (Resource)  
## Terraform Moved Block (Resource)  
## Terraform Removed Block (Resource)  

---

## TERRAFORM BLOCK (BACKEND)

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCKS → TERRAFORM  

This is used to configure the backend. A backend is persisted data that Terraform uses to track the resources it manages.  
This data can be stored locally or remotely. By default, it is stored locally until a remote location is set.  

```hcl
# This configures the state file to be in an S3 bucket
terraform {
  backend "s3" {
    bucket  = "" 
    key     = ""
    region  = ""
    profile = ""
  }
}
```

**EXAMPLE**  

```hcl
bucket       = "terraformstatefilemyproject"
key          = "envs/terraform.tfstate"
region       = "us-east-1"
use_lockfile = true
encrypt      = true
```

---

## TERRAFORM META-ARGUMENT

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → META-ARGUMENT  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCKS → RESOURCE  

These are Terraform built-in configurations that control how Terraform creates your infrastructure.  
They include: `count`, `for_each`, `provider`, `providers`, `lifecycle`, `depends_on`, `connection`, `provisioner`.  

```hcl
resource "aws_instance" "main" {
  count      = <number>
  for_each   = [ "<VALUE>" ]
  depends_on = [ <resource reference> ]
  provider   = <provider>.<alias>

  lifecycle {
    <lifecycle>
  }

  provisioner "file" {
    content = "<content>"
  }
}
```

**EXAMPLE**  

```hcl
resource "aws_iam_user" "test_user" {
  name = "Test_User"
}

# This requires that the user is already created before attaching the policy
resource "aws_iam_policy_attachment" "depends_on" {
  name       = "User_Admin_Policy"
  users      = ["Test_User"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"   # This ARN is from AWS for admin access
  depends_on = [ aws_iam_user.test_user ]
}
```

---

## TERRAFORM DATA BLOCK

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → QUERY INFRASTRUCTURE DATA  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCKS → DATA  

The data block is used to fetch data about a resource from the provider without provisioning an associated infrastructure object.  

```hcl
data "data_type" "label" {
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
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
```

---

## TERRAFORM IMPORT BLOCK

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → IMPORT EXISTING RESOURCES  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCKS → IMPORT  

The import block is used to instruct Terraform to import existing infrastructure resources into the list of resources being managed by Terraform.  
These resources are imported into the state file.  

```hcl
import {
  to       = resource.type.address
  id       = "cloud-provider-id"   # Cannot be used with identity
  provider = <provider>.<alias>
  for_each = []                    # Accepts map or set of strings
  identity = {}                    # Used to identify specific resource (outside exam scope)
}
```

**EXAMPLE**  

```hcl
import {
  to = aws_vpc.count[0]
  id = ""
}
```

**Note:** You can either manually write the resource configuration for the resource you want to import, or just specify the address and use Terraform to generate the resource configuration:  

```bash
terraform plan -generate-config-out="generated_resources.tf"
```

---

## TERRAFORM MOVED BLOCK

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → BUILD AND USE OF MODULES → REFACTOR MODULES  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCK → MOVED  

This is used to change the address of a resource from its old configuration code to a new destination configuration code.  
This prevents destruction and recreation of the resource even if the resource address has changed.  

```hcl
moved {
  from = <old address for the resource>
  to   = <new address for the resource>
}
```

**EXAMPLE**  

```hcl
moved {
  from = aws_vpc_security_group_egress_rule.allow_all_traffic_ipv6   # Old Address
  to   = aws_vpc_security_group_egress_rule.moved_ipv6               # New Address
}
```

---

## TERRAFORM REMOVED BLOCK (outside scope of exam)

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCK → REMOVED  

The removed block is used to remove a resource from the state without changing the underlying infrastructure.  

```hcl
removed {
  from = "<resource.address>"

  lifecycle {
    destroy = <true || false>
  }
}
```
