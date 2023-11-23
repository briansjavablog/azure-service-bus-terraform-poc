# Configure the Azure Provider
provider "azurerm" {
  features {}
  #client_id = "c7516409-8113-41d8-b994-6201c16a543a"
  # If you are running this on a machine where the Managed Identity has been assigned,
  # Terraform will automatically use this identity and you don't need to specify credentials here.
}