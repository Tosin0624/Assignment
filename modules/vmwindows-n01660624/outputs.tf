output "hostname" {
  value = azurerm_windows_virtual_machine.vm[*].name
}

output "domain_name" {
  value = azurerm_public_ip.vm_pubip[*].fqdn
}

output "private_ip" {
  value = azurerm_network_interface.vm_nic[*].ip_configuration.0.private_ip_address
}

output "public_ip" {
  value = azurerm_public_ip.vm_pubip[*].ip_address
}
