resource "azurerm_static_web_app" "swa" {
  location            = var.resource_group_location
  name                = "${var.project}-${var.environment}-${var.swa-description}-swa"
  resource_group_name = var.resource_group_name

  sku_tier                = "Free"        # Adjust this as needed: "Free", "Standard", or "Premium"

  app_settings = {
    STORAGE_ACCOUNT_NAME = var.storage_account_name
    STORAGE_ACCOUNT_KEY  = var.storage_account_access_key
  }

  tags = {
    environment = var.environment
  }  
}