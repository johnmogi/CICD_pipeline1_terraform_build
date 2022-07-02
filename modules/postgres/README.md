## Requirements

No requirements.

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                        | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_postgresql_flexible_server.postgres_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server)                            | resource |
| [azurerm_postgresql_flexible_server_configuration.dbConfig](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration)       | resource |
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone)                                               | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_vnl](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |

## Inputs

| Name                                                                     | Description | Type  | Default | Required |
| ------------------------------------------------------------------------ | ----------- | ----- | ------- | :------: |
| <a name="input_bacjendSubnet"></a> [bacjendSubnet](#input_bacjendSubnet) | n/a         | `any` | n/a     |   yes    |
| <a name="input_location"></a> [location](#input_location)                | n/a         | `any` | n/a     |   yes    |
| <a name="input_pgPassword"></a> [pgPassword](#input_pgPassword)          | n/a         | `any` | n/a     |   yes    |
| <a name="input_pgUsername"></a> [pgUsername](#input_pgUsername)          | n/a         | `any` | n/a     |   yes    |
| <a name="input_rg_name"></a> [rg_name](#input_rg_name)                   | n/a         | `any` | n/a     |   yes    |
| <a name="input_vnet"></a> [vnet](#input_vnet)                            | n/a         | `any` | n/a     |   yes    |

## Outputs

No outputs.
