resource "azurerm_linux_function_app" "asb_test-function-app" {
  name                       = "asb-test-function-app"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  service_plan_id            = azurerm_service_plan.service-plan.id
  storage_account_name       = azurerm_storage_account.funct-storage-account.name
  storage_account_access_key = azurerm_storage_account.funct-storage-account.primary_access_key
  #os_type                    = "linux"
  app_settings = {
    "AzureWebJobsServiceBus" = azurerm_servicebus_namespace.asb-namespace.default_primary_connection_string
    "FUNCTIONS_WORKER_RUNTIME" = "java"
  }
}

resource "azurerm_service_plan" "service-plan" {
  name                = "asb-test-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  #kind                = "FunctionApp"
  #reserved            = true # Required for Linux plans

  /*sku {
    tier = "Dynamic"
    size = "Y1"
  }*/
  os_type  = "Linux"
  sku_name = "F1"
}

resource "azurerm_storage_account" "funct-storage-account" {
  name                     = "functionstorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}