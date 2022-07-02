terraform {
backend "azurerm" {
resource_group_name = "cloud-shell-storage-westeurope"
storage_account_name = "csb1003200202a74581"
container_name = "datestorage"
key = "weight-key"
access_key = "Bs+esM83yqohtH4u6Dwuv5ycHUf3x/9ZQPE+T6sl/OqWiS4FOXjkfwk1ZSS8VA3NzfBBOrKg1ldn+AStSukP6Q=="
}
}

provider "azurerm" {
  features {}
  subscription_id = "f0de5eae-71b0-412c-9a68-49f436648228"
  client_id       = "8ad5ca92-b826-4c40-ad26-11bd82260854"
  client_secret   = "RQi8Q~syswW6fwvUIPgOuOu5BhOmtQeOByZe7bi3"
  tenant_id       = "108d7c99-1c6f-4834-853c-92f82f2742e9"
}

