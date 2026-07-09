data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_service_plan" "shared" {
  name                = "plan-npr-prf2026"
  resource_group_name = "rg-shared-prf2026"
}

locals {
  tags = merge(var.tags, {
    owner      = var.owner
    managed_by = "terraform"
  })
}

module "storage" {
  source              = "./modules/storage"
  owner               = var.owner
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = local.tags
}

module "app_service" {
  source              = "./modules/app-service"
  owner               = var.owner
  resource_group_name = data.azurerm_resource_group.rg.name
  service_plan_id     = data.azurerm_service_plan.shared.id
  tags                = local.tags
}

module "function_app" {
  source              = "./modules/function-app"
  owner               = var.owner
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = data.azurerm_service_plan.shared.id
  tags                = local.tags
}

module "container" {
  source              = "./modules/container"
  owner               = var.owner
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = local.tags
}

module "network" {
  source              = "./modules/network"
  owner               = var.owner
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = local.tags
}
