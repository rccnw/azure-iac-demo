# Inside ./modules/static_web_app/outputs.tf or similar

output "id" {
  value = azurerm_static_web_app.swa.id
  description = "The ID of the Static Web App."
}