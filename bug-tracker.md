## Toubleshooter:
(the following bug fixes allready applied)

description - the machines name is generic and the vm nic can't find it- use hardcoded values instead of generic.<br/>
the generic name originates in the enviroment addition to the resource group
solution: on vm.tf file
<pre>
CHANGE:
 rg_name = "${local.name}-${var.group}"
TO:
  rg_name  = azurerm_resource_group.weight-app.name
</pre>
a bug in the state "│ Error: compute.AvailabilitySetsClient#CreateOrUpdate: Failure responding to request: StatusCode=404 -- Original Error: autorest/azure: Service returned an error. Status=404 Code="ResourceGroupNotFound" Message="Resource group 'staging-weight-app' could not be found."


tf apply error:
https://github.com/hashicorp/terraform/issues/12826

try to delete terraform.tfstate