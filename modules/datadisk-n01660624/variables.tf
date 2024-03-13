variable "humberID" {
  description = "A humberID for the resources' names to ensure uniqueness"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the managed disk."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "vm_ids" {
  description = "List of Virtual Machine IDs to attach the disks to."
  type        = list(string)
}

variable "disk_size_gb" {
  description = "The size of the managed disk in GB."
  default     = 10
  type        = number
}
