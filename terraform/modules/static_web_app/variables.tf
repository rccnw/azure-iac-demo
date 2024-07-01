variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "swa-description" {
  description = "Storage Account description"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}



variable "storage_account_name" {}
variable "storage_account_id" {}



variable "storage_account_access_key" {}

variable "resource_group_id" {
  description = "The ID of the resource group"
  type        = string
}