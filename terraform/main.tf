# Configure the Azure Provider
provider "azurerm" {
  features {}
  # If you are running this on a machine where the Managed Identity has been assigned,
  # Terraform will automatically use this identity and you don't need to specify credentials here.
}