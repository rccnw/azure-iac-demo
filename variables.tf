variable "client_id" {
  type = string
  description = "Access key for API access"
}

variable "client_secret" {
  type = string
  description = "Secret key for API access"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = ""
}


variable "subscription_id" {}
variable "tenant_id" {}


variable "location" {
  description = "The Azure Region to deploy resources"
  default     = "West US 2"
}