# Load blanacer
resource "azurerm_lb" "azurerm_lb" {
  name                = "loadBalancer"
  resource_group_name  = azurerm_resource_group.weight-app.name
  location            = var.location

# ip_configuration
  frontend_ip_configuration {
    name                 = "mip"
    public_ip_address_id = azurerm_public_ip.ip.id
  }
  sku = "Standard"
}
 # Lb address_pool
 resource "azurerm_lb_backend_address_pool" "lb_pool" {
  loadbalancer_id = azurerm_lb.azurerm_lb.id
  name            = "addressPool"

  depends_on = [azurerm_lb.azurerm_lb]

}
# lb_probe
resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id     = azurerm_lb.azurerm_lb.id
  name                = "lb_probe"
  port                = 8080
}

# lb_rule
resource "azurerm_lb_rule" "web" {
  backend_port                   = 8080
  frontend_ip_configuration_name = "mip"
  frontend_port                  = 8080
  loadbalancer_id                = azurerm_lb.azurerm_lb.id
  name                           = "Web"
  protocol                       = "Tcp"
  probe_id                       = azurerm_lb_probe.lb_probe.id
  disable_outbound_snat          = true
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_pool.id]

  depends_on = [azurerm_lb.azurerm_lb]

}

# lb_nat_rule
resource "azurerm_lb_nat_rule" "nat_rule_ssh" {
  name                           = "SSH"
  resource_group_name  = azurerm_resource_group.weight-app.name
  backend_port                   = 22
  frontend_ip_configuration_name = "mip"
  frontend_port                  = 22
  loadbalancer_id                = azurerm_lb.azurerm_lb.id
  protocol                       = "Tcp"

  depends_on = [azurerm_lb.azurerm_lb]
}
# lb_outbound_rule
resource "azurerm_lb_outbound_rule" "outbound" {
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_pool.id
  loadbalancer_id         = azurerm_lb.azurerm_lb.id
  name                    = "Any"
  protocol                = "All"

  frontend_ip_configuration {
    name = "mip"
  }

  depends_on = [azurerm_lb.azurerm_lb]

}

