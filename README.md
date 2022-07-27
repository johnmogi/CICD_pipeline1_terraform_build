# ansible_Terraform_azure

Hello and Wellcome to the wonderfull world of Terraform and Azure cloud-
a match made in heaven.


![Terraform](https://bootcamp.rhinops.io/images/terraform-logo.png)

## How to use this repository:
- You'll obviously need an active Azure cloud subscription.
- You can use the providers.tf file - populate it with your own access.
+ Retrieve your active <b>subscription id</b>,
+ Retrieve your active <b>subscription name</b> and other data:
+ https://go.microsoft.com/fwlink/?LinkID=312990

## the next step is to create and connect a backend file.
You can use the providers file to hook up you backend.<br/>
the backend file will serve as a back up point for both access and code sharing:
https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli


<h2> important - do not include your secrets in your providers file! </h2> 
if you upload it to github or other public repository, if you do please be advised of the use of enviroments secrets 

https://www.youtube.com/watch?v=UaehcmoMAFc
<h6>Terraform and Azure Pipelines - Avoid these Beginner's Mistakes!</h6>


# how to change variables on enviroment?
for instance var.machine 2 staging | 3 prod <br/>
or size = "Standard_b2s" <br/>
simply change the variable in the terraform file <br/>(see a bit below)

# how to change enviroment?
on the cli - switch between enviroments, allways make sure your'e on the right envroment...
<pre>
terraform workspace select staging
terraform workspace select production
</pre>




in order to work with this project we will need you to install the following:<br/>
production.tfvars + staging.tfvars file with the following:

<pre>
TF_VAR_admin_username = ""
TF_VAR_admin_password = ""
TF_VAR_db_username = ""
TF_VAR_db_password = ""
TF_VAR_size=""
TF_VAR_machines=
</pre>

production staging
TF_VAR_machines=3 | TF_VAR_machines= 2

once begun do 'az login' and then do the following:<br/>
transfer the following files to the terraform providers.tf

<pre>
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
client_id = ""
client_secret = ""
tenant_id = ""
}

</pre>

then to run the terraform plan command to each it's own enviroment:

terraform plan \  
-var-file="production.tfvars"

terraform plan \  
-var-file="staging.tfvars"

you can also change plan to apply and or add -auto-approve for faster and skipped validation prompt.


# CI CD execution plan:
the folowing takes into account the next step that is azure devops CI CD, you can find additional info here

- spin a vm, connect it as an agent. (sysadmin)
build a terraform pipelince, that can have ci cd capacibilities, meaning that it can trigger the 2nd and 3rd stages.

- 1st stage: terraform repo. in here we have 2 distinct stages:
building a backend (what does it compose of? which files are relevant? what are the steps to build it?)
the actual deployment, with the infracost report before execution.

- let's say for the sake of this excercise that the 1st ci is an independant that can chain up the whole process, manually into the repo or all the way.<br/>
this means that to be truly independant it needs to run on it's seperate agent, to simplify things in a time budget situation- this will have to be manually done.
output file:
export password and user


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

# added infracost
this great plugin caclulates the changes in cost so you can decide if a change is too costly and be better prepeared.
for additional info: https://github.com/infracost

infracost --version # Should show 0.10.6
infracost configure get api_key
infracost configure set pricing_api_endpoint https://endpoint
-needs to run docker cintainer
https://www.infracost.io/docs/cloud_pricing_api/self_hosted/
infracost configure set api_key <api>

## how to run the infracost:

nfracost diff --path prodPlan.json --compare-to stageplan.json

tf plan -out=stagePlan.binary -var-file="staging.tfvars"
infracost diff --path stageplan.json
infracost diff --path prodPlan.json
terraform apply -auto-approve -var-file="staging.tfvars"

tfw = terraform workspace
-tfw show

create the staging costs report:
tfw select staging
tf plan -out=stagePlan.binary -var-file="staging.tfvars"
terraform show -json stagePlan.binary > stageplan.json
infracost breakdown --path . --format json --out-file infracost-report-stageplan.json

build the prod costs report:
tfw select production
tf plan -out=prodPlan.binary -var-file="production.tfvars"
terraform show -json prodPlan.binary > prodplan.json
infracost breakdown --path . --format json --out-file infracost-report-prodplan.json

infracost diff --path plan.json

# test commit

git checkout -b testplan
git checkout testplan
infracost diff --path . --format json \
 --compare-to nfracost-report-stageplan.json --out-file infracost-report-stagePlan.json
infracost diff --path prod --format json \
 --compare-to nfracost-report-prodplan.json --out-file infracost-report-prodPlan.json
infracost comment github --path "infracost-report-\*.json" ...

<pre>
infracost comment github --path plan.json \
    --repo $BUILD_REPOSITORY_NAME \
    --pull-request $SYSTEM_PULLREQUEST_PULLREQUESTNUMBER `# or --commit $BUILD_SOURCEVERSION` \
    --github-token $GITHUB_TOKEN \
    --behavior update
</pre>

infracost breakdown --path . --format json --out-file plan.json
infracost breakdown --path . --format json --out-file plan.json



## Requirements

No requirements.

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | 3.10.0  |

## Modules

