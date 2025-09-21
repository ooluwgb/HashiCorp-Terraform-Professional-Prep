# SECTION ONE

## Installation of Terraform and Its Versions  
## Terraform Configuration  
## Terraform Block (Version)  
## Terraform Block (Required Provider)  
## Terraform Initialization

---

## INSTALLATION OF TERRAFORM

**DOCUMENTATION**  
<https://developer.hashicorp.com/terraform/>

### How to Install Terraform on macOS / Windows

- **DOCUMENTATION:** INSTALL

- **macOS** [1.13.2] [Latest Version]  
  ```bash
  brew tap hashicorp/tap  
  brew install hashicorp/tap/terraform
  ```

- **Windows**  
  <https://releases.hashicorp.com/terraform/1.13.2/terraform_1.13.2_windows_386.zip>

- **Terraform version check**  
  ```bash
  terraform version
  ```

---

## TERRAFORM CONFIGURATION

**TYPE:** CLI  
**DOCUMENTATION:** CLI → CONFIG → CONFIG-FILE → #PROVIDER-INSTALLATION

Terraform plugin caching is an important optimization: provider plugins are downloaded locally and can be reused. This avoids constant downloading of the same plugins across different projects or workspaces. Also useful for offline environments.

To configure caching for Terraform you can set an environment variable or create the `.terraformrc` / `terraform.rc` file.

- **Set as an environment variable**  
  ```bash
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
  ```

- **Set via `terraform.rc` (or `.terraformrc`) file**  
  ```bash
  mkdir -p ~/.terraform.d  
  cat > ~/.terraform.d/terraform.rc <<EOF
  plugin_cache_dir = "$HOME/.terraform.d/plugin-cache"
  EOF
  ```

  Or place the `terraform.rc` / `.terraformrc` file directly in the HOME directory without creating the folder.

---

**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCES → TERRAFORM INTERNALS → DEBUGGING

- To set the logs level of Terraform, set:  
  ```bash
  TF_LOG=<value>
  ```  
  Where `<value>` can be: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`

- To set where logs go:  
  ```bash
  TF_LOG_PATH=<file_path>
  ```

- To set Terraform mode to automation environment, set environment variable:  
  ```bash
  TF_IN_AUTOMATION=true
  ```  
  (or a non-empty value / `1`)

---

## TERRAFORM BLOCK

**TYPE:** LANGUAGE  
**DOCUMENTATION:** CONFIGURATION LANGUAGE → REFERENCE → CONFIGURATION BLOCKS → TERRAFORM

The `terraform` block is used to set configuration pertaining especially to Terraform; this includes required version, required providers, provider_meta, backend, cloud, and experiment.

```hcl
terraform {
  required_version = "<version constraint>"

  required_providers {
    <PROVIDER> {
      version = "provider version constraint"
      source  = "provider address"
    }
  }

  backend "<TYPE>" {
    # BACKEND SETTINGS
  }

  cloud {
    # TERRAFORM HCP SETTINGS
  }

  provider_meta "<LABEL>" {
    # Not needed for this certification
  }

  experiment = [ "<feature-name>" ]
}
```

---

## TERRAFORM BLOCK (VERSION)

This is used to set or constrain Terraform to a particular version or range of versions.

```hcl
terraform {
  required_version = "1.13.1"  # Note: this specifies the required Terraform version installed on your system
}
```

---

## TERRAFORM BLOCK (REQUIRED PROVIDER)

This sets the list of all provider plugins Terraform needs to download to be able to provision infrastructure.

```hcl
terraform {
  required_providers {
    aws = {    # note the "=" after the provider name
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
    azure = {  # note the "=" after the provider name
      version = "~> 4.41.0"
      source  = "hashicorp/azurerm"
    }
  }
}
```

---

## TERRAFORM BLOCK (REQUIRED PROVIDER MIRROR)

**TYPE:** CLI  
**DOCUMENTATION:** CLI → CONFIG → CONFIG-FILE

Used to install provider plugins from a specific location, overriding the normal installation of Terraform.

```hcl
provider_installation {
  filesystem_mirror {
    path    = "/usr/share/terraform/providers"
    include = ["example.com/*/*"]
  }
  direct {
    exclude = ["example.com/*/*"]
  }
}
```

---

## TERRAFORM INITIALIZATION

**TYPE:** CLI  
**DOCUMENTATION:** CLI → INITIALIZING WORKING DIRECTORIES

This is a Terraform command used to initialize Terraform; it causes Terraform to download required provider plugins.

```bash
terraform init                   # Regular initialization
terraform init -input=false      # Don’t accept any input
terraform init -upgrade          # Upgrade the plugins
terraform init -help             # Get help
terraform init -no-color         # No color in outputs
terraform init -reconfigure      # Reconfigure the backend
terraform init -backend=false    # Use previous backend configuration
```
