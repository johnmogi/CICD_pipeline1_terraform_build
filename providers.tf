terraform {
backend "azurerm" {
resource_group_name = ""
storage_account_name = ""
container_name = ""
key = ""
access_key = ""
}
}

provider "azurerm" {
  features {}
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
}

