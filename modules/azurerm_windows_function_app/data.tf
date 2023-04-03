data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_service_plan" "sp" {
  name                = var.asp_name
  resource_group_name = var.rg_name
}

data "azurerm_storage_account" "sa" {
  name                = var.sa_name
  resource_group_name = var.rg_name
}
