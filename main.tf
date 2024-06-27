
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
        source  = "hashicorp/azurerm"
        version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}


resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = local.environment_location
}

# Read environment variables

locals {
  default_location     = "westus2"
  environment_location = var.location != "" ? var.location : local.default_location
}