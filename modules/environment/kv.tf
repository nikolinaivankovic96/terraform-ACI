resource "azurerm_key_vault" "main" {
  name                       = "demo-kv-${var.environment}"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled = true
  enabled_for_template_deployment = true

  network_acls {
          bypass = "AzureServices"
          default_action = "Allow"
    }

  tags = var.tags
}

data "azurerm_key_vault" "main" {
  name                = "demo-kv-${var.environment}"
  resource_group_name = azurerm_resource_group.euwe.name
}

data "azurerm_key_vault_secret" "ssl_crt" {
  name         = "ssl-crt"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "ssl_key" {
  name         = "ssl-key"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "nginx_conf" {
  name         = "nginx-conf"
  key_vault_id = data.azurerm_key_vault.main.id
}
