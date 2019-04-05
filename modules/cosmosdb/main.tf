resource "azurerm_cosmosdb_account" "db" {
  name                      = "${var.name}"
  location                  = "${var.region}"
  resource_group_name       = "${var.resource_group_name}"
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  tags                      = "${var.common_tags}"
  enable_automatic_failover = false

  consistency_policy {
    consistency_level = "Eventual"
  }

  # geo_location {
  #   location          = "${var.failover_region}"
  #   failover_priority = 1
  # }

  geo_location {
    location          = "${var.region}"
    failover_priority = 0
  }
}
