# Virtual Network
resource "azurerm_virtual_network" "weight_app_network" {
  address_space       = ["10.0.0.0/16"] 
  location            = var.location
  name                = "${var.prefix}_network"
  resource_group_name = azurerm_resource_group.weight-app.name
}

# Private subnet
resource "azurerm_subnet" "backend_subnet" {
  address_prefixes     = ["10.0.0.0/26"] 
  name                 = "backendSubnet"
  resource_group_name  = azurerm_resource_group.weight-app.name
  virtual_network_name = azurerm_virtual_network.weight_app_network.name

delegation {
    name = "dbSubConection"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  depends_on = [azurerm_resource_group.weight-app]
}

# Frontend subnet
resource "azurerm_subnet" "frontend_subnet" {
  address_prefixes     = ["10.0.20.0/26"]
  name                 = "frontendSubnet"
  resource_group_name  = azurerm_resource_group.weight-app.name
  virtual_network_name = azurerm_virtual_network.weight_app_network.name

  depends_on =  [azurerm_resource_group.weight-app]
}

# Sysadmin worker
resource "azurerm_subnet" "sysadmin_subnet" {
  address_prefixes     = ["10.0.30.0/26"] 
  name                 = "sysadminSubnet"
  resource_group_name  = azurerm_resource_group.weight-app.name
  virtual_network_name = azurerm_virtual_network.weight_app_network.name

  depends_on =  [azurerm_resource_group.weight-app]
}

# Provide each macine with a nic
resource "azurerm_network_interface" "nics" {
  count               = "${var.TF_VAR_machines}"

  name                = "${var.pool_name}-${count.index}"
  location            = var.location
  resource_group_name  = azurerm_resource_group.weight-app.name
#  virtual_network_name = azurerm_virtual_network.weight-app_network.name

  ip_configuration {
## {{dynamic variable connection}}
    name                          = "${var.pool_name}-${count.index}"
    subnet_id                     = azurerm_subnet.frontend_subnet.id
    private_ip_address_allocation = "Dynamic"

  }

  depends_on = [
    azurerm_resource_group.weight-app,
    azurerm_subnet.frontend_subnet
  ]
}

# Sysadmin network_interface 
resource "azurerm_network_interface" "sys_nic" {
  location            = var.location
  name                = "sysadmin_${var.sysadmin_machine}-nic"
  resource_group_name  = azurerm_resource_group.weight-app.name

  ip_configuration {
    name                          = var.command_nic_ip_configuration_name
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.sysadmin_ip.id
    subnet_id                     = azurerm_subnet.sysadmin_subnet.id

  }

  depends_on = [
    azurerm_resource_group.weight-app,
    azurerm_subnet.sysadmin_subnet
  ]

}
# # availability_set
# resource "azurerm_availability_set" "weight_app_avs" {
#   name                         = "frontend_avs"
#   location                     = var.location
#   resource_group_name          = azurerm_resource_group.weight-app.name
#   platform_fault_domain_count  = "${var.TF_VAR_machines}"
#   platform_update_domain_count = "${var.TF_VAR_machines}"
#   managed                      = true

#   depends_on          = [azurerm_resource_group.weight-app]

# }