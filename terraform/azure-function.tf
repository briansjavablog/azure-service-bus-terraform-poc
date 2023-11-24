resource "azurerm_function_app" "asb_test-function-app" {
  name                       = "asb_test-function-app"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.funct-storage-account.name
  storage_account_access_key = azurerm_storage_account.funct-storage-account.primary_access_key
  os_type                    = "linux"
  functions_extension_version = "~3"

  app_settings = {
    "AzureWebJobsServiceBus" = azurerm_servicebus_namespace.asb-namespace.default_primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME" = "java"
  }
}

resource "azurerm_app_service_plan" "example" {
  name                = "asb_test-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "FunctionApp"
  reserved            = true # Required for Linux plans

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_storage_account" "funct-storage-account" {
  name                     = "functionstorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}