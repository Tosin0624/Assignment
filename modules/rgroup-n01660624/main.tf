resource "azurerm_resource_group" "humber01660624_rg" {
  name     = "${var.humberID}-RG"
  location = var.location
  tags     = var.tags
}
