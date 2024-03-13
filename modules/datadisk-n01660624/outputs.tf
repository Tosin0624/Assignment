output "managed_disk_ids" {
  value = azurerm_managed_disk.tfdatadisk.*.id
}

output "managed_disk_names" {
  value = azurerm_managed_disk.tfdatadisk.*.name
}
