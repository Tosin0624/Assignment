output "vm_names" {
  value = azurerm_linux_virtual_machine.vm[*].name
}

output "domain_names" {
  value = azurerm_public_ip.vm_pubip[*].fqdn
}

output "private_ips" {
  value = azurerm_network_interface.vm_nic[*].private_ip_address
}

output "public_ips" {
  value = azurerm_public_ip.vm_pubip[*].ip_address
}



