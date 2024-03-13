resource "azurerm_availability_set" "vm_avset" {
  name                = "${var.humberID}-avset"
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count   = 2
  platform_update_domain_count  = 5
  tags                          = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = length(var.vm_names)
  name                = var.vm_names[count.index]
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.vm_nic[count.index].id]
  availability_set_id = azurerm_availability_set.vm_avset.id
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }
  computer_name                   = var.vm_names[count.index]
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }
  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  tags = var.tags
}

resource "azurerm_public_ip" "vm_pubip" {
  count               = length(var.vm_names)
  name                = "${var.vm_names[count.index]}-pubip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.humberID}-${var.vm_names[count.index]}"
  tags                = var.tags
}

resource "azurerm_network_interface" "vm_nic" {
  count               = length(var.vm_names)
  name                = "${var.vm_names[count.index]}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_humberID
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pubip[count.index].id
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  count = length(var.vm_names)
  name                 = "NetworkWatcherAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
}

# Azure Monitor Extension
# resource "azurerm_virtual_machine_extension" "azure_monitor" {
#   count                      = var.nb_count
#   name                       = "AzureMonitorLinuxAgent${count.index}"
#   virtual_machine_id         = element(azurerm_linux_virtual_machine.n01392662_vm.*.id, count.index)
#   publisher                  = "Microsoft.Azure.Monitor"
#   type                       = "AzureMonitorLinuxAgent"
#   type_handler_version       = "1.0"
#   auto_upgrade_minor_version = true
#   tags                       = var.tags
# }



resource "azurerm_virtual_machine_extension" "azure_monitor" {
  count = length(var.vm_names)
  name                 = "AzureMonitorLinuxAgent${count.index}"
  virtual_machine_id   = element(azurerm_linux_virtual_machine.vm.*.id, count.index)
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true
}

