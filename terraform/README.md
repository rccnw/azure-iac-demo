# azure-iac-demo  Terraform  README


# Quickstart

1) Create a service principal, save the json credentials result 
2) Copy the 'example.tfvars' file to 'terraform.tfvars' and configure with SP credentials and your settings
3) Login Azure CLI to your account and desired subscription
4) Use the command helper files to perform the Terraform process sequence:  init/plan/apply/destroy


# Helper files

These all presume the use of "tfplan" for the plan file

init.cmd        terraform init
plan.cmd        terraform plan -var-file="terraform.tfvars" -out=tfplan
apply.cmd       terraform apply "tfplan"
detroy.cmd      terraform destroy -var-file="terraform.tfvars"



Follow the instructions here to create Azure infrastructure using Terraform.

Terraform local state is used here for single developer usage. Use remote state for teams.

Ensure local state is syncronized. 
Start with all target Azure resources not existing and no local terraform state files.
Once terraform has been used to create resources, do not modify resources manually.

If in doubt, delete Azure resource group and contents manually in the portal, 
and delete the following local files:

- .terraform.lock.hcl
- terraform.tfstate
- terraform.tfstate.backup
- tfplan




# Requirements:

## Service Principal

Perform this command using your desired Subscription ID
> az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"

This command will return JSON containing info needed by Terraform to manage Azure resources.

*** IMPORTANT:  SAVE THESE VALUES, THEY CANNOT BE VIEWED AGAIN

e.g.: 
{
  "appId"       : "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
  "displayName" : "azure-cli-YYYY-MM-DD-HH-MM-SS",
  "password"    : "XXXXXXXXXXXXXXXXXXXX",
  "tenant"      : "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
}


Provide these values to Terraform as either
- responses to interactive prompts when running 'terraform plan'  or 
- values in terraform.tfvars  or
- environment variables prefixed with 'TF_VAR_'

    client_id            (SP appId)
    client_secret        (SP password)
    subscription_id      (your subscription)
    tenant_id            (SP tenant)

see :
    Create an Azure service principal with Azure CLI  
    https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-1?tabs=bash

You could sign in to Azure with the Service Principal credentials if you want, but not necessary if you configure Terraform with the credentials

## Function authorization key

Generate a GUID and save in the terraform.tfvars file as 'function_auth_key'

## Define Azure region as 'location' in the terraform.tfvars file

e.g. :  'west europe'

## Local variables file

You must create a 'terraform.tfvars' file with values (any name ok, but instructions assume this name)
> \azure-iac-demo\terraform\terraform.tfvars

see example.tfvars, change names as desired and create your own function auth key

Important:  set 'location' value as desired for Azure region

## Environment Variables (these could be in .tfvars file without the TF_VAR_ prefix)

use the value returned from creation of service principal

TF_VAR_client_id            (appId)
TF_VAR_client_secret        (password)
TF_VAR_subscription_id
TF_VAR_tenant_id







## Initialize Terraform:
Open a terminal, navigate to your new Terraform project directory, and run:

> terraform init

This will initialize Terraform and download the necessary provider plugins. 
(run it again to resync state if you destroy or otherwise modify the Azure resources)

Run the following command to see what changes Terraform will make:

(Specify the resource group name as a command line argument)  e.g.:  'upwork-demo-rg'  

> terraform plan -var="resource_group_name=upwork-demo-rg" -out=tfplan

If the plan looks good, apply the changes:
    
> terraform apply "tfplan"

Terraform will ask for confirmation before making any changes.

After applying, you can verify the azure resources are created in the Azure portal or using Azure CLI.

    az group show --name <resource-group-name>

 >  az group show --name upwork-demo-rg


Remember to run terraform destroy when you're done to clean up the resources and avoid unnecessary costs.

>    terraform destroy -var-file="terraform.tfvars"

Once again, if you need to iterate terraform code changes, this is the loop:

>    terraform plan -var-file="terraform.tfvars" -out=tfplan

>    terraform apply "tfplan"



## Note re Function deployment to Function App
To create an HTTP trigger function, we'd typically use the azurerm_function_app_function resource. 
However, since we're using a custom runtime configuration (.NET 8 isolated worker model), 
we'll need to deploy the function code separately. 

You can do this by setting up a CI/CD pipeline or using the Azure CLI after Terraform has created the Function App.

Here's an example of how you might deploy function code using Azure CLI after Terraform has run:
(if for some reason publishing from Visual Studio is not desired)
az functionapp deployment source config-zip -g upwork-demo-rg -n upwork-demo-functionapp --src path/to/your/function.zip



(partial fail apply - fix)
Create a new plan focusing on just the Function App
terraform plan -var-file="terraform.tfvars" -out=newplan -target=azurerm_windows_function_app.fa

terraform plan -var-file="terraform.tfvars" -target=azurerm_windows_function_app.fa



# Dependency Management


see: https://dev.to/pwd9000/terraform-understanding-implicit-and-explicit-dependencies-n9l

using the 'depends_on' attribute toi declare 'explicit dependencies' seems to work well in a scenario without modules.
However, a different technique is required when modules are introduced.
Using resource id's as an 'implicit dependency' is recommended.
Even that may not be sufficient and so in addition using this form is an option:

> depends_on = [module.storage_account]




# Troubleshoot:

check the current role assignments for your service principal
az role assignment list --assignee XXXXXXXXXXXXXXXXXXXXXXXXXX

verify that the service principal credentials are correct
Try logging in with the service principal using Azure CLI


az logout
az account clear
az login --service-principal -u <client_id> -p <client_secret> --tenant <tenant_id>
az account show


(see env vars:)
TF_VAR_client_id=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
TF_VAR_client_secret=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
TF_VAR_subscription_id=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
TF_VAR_tenant_id=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX







TEST

az storage account create --name rccnwtestspaccount7557 --resource-group upwork-demo-rg --location westus2 --sku Standard_LRS

terraform init -reconfigure


HashiCorp Github samples

https://github.com/hashicorp/terraform-provider-azurerm/blob/main/examples/app-service-environment-v3/main.tf






Resource Group
name = "${var.project}-${var.environment}-${var.description}-rg"

Function App
name = "${var.project}-${var.environment}-${var.description}"

Storage Account
"${var.project}${var.environment}${var.description}st"

Static Web App
name = "${var.project}-${var.environment}-${var.description}-wa"



    terraform plan -var-file="terraform.tfvars" -out=tfplan

    terraform apply "tfplan"

terraform destroy -var-file="terraform.tfvars"


    https://developer.hashicorp.com/terraform/install

