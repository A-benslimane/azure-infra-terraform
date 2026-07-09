output "storage_account_name" {
  description = "Name of the business Storage Account"
  value       = module.storage.storage_account_name
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = module.app_service.app_service_url
}

output "function_app_url" {
  description = "URL of the Function App"
  value       = module.function_app.function_app_url
}

output "container_url" {
  description = "URL of the Azure Container Instance"
  value       = module.container.container_url
}
