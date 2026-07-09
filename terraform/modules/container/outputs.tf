output "container_fqdn" {
  description = "FQDN of the Azure Container Instance"
  value       = azurerm_container_group.container.fqdn
}

output "container_url" {
  description = "URL of the Azure Container Instance"
  value       = "http://${azurerm_container_group.container.fqdn}"
}
