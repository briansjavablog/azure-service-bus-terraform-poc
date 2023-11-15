# Configure the Azure Provider
provider "azurerm" {
  features {}
  # If you are running this on a machine where the Managed Identity has been assigned,
  # Terraform will automatically use this identity and you don't need to specify credentials here.
}

# Define the Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "service-bus-resources"
  location = "West Europe"
}

# Define the Service Bus Namespace
resource "azurerm_servicebus_namespace" "namespace" {
  name                = "example-sb-namespace"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
}

# Define the Service Bus Queue
resource "azurerm_servicebus_queue" "queue" {
  name                = "example-sb-queue"
  namespace_name      = azurerm_servicebus_namespace.namespace.name
  resource_group_name = azurerm_resource_group.rg.name

  enable_partitioning = true
}