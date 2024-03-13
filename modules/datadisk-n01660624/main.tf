resource "azurerm_managed_disk" "tfdatadisk" {
  count                = length(var.vm_ids)
  name                 = "${var.humberID}-datadisk-${format("%02d", count.index)}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "tfdatadisk-attachment" {
  count              = length(var.vm_ids)
  managed_disk_id    = azurerm_managed_disk.tfdatadisk[count.index].id
  virtual_machine_id = element(var.vm_ids, count.index)
  lun                = count.index
  caching            = "ReadWrite"
}
