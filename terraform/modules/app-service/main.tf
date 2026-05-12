# Create the App Service Plan (Linux)
resource "azurerm_service_plan" "main" {
  name                = "${var.app_name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "S1" # Basic tier for testing; change to P1v2 for real prod
}

# Create the Web App
resource "azurerm_linux_web_app" "main" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    always_on = false # Set to true for Production tiers
    application_stack {
      python_version = "3.12" # You can change this to Node, Dotnet, etc.
    }
  }

  app_settings = {
    "ENVIRONMENT" = "Production"
    "REGION"      = var.location
  }
}