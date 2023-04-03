output "name" {
  description = "The name of the Storage Account."
  value       = var.name
}
output "id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.sa.id
}

output "primary_location" {
  description = "The primary location of the storage account."
  value       = azurerm_storage_account.sa.primary_location
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}

output "secondary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the secondary location."
  value       = azurerm_storage_account.sa.secondary_blob_endpoint
}

output "primary_access_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.sa.primary_access_key
}
/*
output "identity_principal_id" {
  description = "The Principal ID for the Service Principal associated with the Identity of this Storage Account."
  value       = azurerm_storage_account.sa.identity.0.principal_id
}
*/
output "storage_account_tier" {
  value = azurerm_storage_account.sa.account_tier
}

output "connectionstring" {
  description = "Storage accont primary connectionstring"
  value       = azurerm_storage_account.sa.primary_connection_string
}

output "metric_namespace" {
  description = "The Resource Metric namespace"
  value       = "Microsoft.Storage/storageAccounts"
}