terraform {
  backend "azurerm" {
    resource_group_name   = "asb-poc-rg"
    storage_account_name  = "iacpocstorageaccount"
    container_name        = "asb-poc-terraform-state"
    key                   = "terraform.tfstate"
  }
}