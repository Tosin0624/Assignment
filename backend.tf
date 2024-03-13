terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01660626RG"
    storage_account_name = "tfstaten01660624sa"
    container_name       = "tfstatefiles"
    key                  = "terraform-state-assignment"
  }
}
