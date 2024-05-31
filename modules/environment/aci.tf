resource "azurerm_container_group" "main" {
  name                = "demo-aci-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  ip_address_type     = "Public"
  dns_name_label      = "demo-${var.environment}"
  os_type             = "Linux"

  image_registry_credential {
        server   = azurerm_container_registry.main.login_server
        username = azurerm_container_registry.main.admin_username
        password = azurerm_container_registry.main.admin_password
    }

  container {
    name   = "website"
    image  = "${azurerm_container_registry.main.login_server}/${var.environment}:latest"
    cpu    = "1.0"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  container {
    name   = "nginx-ssl"
    image  = "mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine"
    cpu    = "1.0"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }

    volume {
      name      = "nginx-config"
      mount_path = "/etc/nginx"
      read_only   = false

      secret = {
      "ssl.crt"    = data.azurerm_key_vault_secret.ssl_crt.value
      "ssl.key"    = data.azurerm_key_vault_secret.ssl_key.value
      "nginx.conf" = filebase64("${path.module}/nginx/nginx.conf")
        }
    }
  }
}
