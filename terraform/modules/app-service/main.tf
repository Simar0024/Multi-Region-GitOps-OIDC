# Create the App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "${var.app_name}-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "S1" 
  
  # checkov:skip=CKV_AZURE_212:Student account limits prevent multiple instances
  # checkov:skip=CKV_AZURE_225:Student account limits prevent zone redundancy
}

# Create the Web App
resource "azurerm_linux_web_app" "main" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id
  
  https_only = true 

  identity {
    type = "SystemAssigned" 
  }

  site_config {
    always_on         = true         
    http2_enabled     = true         
    ftps_state        = "Disabled"   
    health_check_path = "/" 

    application_stack {
      python_version = "3.12"
    }
  }

  # CORRECTED LOGGING SECTION
  logs {
    detailed_error_messages = true # Fixes CKV_AZURE_65
    failed_request_tracing  = true # Fixes CKV_AZURE_66

    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }

  app_settings = {
    "ENVIRONMENT" = "Production"
    "REGION"      = var.location
  }

  # checkov:skip=CKV_AZURE_17:Client Certificates require custom setup
  # checkov:skip=CKV_AZURE_222:Public access required for student testing
  # checkov:skip=CKV_AZURE_13:Auth managed at application layer
  # checkov:skip=CKV_AZURE_88:Storage is managed via stateless deployment; Azure Files not required for this lab
}