# SECTION FIVE

## Terraform Data Type  
## Terraform Function  
## Terraform Expression  
## Terraform Variable (Validation)  
## Terraform Meta-Argument (Validation)  
## Terraform Check Block (Validation)  

---

## TERRAFORM DATA TYPE

**TYPE:** LANGUAGE  
**DOCUMENTATION:** PLUGIN DEVELOPMENT → FRAMEWORK → HANDLING DATA → TYPES → OVERVIEW  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → EXPRESSIONS → TYPE-CONSTRAINTS  

There are various data types in Terraform, and each data type must be transformed and configured for different use cases.  

- **list**  
  ```hcl
  ["value0", "value1", "value2"]
  ```  
  Ordered collection that can contain duplicate values. Elements are of a single type.  

- **set**  
  ```hcl
  ["uniquevalue1", "uniquevalue2", "uniquevalue3"]
  ```  
  Unordered collection of unique values of a single type.  

- **tuple**  
  ```hcl
  ["john.doe", 30, true]
  ```  
  Fixed-length list of values with different types. Order and type of each element are fixed.  

- **map**  
  ```hcl
  { key1 = "value1", key2 = "value2", key3 = "value3" }
  ```  
  Unordered collection of key-value pairs where all values are of a single type, keys are strings.  

- **object**  
  ```hcl
  { name = "John Doe", age = 30 }
  ```  
  Structured collection of key-value pairs with a fixed schema.  

---

## TERRAFORM FUNCTIONS

**TYPE:** LANGUAGE  
**DOCUMENTATION:** PLUGIN DEVELOPMENT → FRAMEWORK → FUNCTIONS → PARAMETERS → OVERVIEW  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → FUNCTIONS  

The Terraform language includes built-in functions you can call from within expressions to transform and combine values.  
General syntax:  

```hcl
FunctionName(arguments, arguments)
```

**EXAMPLE**  

```hcl
max(5, 12, 9)       # Returns 12
length(["a", "b"])  # Returns 2
```

**Note:** For this exam, essential functions are:  
`regex`, `split`, `upper`, `lower`, `length`, `jsondecode`, `jsonencode`, `csvdecode`, `yamldecode`,  
`file`, `can`, `tolist`, `tomap`, `toset`, `tonumber`, `tostring`, `try`

---

## TERRAFORM EXPRESSION

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → EXPRESSIONS  

Expressions compute values within a configuration. They can be references to values, operations, function calls, conditional expressions, for-expressions, splat expressions, and validations.  

```hcl
[for s in var.list : upper(s)]                       # Uppercase each item in list
[for k, v in var.map : length(k) + length(v)]        # Sum length of key + value
[for i, v in var.list : "${i} is ${v}"]              # Output "index is value"
condition ? true_val : false_val                     # Conditional expression
```

**Note:** Essential for exam: for-expressions, if statements, conditional expressions, function calls, splat expressions, type constraints, and version constraints.  

---

## TERRAFORM VARIABLE (VALIDATION)

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → TEST AND VALIDATE YOUR CONFIGURATION  

Used to verify input meets requirements, falls within acceptable ranges, and prevents misconfiguration.  
Validation is placed within the variable block. It has two parts: `condition` and `error_message`.  

**EXAMPLE**  

```hcl
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  }
}
```

---

## TERRAFORM META-ARGUMENT (VALIDATION)

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → TEST AND VALIDATE YOUR CONFIGURATION  

Same concept as variable validation but used in **precondition** and **postcondition** blocks.  
These validate resources and outputs, and live inside a `lifecycle` meta-argument.  

### Resource Validation  

```hcl
resource "aws_instance" "example" {
  instance_type = "t3.micro"
  ami           = data.aws_ami.example.id

  lifecycle {
    precondition {
      condition     = data.aws_ami.example.architecture == "x86_64"
      error_message = "The selected AMI must be for the x86_64 architecture."
    }
  }
}
```

### Output Validation  

```hcl
output "instance_public_ip" {
  value = aws_instance.web.public_ip

  precondition {
    condition     = length([for rule in aws_security_group.web.ingress : rule if rule.to_port == 80 || rule.to_port == 443]) > 0
    error_message = "Security group must allow HTTP (port 80) or HTTPS (port 443) traffic."
  }
}
```

### Data Source Validation  

```hcl
data "aws_ami" "example" {
  id = var.aws_ami_id

  lifecycle {
    postcondition {
      condition     = self.tags["Component"] == "nomad-server"
      error_message = "tags[\"Component\"] must be \"nomad-server\"."
    }
  }
}
```

---

## TERRAFORM CHECK BLOCK (VALIDATION)

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → TEST AND VALIDATE YOUR CONFIGURATION  

This is used to validate infrastructure outside of the typical resource lifecycle.  
When a check block's assertion fails, Terraform reports a warning and continues executing the current operation.  
Without the check block, a failing data source would block provisioning; with it, Terraform only warns and continues.  

**EXAMPLE**  

```hcl
check "health_check" {
  data "http" "terraform_io" {
    url = "https://www.terraform.io"
  }

  assert {
    condition     = data.http.terraform_io.status_code == 200
    error_message = "${data.http.terraform_io.url} returned an unhealthy status code"
  }
}
```
