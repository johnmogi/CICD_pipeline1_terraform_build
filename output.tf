output "admin_password" {
    value = "${var.TF_VAR_admin_password}"
    sensitive = true
}
output "app_public_ip" {
  value = azurerm_public_ip.ip
} 