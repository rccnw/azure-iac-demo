# these are from the Service Principal
variable "client_id" {
  type = string
  description = "Access key for API access"
}

variable "client_secret" {
  type = string
  description = "Secret key for API access"
}
variable "subscription_id" {}
variable "tenant_id" {}


# These are developer defined variables

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment type"
  type        = string
}


variable "location" {
  description = "The Azure Region to deploy resources"
  default     = "West US 2"
}

variable "function_auth_key" {
  type        = string
  description = "Authentication key for the HTTP trigger function"
  sensitive   = true
}


variable "rg-description" {
  description = "The description of the resource"
  type        = string
}

variable "swa-description" {
  description = "The description of the static web app"
  type        = string 
}

variable "sa-description" {
  description = "The description of the static web app"
  type        = string 
}

variable "sp-description" {
  description = "The description of the service plan"
  type        = string 
}

variable "fa-description" {
  description = "The description of the function app"
  type        = string 
}