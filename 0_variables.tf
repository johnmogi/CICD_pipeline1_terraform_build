# hidden data managed by last pass: azure sela week6
variable TF_VAR_admin_username{default="" }
variable TF_VAR_admin_password{default="" }
variable TF_VAR_db_username{default="" }
variable TF_VAR_db_password{default="" }
variable TF_VAR_machines{default="" }
variable TF_VAR_size{default="" }

# magic numbers for staging and production:
# variable machines {
#     type = number
#     default = 2
#     # staging = 2
# }
 variable size {
     type    = string
     default = "Standard_b1s"
#     # staging = "Standard_b1s"
 }
variable "name"{
  default = "weight_app"
}
variable "group" {
  default = "weight-app"
}
variable "rgn"{
  type    = string
  default =  "azurerm_resource_group.weight-app.name"
}
variable "rg_name"{
  type    = string
  default =  "azurerm_resource_group.weight-app.name"
}
variable "location"{
  default = "East Us" 
}
variable "tags" {
  default = {
    project = "weight-app"
  }
}
variable prefix {
    type    = string
    default = "weight_app" 
}

variable sysadmin_ip{
  type    = string
  default= "sysadmin_ip"

}
variable "sysadmin_machine" {
  default     = "vm"
}
variable command_nic_ip_configuration_name {
  description = "connection to vm sysadmin"
  default = "sysadmin_ip_con"
}

# one connection to pool them all
variable  pool_name {
  default = "webapp_nic" 
  description = "load balance flexible data"
}
