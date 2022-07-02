resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "${var.rg_name}-db.postgres.database.azure.com"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_vnl" {
  name                  = "${var.rg_name}.dns-link"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.vnet.id
  resource_group_name   = var.rg_name
}

# Creates postgresql flexible server
resource "azurerm_postgresql_flexible_server" "postgres_server" {
  name                   = "${var.rg_name}postgrsql"
  resource_group_name    = var.rg_name
  location               = var.location
  version                = "12"
  delegated_subnet_id    = var.bacjendSubnet
  private_dns_zone_id    = azurerm_private_dns_zone.private_dns_zone.id
  administrator_login    = var.pgUsername
  administrator_password = var.pgPassword
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_vnl]

}

# Configuring SSL
resource "azurerm_postgresql_flexible_server_configuration" "dbConfig" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.postgres_server.id
  value     = "off"
}

# # Firewall rules
# resource "azurerm_postgresql_flexible_server_firewall_rule" "fw" {
#   name             = "ruleA"
#   start_ip_address = "10.0.0.0"
#   end_ip_address   = "10.0.0.255"
#   server_id        = azurerm_postgresql_flexible_server.postgres_server.id
# }