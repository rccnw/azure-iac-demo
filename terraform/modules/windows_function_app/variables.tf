variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}


variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}


variable "fa-description" {
  description = "The description of the function app"
  type        = string 
}
variable "service_plan_id" {}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

variable "storage_account_access_key" {}
variable "storage_account_name" {}

variable "resource_group_id" {
  description = "The ID of the resource group"
  type        = string
}


variable "random_string_id" {}
variable "storage_account_id" {}
variable "static_web_app_id" {}


