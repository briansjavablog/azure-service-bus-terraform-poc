# Define Managed Identity for microservice 1
resource "azurerm_user_assigned_identity" "microservice1_identity" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "service1-mi"
}

# Define Managed Identity for microservice 2
resource "azurerm_user_assigned_identity" "microservice2_identity" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "service2-mi"
}