
# RBAC Assignment for microservice 1 with sender to Queue 1
resource "azurerm_role_assignment" "microservice1_queue1_sender" {
  scope                = azurerm_servicebus_queue.test-queue-1.id
  role_definition_name = "Azure Service Bus Data Sender" # Or "Azure Service Bus Data Receiver" depending on the needs
  principal_id         = azurerm_user_assigned_identity.microservice1_identity.principal_id
}

# RBAC Assignment for microservice 1 with receiver from Queue 1
resource "azurerm_role_assignment" "microservice1_queue1_receiver" {
  scope                = azurerm_servicebus_queue.test-queue-1.id
  role_definition_name = "Azure Service Bus Data Receiver"
  principal_id         = azurerm_user_assigned_identity.microservice1_identity.principal_id
}

# RBAC Assignment for microservice 2 with sender to Queue 2
resource "azurerm_role_assignment" "microservice2_queue2_sender" {
  scope                = azurerm_servicebus_queue.test-queue-2.id
  role_definition_name = "Azure Service Bus Data Sender"
  principal_id         = azurerm_user_assigned_identity.microservice2_identity.principal_id
}

# RBAC Assignment for microservice 2 with receiver from Queue 2
resource "azurerm_role_assignment" "microservice2_queue2_receiver" {
  scope                = azurerm_servicebus_queue.test-queue-2.id
  role_definition_name = "Azure Service Bus Data Receiver"
  principal_id         = azurerm_user_assigned_identity.microservice2_identity.principal_id
}