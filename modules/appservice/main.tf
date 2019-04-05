resource "azurerm_app_service_plan" "appservice" {
  name                = "${var.name}-plan"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.region}"
  tags                = "${var.common_tags}"
  kind                = "linux"

  sku {
    tier = "Standard"
    size = "S1"
  }

  properties {
    reserved = true # Mandatory for Linux plans
  }
}

resource "azurerm_app_service" "appservice" {
  name                = "${var.name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.region}"
  app_service_plan_id = "${azurerm_app_service_plan.appservice.id}"
  tags                = "${var.common_tags}"

  app_settings = "${merge(
    var.app_settings,
    map(
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE", "false",
      "DOCKER_REGISTRY_SERVER_URL", "${var.registry_login_server}",
      "DOCKER_REGISTRY_SERVER_USERNAME", "${var.registry_admin_username}",
      "DOCKER_REGISTRY_SERVER_PASSWORD", "${var.registry_admin_password}"
    )
  )}"

  connection_string = [{
    name  = "Database"
    type  = "DocDb"
    value = "${var.db_connection_string}"
  }]

  site_config {
    linux_fx_version = "DOCKER|${var.registry_login_server}/${var.docker_image}"
    always_on        = "true"
  }

  identity {
    type = "SystemAssigned"
  }
}
