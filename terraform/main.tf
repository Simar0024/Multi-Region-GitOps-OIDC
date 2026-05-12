resource "azurerm_resource_group" "primary" {
  name     = "rg-prod-centralindia"
  location = "Central India"
}

resource "azurerm_resource_group" "secondary" {
  name     = "rg-prod-koreacentral"
  location = "Korea Central"
}

module "app_centralindia" {
  source              = "./modules/app_service"
  resource_group_name = azurerm_resource_group.primary.name
  location            = azurerm_resource_group.primary.location
  app_name            = "web-prod-centralindia-001"
}

module "app_koreacentral" {
  source              = "./modules/app_service"
  resource_group_name = azurerm_resource_group.secondary.name
  location            = azurerm_resource_group.secondary.location
  app_name            = "web-prod-koreacentral-001"
}