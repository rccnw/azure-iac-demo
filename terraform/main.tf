# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.0"
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
  name     = "${var.project}-${var.environment}-${var.rg-description}-rg"
  location = var.location
}


# Add Storage Account
resource "azurerm_storage_account" "sa" {

  name     = "${var.project}${var.environment}${var.sa-description}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.rg
  ]
  tags = {
    environment = var.environment
  }  
}

# Add Service Plan
resource "azurerm_service_plan" "sp" {
  name                = "${var.project}-${var.environment}-${var.sp-description}-sp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Windows"
  sku_name            = "Y1"

  depends_on = [
    azurerm_resource_group.rg
  ]
  tags = {
    environment = var.environment
  }
}

data "azurerm_storage_account" "sa" {
  name                = azurerm_storage_account.sa.name
  resource_group_name = azurerm_resource_group.rg.name

    depends_on = [
    azurerm_resource_group.rg
  ]

# note: The tags attribute for a data source like azurerm_storage_account is computed based on the existing infrastructure and cannot be set in the configuration.

}


resource "azurerm_static_web_app" "swa" {
  location            = azurerm_resource_group.rg.location
  name                = "${var.project}-${var.environment}-${var.swa-description}-swa"
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_storage_account.sa,
  ]

  tags = {
    environment = var.environment
  }  
}


resource "azurerm_windows_function_app" "fa" {
 name                       = "${var.project}-${var.environment}-${var.fa-description}-${random_string.unique.result}-fa"
 resource_group_name        = azurerm_resource_group.rg.name
 location                   = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  service_plan_id            = azurerm_service_plan.sp.id

  site_config {}

  depends_on = [
      random_string.unique,
      azurerm_resource_group.rg,
      azurerm_service_plan.sp,
      azurerm_storage_account.sa,
      azurerm_static_web_app.swa

  ]

  tags = {
    environment = var.environment
  }  
}


resource "random_string" "unique" {
  length  = 8
  special = false
  upper   = false
  keepers = {
    # Only regenerate when the service plan ID changes
    service_plan_id = azurerm_service_plan.sp.id
  }
} 
