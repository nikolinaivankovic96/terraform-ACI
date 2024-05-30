resource "azurerm_resource_group" "euwe" {
  name     = "demo-rsg-${var.environment}" 
  location = "West Europe"
}
