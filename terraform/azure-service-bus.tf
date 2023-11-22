
# Define the Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "asb-poc-rg"
  location = "West Europe"
}

# Define the Service Bus Namespace
resource "azurerm_servicebus_namespace" "asb-namespace" {
  name                = "asb-poc-namespace"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
}

# Define the Service Bus Queue
resource "azurerm_servicebus_queue" "test-queue-1" {
  namespace_id        = azurerm_servicebus_namespace.asb-namespace.id
  name                = "sb-poc-queue"
  enable_partitioning = true
  enable_express = false # lazy writing of messages to disk - increases performance but doesn't guarantee delivery
  dead_lettering_on_message_expiration = true # DL if not consumed inside TTL period
  default_message_ttl = "P10D"
  lock_duration = "PT1M"
  max_delivery_count = 5
  max_message_size_in_kilobytes = 1024
  max_size_in_megabytes = 5120 # 5GB
  requires_duplicate_detection = false
  requires_session = false
}

# Define the Service Bus Queue
resource "azurerm_servicebus_queue" "test-queue-2" {
  namespace_id        = azurerm_servicebus_namespace.asb-namespace.id
  name                = "sb-poc-queue"
  enable_partitioning = true
  enable_express = false # lazy writing of messages to disk - increases performance but doesn't guarantee delivery
  dead_lettering_on_message_expiration = true # DL if not consumed inside TTL period
  default_message_ttl = "P10D"
  lock_duration = "PT1M"
  max_delivery_count = 5
  max_message_size_in_kilobytes = 100
  max_size_in_megabytes = 5120 # 5GB
  requires_duplicate_detection = false
  requires_session = false
}