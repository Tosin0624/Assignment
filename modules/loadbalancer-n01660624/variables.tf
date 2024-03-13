variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location to deploy the resources."
  type        = string
}

variable "public_ip_allocation_method" {
  description = "Defines the allocation method for the Load Balancer's Public IP."
  default     = "Static"
  type        = string
}

variable "vm_network_interface_ids" {
  description = "List of the network interface IDs of the VMs to be added to the Load Balancer."
  type        = list(string)
}
