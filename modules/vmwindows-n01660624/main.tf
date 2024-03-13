resource "azurerm_availability_set" "avset" {
  name                = "${var.humberID}-avset"
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count   = 2
  platform_update_domain_count  = 5
  managed                        = true
}

resource "azurerm_public_ip" "vm_pubip" {
  count               = var.vm_count
  name                = "${var.humberID}-pubip-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  domain_name_label   = "${var.humberID}-vm${count.index}"
}

resource "azurerm_network_interface" "vm_nic" {
  count               = var.vm_count
  name                = "${var.humberID}-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_humberID
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.vm_pubip.*.id, count.index)
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  count                 = var.vm_count
  name                  = "${var.humberID}-vm-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [element(azurerm_network_interface.vm_nic.*.id, count.index)]
  availability_set_id   = azurerm_availability_set.avset.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count               = var.vm_count
  name                = "${var.humberID}-Antimalware-${count.index}"
  virtual_machine_id  = element(azurerm_windows_virtual_machine.vm.*.id, count.index)
  publisher           = "Microsoft.Azure.Security"
  type                = "IaaSAntimalware"
  type_handler_version = "1.5"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
  {
    "AntimalwareEnabled": true,
    "RealtimeProtectionEnabled": true
  }
  SETTINGS
}
