
#Creates the postgreSQL server (managed database)
# module "postgres" {
#   source          = "./modules/postgres"
#   rg_name  = azurerm_resource_group.weight-app.name
#   location = var.location
#   vnet            = azurerm_virtual_network.weight_app_network
#   bacjendSubnet       = azurerm_subnet.backend_subnet.id
#   pgUsername         = var.TF_VAR_db_username
#   pgPassword     = var.TF_VAR_db_password
# }

# # private_dns_zone for the private_dns_zone_name
# resource "azurerm_private_dns_zone" "privateDnsZone" {
#   name                = "privateDnsZone.postgres.database.azure.com"
#   resource_group_name  = azurerm_resource_group.weight-app.name

# }

# # private_dns_zone is a required parameter for the private_dns_record resource
# resource "azurerm_private_dns_zone_virtual_network_link" "virtual_network_link" {
#   name                  = "weightapp_virtual_network_link"
#   private_dns_zone_name = azurerm_private_dns_zone.privateDnsZone.name
#   virtual_network_id    = azurerm_virtual_network.weight_app_network.id
#   resource_group_name  = azurerm_resource_group.weight-app.name

# }

# # postgresql server configuration
# resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
#   resource_group_name  = azurerm_resource_group.weight-app.name

#   delegated_subnet_id    = azurerm_subnet.backend_subnet.id
#   location               = var.location
#   name                   = "weightappdb"
#   version                = "13"

#   administrator_login    = "${var.TF_VAR_db_username}"
#   administrator_password = "${var.TF_VAR_db_password}"
#   storage_mb             = 32768
#   sku_name               = "GP_Standard_D2s_v3"
#   backup_retention_days  = 12
#   private_dns_zone_id    = azurerm_private_dns_zone.privateDnsZone.id
#   zone = "1"

#   depends_on = [azurerm_private_dns_zone_virtual_network_link.virtual_network_link]

# }
# # flexible_server_database configuration (postgresql)
# resource "azurerm_postgresql_flexible_server_database" "flexible_server_database" {
#   name      = "weightappdb"
#   server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
#   collation = "en_US.utf8"
#   charset   = "utf8" 

#   depends_on = [azurerm_postgresql_flexible_server.postgresql_flexible_server]

# }

# # Configure Flexible PostgreSQL Server   
# resource "azurerm_postgresql_flexible_server_configuration" "postgresFlexibleServerConfiguration" {
#   name      = "postgresFlexibleServerConfiguration"
#   server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
#   value     = "off"

#   depends_on = [azurerm_postgresql_flexible_server_database.flexible_server_database]

# }