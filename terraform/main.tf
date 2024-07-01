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

module "storage_account" {
  source      = "./modules/storage_account"
  resource_group_name = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  project             = var.project
  environment         = var.environment
  sa-description      = var.sa-description

}

module "static_web_app" {
  source = "./modules/static_web_app"
  resource_group_name = azurerm_resource_group.rg.name
  project     = var.project
  environment = var.environment
  swa-description  = var.swa-description
  storage_account_name = data.azurerm_storage_account.sa.name
  resource_group_location = azurerm_resource_group.rg.location
  storage_account_access_key = data.azurerm_storage_account.sa.primary_access_key

    # only declared to create implicit dependency
  storage_account_id = data.azurerm_storage_account.sa.id
  resource_group_id = azurerm_resource_group.rg.id

   depends_on = [module.storage_account]
}

module "windows_function_app" {
  source              = "./modules/windows_function_app"
  resource_group_name = azurerm_resource_group.rg.name
  project             = var.project
  environment         = var.environment
  fa-description      = var.fa-description

  resource_group_location     = azurerm_resource_group.rg.location
  storage_account_name        = data.azurerm_storage_account.sa.name
  storage_account_access_key  = data.azurerm_storage_account.sa.primary_access_key

  # these are used for implicit dependency management
  service_plan_id     = azurerm_service_plan.sp.id
  resource_group_id   = azurerm_resource_group.rg.id  # creates a dependency on the resource group

  random_string_id = module.windows_function_app.random_string_id

  # only declared to create implicit dependency
  storage_account_id = data.azurerm_storage_account.sa.id
  static_web_app_id = module.static_web_app.id

   depends_on = [module.storage_account]
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
  name  = module.storage_account.storage_account_name    #"${var.project}${var.environment}${var.sa-description}sa"
  resource_group_name = azurerm_resource_group.rg.name

   depends_on = [module.storage_account]
}

# note: The tags attribute for a data source like azurerm_storage_account is computed based on the existing infrastructure and cannot be set in the configuration.


