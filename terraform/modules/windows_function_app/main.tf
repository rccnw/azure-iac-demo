

resource "azurerm_windows_function_app" "fa" {
 name                       = "${var.project}-${var.environment}-${var.fa-description}-${random_string.unique.result}-fa"
 resource_group_name        = var.resource_group_name
 location                   = var.resource_group_location

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  
  service_plan_id            = var.service_plan_id

  site_config {}

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
    service_plan_id = var.service_plan_id
  }
} 

