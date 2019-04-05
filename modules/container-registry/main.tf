resource "azurerm_storage_account" "container-registry" {
  name                     = "${local.container_registry_name}sg"
  location                 = "${var.region}"
  resource_group_name      = "${var.resource_group_name}"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = "${var.common_tags}"
}

resource "azurerm_container_registry" "container-registry" {
  name                = "${local.container_registry_name}"
  location            = "${var.region}"
  resource_group_name = "${var.resource_group_name}"
  admin_enabled       = true
  sku                 = "Classic"
  storage_account_id  = "${azurerm_storage_account.container-registry.id}"
  tags                = "${var.common_tags}"
}

locals {
  container_registry_name = "${lower(replace(var.name,"-",""))}"
}
