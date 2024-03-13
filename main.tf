module "rgroup-n01660624" {
  source   = "./modules/rgroup-n01660624"
  humberID = "n01660624" # Replace with the last 4 digits of your Humber ID
  location = "East US"   # Choose your Azure region
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Oluwatosin Jimoh"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "network-n01660624" {
  source              = "./modules/network-n01660624"
  humberID            = "n01660624" # Replace with your actual Humber ID
  location            = "East US"
  resource_group_name = module.rgroup-n01660624.resource_group_name
  address_space       = "10.0.0.0/16"
  subnet_humberID     = "10.0.1.0/24"
  #subnet_id = data.azurerm_subnet.subnet_humberID.id

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Oluwatosin Jimoh"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "common-n01660624" {
  source              = "./modules/common-n01660624"
  humberID            = "n01660624" # Your unique humberID
  location            = "East US"
  resource_group_name = module.rgroup-n01660624.resource_group_name
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Oluwatosin Jimoh"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "vmlinux-n01660624" {
  source                               = "./modules/vmlinux-n01660624"
  humberID                             = "n01660624"
  location                             = "East US"
  resource_group_name                  = module.rgroup-n01660624.resource_group_name
  vm_names                             = ["vm1", "vm2", "vm3", "vm4"]
  admin_username                       = "adminuser"
  ssh_public_key                       = "~/.ssh/id_rsa.pub"
  private_key                          = "~/.ssh/id_rsa"
  subnet_humberID                      = module.network-n01660624.subnet_humberID
  boot_diagnostics_storage_account_uri = module.common-n01660624.storage_account_name
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Oluwatosin Jimoh"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "vmwindows-n01660624" {
  source                               = "./modules/vmwindows-n01660624"
  humberID                             = "n01660624"
  location                             = "eastus"
  resource_group_name                  = module.rgroup-n01660624.resource_group_name
  subnet_humberID                      = module.network-n01660624.subnet_humberID
  admin_username                       = "adminuser"
  admin_password                       = "HumberR0cksAllSeason#"
  boot_diagnostics_storage_account_uri = module.common-n01660624.storage_account_name
  # tags = {
  #   Assignment     = "CCGC 5502 Automation Assignment"
  #   Name           = "Oluwatosin Jimoh"
  #   ExpirationDate = "2024-12-31"
  #   Environment    = "Learning"
  # } 
}

module "datadisk-n01660624" {
  source              = "./modules/datadisk-n01660624"
  humberID            = "n01660624"
  resource_group_name = module.rgroup-n01660624.resource_group_name
  location            = "East US"
  vm_ids              = [#"vm-id-1", "vm-id-2", "vm-id-3", "vm-id-4"
                        "/subscriptions/0e7e167a-9101-4303-bc89-276fab9073d2/resourceGroups/n01660624-RG/providers/Microsoft.Compute/virtualMachines/vm1",
                        "/subscriptions/0e7e167a-9101-4303-bc89-276fab9073d2/resourceGroups/n01660624-RG/providers/Microsoft.Compute/virtualMachines/vm2",
                        "/subscriptions/0e7e167a-9101-4303-bc89-276fab9073d2/resourceGroups/n01660624-RG/providers/Microsoft.Compute/virtualMachines/vm3",
                        "/subscriptions/0e7e167a-9101-4303-bc89-276fab9073d2/resourceGroups/n01660624-RG/providers/Microsoft.Compute/virtualMachines/vm4",
                        ]
}

module "loadbalancer-n01660624" {
  source                     = "./modules/loadbalancer-n01660624"
  resource_group_name        = module.rgroup-n01660624.resource_group_name
  location                   = "East US"
  vm_network_interface_ids   = [#"nic-id-1", "nic-id-2", "nic-id-3"
                                "/subscriptions/0e7e167a-9101-4303-bc89-276fab9073d2/resourceGroups/n01660624-RG/providers/Microsoft.Network/networkInterfaces/vm1-nic",
                                "/subscriptions/0e7e167a-9101-4303-bc89-276fab9073d2/resourceGroups/n01660624-RG/providers/Microsoft.Network/networkInterfaces/vm2-nic",
                                "/subscriptions/0e7e167a-9101-4303-bc89-276fab9073d2/resourceGroups/n01660624-RG/providers/Microsoft.Network/networkInterfaces/vm3-nic",
                                "/subscriptions/0e7e167a-9101-4303-bc89-276fab9073d2/resourceGroups/n01660624-RG/providers/Microsoft.Network/networkInterfaces/vm4-nic",
                                ]
}

module "database-n01660624" {
  source                = "./modules/database-n01660624"
  db_name               = "dbserver-n01660624"
  administrator_login   = "postgresadmin"
  administrator_password = "HumberR0cksallseason!"
  resource_group_name   = module.rgroup-n01660624.resource_group_name
  location              = "East US"
  sku_name              = "B_Gen5_1"
}



# module "loadbalancer-n01660624" {
#   source                = "./modules/loadbalancer-n01660624"
#   resource_group_name   = module.rgroup-n01660624.resource_group_name
#   location              = "East US"
#   public_ip_address_id  = module.vmwindows-n01660624.vm_nic
#   vm_ids                = [azurerm_network_interface.vm1.id, azurerm_network_interface.vm2.id, azurerm_network_interface.vm3.id]
# }



# data "azurerm_subnet" "subnet_humberID" {
#   name                 = "n01660624-subnet"
#   virtual_network_name = "n01660624-VNET"
#   resource_group_name  = module.rgroup-n01660624.resource_group_name
# }