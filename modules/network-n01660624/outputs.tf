output "virtual_network_name" {
  value       = azurerm_virtual_network.humber_vnet.name
  description = "The name of the virtual network"
}

output "subnet_humberID" {
  value       = azurerm_subnet.humber_subnet.id
  description = "The name of the subnet"
}
