output "id" {
  value = "${azurerm_cosmosdb_account.db.id}"
}

output "endpoint" {
  value = "${azurerm_cosmosdb_account.db.endpoint}"
}

output "primary_master_key" {
  value = "${azurerm_cosmosdb_account.db.primary_master_key}"
}

output "primary_readonly_master_key" {
  value = "${azurerm_cosmosdb_account.db.primary_readonly_master_key}"
}

output "connection_strings" {
  value = "${azurerm_cosmosdb_account.db.connection_strings}"
}
