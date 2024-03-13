variable "humberID" {
  description = "Prefix for resource names to ensure uniqueness"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "address_space" {
  description = "The address space for the VNet"
  type        = string
}

variable "subnet_humberID" {
  description = "The address prefix for the subnet"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default     = {}
}