| Name                                                        | Source             | Version |
| ----------------------------------------------------------- | ------------------ | ------- |
| <a name="module_postgres"></a> [postgres](#module_postgres) | ./modules/postgres | n/a     |
| <a name="module_vm_front"></a> [vm_front](#module_vm_front) | ./modules/frontend | n/a     |

## Resources

| Name                                                                                                                                                                                                                | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_lb.azurerm_lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb)                                                                                                         | resource |
| [azurerm_lb_backend_address_pool.lb_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool)                                                                  | resource |
| [azurerm_lb_nat_rule.nat_rule_ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_nat_rule)                                                                                     | resource |
| [azurerm_lb_outbound_rule.outbound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_outbound_rule)                                                                               | resource |
| [azurerm_lb_probe.lb_probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe)                                                                                               | resource |
| [azurerm_lb_rule.web](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule)                                                                                                      | resource |
| [azurerm_linux_virtual_machine.sysadmin_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)                                                                  | resource |
| [azurerm_network_interface.nics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)                                                                                 | resource |
| [azurerm_network_interface.sys_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)                                                                              | resource |
| [azurerm_network_interface.sysadmin_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)                                                                         | resource |
| [azurerm_network_interface_backend_address_pool_association.fe_nics_connection](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [azurerm_network_interface_security_group_association.nics_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association)                       | resource |
| [azurerm_network_security_group.frontend_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)                                                               | resource |
| [azurerm_public_ip.ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)                                                                                                   | resource |
| [azurerm_public_ip.sysadmin_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)                                                                                          | resource |
| [azurerm_resource_group.weight-app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)                                                                                 | resource |
| [azurerm_subnet.backend_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                                                                                             | resource |
| [azurerm_subnet.frontend_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                                                                                            | resource |
| [azurerm_subnet.sysadmin_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                                                                                            | resource |
| [azurerm_subnet_network_security_group_association.frontend_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association)                      | resource |
| [azurerm_virtual_network.weight_app_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)                                                                       | resource |

## Inputs

| Name                                                                                                                                 | Description                                                                                             | Type     | Default                                       | Required |
| ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- | -------- | --------------------------------------------- | :------: |
| <a name="input_TF_VAR_admin_password"></a> [TF_VAR_admin_password](#input_TF_VAR_admin_password)                                     | n/a                                                                                                     | `string` | `""`                                          |    no    |
| <a name="input_TF_VAR_admin_username"></a> [TF_VAR_admin_username](#input_TF_VAR_admin_username)                                     | hidden data managed by last pass: azure sela week6                                                      | `string` | `""`                                          |    no    |
| <a name="input_TF_VAR_db_password"></a> [TF_VAR_db_password](#input_TF_VAR_db_password)                                              | n/a                                                                                                     | `string` | `""`                                          |    no    |
| <a name="input_TF_VAR_db_username"></a> [TF_VAR_db_username](#input_TF_VAR_db_username)                                              | n/a                                                                                                     | `string` | `""`                                          |    no    |
| <a name="input_TF_VAR_machines"></a> [TF_VAR_machines](#input_TF_VAR_machines)                                                       | n/a                                                                                                     | `string` | `""`                                          |    no    |
| <a name="input_TF_VAR_size"></a> [TF_VAR_size](#input_TF_VAR_size)                                                                   | n/a                                                                                                     | `string` | `""`                                          |    no    |
| <a name="input_command_nic_ip_configuration_name"></a> [command_nic_ip_configuration_name](#input_command_nic_ip_configuration_name) | connection to vm sysadmin                                                                               | `string` | `"sysadmin_ip_con"`                           |    no    |
| <a name="input_group"></a> [group](#input_group)                                                                                     | n/a                                                                                                     | `string` | `"weight-app"`                                |    no    |
| <a name="input_location"></a> [location](#input_location)                                                                            | n/a                                                                                                     | `string` | `"East Us"`                                   |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                                        | n/a                                                                                                     | `string` | `"weight_app"`                                |    no    |
| <a name="input_pool_name"></a> [pool_name](#input_pool_name)                                                                         | load balance flexible data                                                                              | `string` | `"webapp_nic"`                                |    no    |
| <a name="input_prefix"></a> [prefix](#input_prefix)                                                                                  | n/a                                                                                                     | `string` | `"weight_app"`                                |    no    |
| <a name="input_rg_name"></a> [rg_name](#input_rg_name)                                                                               | n/a                                                                                                     | `string` | `"azurerm_resource_group.weight-app.name"`    |    no    |
| <a name="input_rgn"></a> [rgn](#input_rgn)                                                                                           | n/a                                                                                                     | `string` | `"azurerm_resource_group.weight-app.name"`    |    no    |
| <a name="input_size"></a> [size](#input_size)                                                                                        | magic numbers for staging and production: variable machines { type = number default = 2 # staging = 2 } | `string` | `"Standard_b1s"`                              |    no    |
| <a name="input_sysadmin_ip"></a> [sysadmin_ip](#input_sysadmin_ip)                                                                   | n/a                                                                                                     | `string` | `"sysadmin_ip"`                               |    no    |
| <a name="input_sysadmin_machine"></a> [sysadmin_machine](#input_sysadmin_machine)                                                    | n/a                                                                                                     | `string` | `"vm"`                                        |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                        | n/a                                                                                                     | `map`    | <pre>{<br> "project": "weight-app"<br>}</pre> |    no    |

## Outputs

| Name                                                                          | Description |
| ----------------------------------------------------------------------------- | ----------- |
| <a name="output_admin_password"></a> [admin_password](#output_admin_password) | n/a         |
| <a name="output_app_public_ip"></a> [app_public_ip](#output_app_public_ip)    | n/a         |


my Devops journey (hand drawn by me) :

<center><img src="https://raw.githubusercontent.com/johnmogi/password/main/my_devops.jpg" height="400"></center>