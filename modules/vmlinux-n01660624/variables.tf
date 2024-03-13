variable "humberID" {
  description = "humberID for resource naming to ensure uniqueness"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the VMs"
  type        = string
}

variable "vm_names" {
  description = "Names of the virtual machines"
  type        = list(string)
}

variable "vm_size" {
  description = "Size of the virtual machines"
  type        = string
  default     = "Standard_B1ms"
}

variable "admin_username" {
  description = "Admin username for the VMs"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for the VM admin user"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  
}

variable private_key{

}

variable "subnet_humberID" {
  description = "Subnet ID for the VMs' network interfaces"
  type        = string
}

variable "boot_diagnostics_storage_account_uri" {
  description = "Storage account URI for boot diagnostics"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
