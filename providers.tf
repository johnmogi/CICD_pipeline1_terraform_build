terraform {
backend "azurerm" {
resource_group_name = "tfstate"
storage_account_name = "tfstatemy16763"
container_name = "tfstate"
key = "terraform.tfstate"
access_key = ""
}
}

provider "azurerm" {
  features {}
  subscription_id = "faa3faa6-3e8a-40b5-b292-ca93a26b02a0"
  client_id       = ""
  client_secret   = ""
  tenant_id       = "ace7cae5-70f7-48ff-a93f-fbfca6f7e1fd"
}

