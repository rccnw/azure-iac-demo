# azure-iac-demo
# Demo using IaC to create Azure resources using Terraform or Bicep

- Resource Group
- Storage Account
- Function
- Static Web App


# Requirements:

- Git
- Azure account
- Azure CLI installed >= 2.20
- Terraform 1.90 installed
- terraform-provider-azurerm >= 3.110.0 installed
- Azure Service Principal for Terraform
- Terraform :  target resource group does not exist
- Bicep:       target resource group does exist (manual create or use az cli)
- select an Azure region suitable for these resource type Microsoft.Web/staticSites'
    (List of available regions for the resource type is 'westus2,centralus,eastus2,westeurope,eastasia'.)
    set 'location' value in terraform.tfvars 

See README files in Terraform and Bicep folders for instructions
(Instructions are for Windows)


# Git

If you are reading this, you have the repo
(fork the repo to customize)

git clone https://github.com/rccnw/azure-iac-demo.git


# Tool installation:

## Azure CLI
Install the Azure CLI and authenticate with your Azure account (see 'AZ CLI Login' below)
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli


## Terraform

note: although Terraform can be installed using Choco, best to get latest version from hashicorp

https://developer.hashicorp.com/terraform/install
https://developer.hashicorp.com/terraform/install#next-steps
https://developer.hashicorp.com/terraform/tutorials/azure-get-started
https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli

## Chocolatey
https://docs.chocolatey.org/en-us/choco/setup/

## Install Bicep tools
https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install

via Chocolatey
>   choco install bicep

or 

Bicep Installer
https://github.com/Azure/bicep/releases/latest/download/bicep-setup-win-x64.exe


# AZ CLI Login

There are various ways to perform az login, here is the browser based example - use it if you have problems with az login.

> az login --use-device-code

Other useful commands:

> az account list
> az account show
> az account set
> az logout
> az account clear

If you have multiple Azure subscriptions, note the 'isDefault' property to indicate the active subscription for these commands.
Ensure you are using the desired subscription.

