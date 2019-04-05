provider "azurerm" {
  version         = "=1.23.0"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.project}-rg"
  location = "${var.region}"
  tags     = "${local.common_tags}"
}

resource "azurerm_virtual_network" "main" {
  name                = "${local.project}-network"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location            = "${azurerm_resource_group.main.location}"
  address_space       = ["10.0.0.0/16"]
  tags                = "${local.common_tags}"
}

module "database" {
  source              = "modules/cosmosdb"
  environment         = "${var.environment}"
  common_tags         = "${local.common_tags}"
  project             = "${local.project}"
  region              = "${var.region}"
  failover_region     = "${var.failover_region}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  name                = "${local.project}-cosmosdb"
}

module "container-registry" {
  source              = "modules/container-registry"
  environment         = "${var.environment}"
  common_tags         = "${local.common_tags}"
  project             = "${local.project}"
  region              = "${var.region}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  name                = "${var.application_shortname}-${var.environment}-registry"
}

module "api" {
  source              = "modules/appservice"
  environment         = "${var.environment}"
  common_tags         = "${local.common_tags}"
  project             = "${local.project}"
  region              = "${var.region}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  name                = "${local.project}-api"

  app_settings = {
    "COLLECTION_NAME" = "Items"
  }

  db_connection_string    = "${module.database.connection_strings[0]}"
  registry_login_server   = "${module.container-registry.login_server}"
  registry_admin_username = "${module.container-registry.admin_username}"
  registry_admin_password = "${module.container-registry.admin_password}"
  docker_image            = "hello-world:v1"
}
