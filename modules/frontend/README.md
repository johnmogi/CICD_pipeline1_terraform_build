# this module uses a call from 5_vms.tf file

the following variables needs to be transfered via
"variables.tfvar" file (not included):

## Requirements

No requirements.

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                  | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_availability_set.avset](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set)                    | resource |
| [azurerm_linux_virtual_machine.frontendServer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |

## Inputs

| Name                                                                        | Description | Type     | Default | Required |
| --------------------------------------------------------------------------- | ----------- | -------- | ------- | :------: |
| <a name="input_admin_password"></a> [admin_password](#input_admin_password) | n/a         | `any`    | n/a     |   yes    |
| <a name="input_admin_username"></a> [admin_username](#input_admin_username) | n/a         | `any`    | n/a     |   yes    |
| <a name="input_location"></a> [location](#input_location)                   | n/a         | `any`    | n/a     |   yes    |
| <a name="input_nic_fe_ids"></a> [nic_fe_ids](#input_nic_fe_ids)             | n/a         | `any`    | n/a     |   yes    |
| <a name="input_pass_count"></a> [pass_count](#input_pass_count)             | n/a         | `any`    | n/a     |   yes    |
| <a name="input_rg_name"></a> [rg_name](#input_rg_name)                      | n/a         | `any`    | n/a     |   yes    |
| <a name="input_size"></a> [size](#input_size)                               | n/a         | `any`    | n/a     |   yes    |
| <a name="input_vm_front"></a> [vm_front](#input_vm_front)                   | n/a         | `string` | `""`    |    no    |

## Outputs

No outputs.
