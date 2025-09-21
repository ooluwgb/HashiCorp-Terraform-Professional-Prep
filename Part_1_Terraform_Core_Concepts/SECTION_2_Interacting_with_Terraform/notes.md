# SECTION TWO

## Terraform Provider (Block)  
## Terraform Plan  
## Terraform Apply  
## Terraform Destroy  

---

## TERRAFORM PROVIDER BLOCKS

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCK → PROVIDER  

This is used to supply more information to Terraform about the listed required providers.  
This supports `alias`, and provider-specific arguments.  

```hcl
provider "<PROVIDERNAME>" {
  alias = "testing"               # This is used to configure multiple providers
  provider_argument = "values"
}
```

**EXAMPLE**  

```hcl
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}

provider "aws" {
  region = "us-west-2"
  alias  = "west"
}
```

---

## TERRAFORM PROVIDER BLOCK (AWS)

**TYPE:** REGISTRY  
**DOCUMENTATION:** REGISTRY → AWS → DOCUMENTATION → AWS PROVIDER  

With this block you can provide extra configuration for the AWS provider that Terraform will use to provision infrastructure.  
This block can be used to configure region, authentication, and other settings.  

### Hardcoded authentication and region
```hcl
provider "aws" {
  region     = "us-east-1"
  access_key = "my-access-key"     # Create the access_key from AWS IAM services for the set user
  secret_key = "my-secret-key"     # Create the secret_key from AWS IAM services for the set user
}
```

### Authentication with shared files
```hcl
provider "aws" {
  shared_config_files      = ["/Users/tf_user/.aws/conf"]
  shared_credentials_files = ["/Users/tf_user/.aws/creds"]
  profile                  = "customprofile"
}
```

### Authentication using assume role
```hcl
provider "aws" {
  assume_role {
    role_arn     = "arn:aws:iam::123456789012:role/ROLE_NAME"
    session_name = "SESSION_NAME"
    external_id  = "EXTERNAL_ID"
  }
}
```

**Note:** Terraform can also use the standard AWS CLI configure settings to authenticate with AWS.  
It looks for the `.aws` directory in the HOME directory of the user.

---

## TERRAFORM PLAN

**TYPE:** CLI  
**DOCUMENTATION:** CLI → PROVISIONING INFRASTRUCTURE → PLAN  

Plan is a Terraform command used to generate the plan that will be executed by Terraform based on the current code configuration.  
There are various flags that can be used alongside it for different purposes, usually in an automated environment.  

```bash
terraform plan
terraform plan -help                     # Get help with the plan option
terraform plan -out=path                 # Generate a plan file to the path specified
terraform plan -destroy                  # Generate a plan for a destroy
terraform plan -input=false              # Generate a plan without expecting input from the terminal
terraform plan -generate-config-out=path # Generate a configuration file for imported resources
terraform plan -no-color                 # No colors in outputs
```

---

## TERRAFORM APPLY

**TYPE:** CLI  
**DOCUMENTATION:** CLI → PROVISIONING INFRASTRUCTURE → APPLY  

Apply is used to execute the actions proposed in a Terraform plan.  

```bash
terraform apply
terraform apply -auto-approve        # Auto approve without prompting for yes
terraform apply -input=false         # Does not expect any inputs
terraform apply -no-color            # Outputs with no colors
terraform apply -var-file=filename   # Provide the variables file during apply
terraform apply <plan.tf>            # Provide the plan file to execute
terraform apply -help                # Get help
terraform apply -destroy             # Same as terraform destroy (destroys resources)
```

---

## TERRAFORM DESTROY

**TYPE:** CLI  
**DOCUMENTATION:** CLI → PROVISIONING INFRASTRUCTURE → DESTROY  

Used to destroy all the resources currently managed by Terraform in its state file.  

```bash
terraform destroy   # Equivalent to terraform apply -destroy
```
