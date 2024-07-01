variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "sa-description" {
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
