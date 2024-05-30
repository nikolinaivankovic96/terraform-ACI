resource "azurerm_container_registry" "acr" {
  name                = "demosacr${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
  admin_enabled       = true 

  tags = var.tags
}
