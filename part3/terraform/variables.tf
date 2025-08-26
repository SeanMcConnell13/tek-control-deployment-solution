variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region (e.g., eastus, westus2)"
  default     = "eastus"
}

variable "prefix" {
  type        = string
  description = "Prefix for resource names"
  default     = "tfweb"
}

variable "admin_ssh_pubkey" {
  type        = string
  description = "SSH public key for the VM admin user (e.g., contents of ~/.ssh/id_rsa.pub)"
}
