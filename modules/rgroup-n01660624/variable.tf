variable "humberID" {
  description = "humberID used to ensure resource name uniqueness, e.g., last 4 digits of your Humber ID"
  type        = string
}

variable "location" {
  description = "Azure region where the resource group will be created"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the resource group"
  type        = map(string)
  default     = {}
}
