resource "azurerm_storage_account" "sa" {

  name     = "${var.project}${var.environment}${var.sa-description}sa"

  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"


  tags = {
    environment = var.environment
    project     = var.project
  }  
}