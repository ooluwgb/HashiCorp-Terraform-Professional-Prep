terraform {
  required_version = ">= 1.13.3"   # Ensure Terraform version compatibility

  required_providers {
    aws = {                       # AWS provider definition
      version = ">= 2.7.0"        # Minimum AWS provider version
      source  = "hashicorp/aws"   # Source registry for AWS provider
    }
    azurerm = {                   # AzureRM provider definition
      version = "~> 4.41.0"       # Allow compatible updates to 4.x
      source  = "hashicorp/azurerm"
    }
  }
}
