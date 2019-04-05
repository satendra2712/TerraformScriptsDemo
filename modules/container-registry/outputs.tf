output "id" {
  value = "${azurerm_container_registry.container-registry.id}"
}

output "name" {
  value = "${local.container_registry_name}"
}

output "login_server" {
  value = "${azurerm_container_registry.container-registry.login_server}"
}

output "admin_username" {
  value = "${azurerm_container_registry.container-registry.admin_username}"
}

output "admin_password" {
  value = "${azurerm_container_registry.container-registry.admin_password}"
}
