resource "azurerm_function_app" "asb-test-function-app" {
  name                       = "asb-test-function-app"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_service_plan.service-plan.id
  storage_account_name       = azurerm_storage_account.func-storage-account.name
  storage_account_access_key = azurerm_storage_account.func-storage-account.primary_access_key

  app_settings = {
    "AzureWebJobsServiceBus" = azurerm_servicebus_namespace.asb-namespace.default_primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME" = "java"
    "FUNCTIONS_EXTENSION_VERSION" = "~4"
  }

  os_type = "linux" // Specify the OS type

  site_config {
    linux_fx_version = "JAVA|17"
  }
}

resource "azurerm_service_plan" "service-plan" {
  name                = "asb-test-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "Y1"
  #reserved            = true // Required for Linux plans
}

resource "azurerm_storage_account" "func-storage-account" {
  name                     = "iacpocfuncstorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Ensure you also have the azurerm_resource_group and azurerm_servicebus_namespace resources defined.
