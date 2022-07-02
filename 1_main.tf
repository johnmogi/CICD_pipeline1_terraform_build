# Default = production, staging enviroments / workspaces.
locals {
  name = "${terraform.workspace}"
  tags = merge(var.tags, {"env" = terraform.workspace, "app" = local.name})

}

# Main resource group- dynamic switch staging and production groups
resource "azurerm_resource_group" "weight-app" {
  name     =  "${local.name}-${var.group}"
  location = "East Us"
}
