# azure-iac-demo
Demo using IaC to create Azure resources

- Azure Resource Group
- Azure Storage Account
- Azure Function
- Azure Static Web App



(Instructions are for Windows 11)

Get the repo with the sample scripts
open a command prompt and navigate to a file location where you would like to download the demo repo.
(best to fork the repo)

git clone https://github.com/rccnw/azure-iac-demo.git

If you didn't fork the repo, then create another folder and copy the files there.


To use Terraform scripts locally, follow these steps:

Make sure you have Terraform installed on your machine. 
You can download it from the official Terraform website at the following links.

Install Terraform:

https://developer.hashicorp.com/terraform/install
https://developer.hashicorp.com/terraform/install#next-steps
https://developer.hashicorp.com/terraform/tutorials/azure-get-started
https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli


You will also need Azure CLI 

Install Azure CLI:

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

Install the Azure CLI and authenticate with your Azure account.

If you have chocolatey, use it to install Terraform (see above links for other options)
https://chocolatey.org/

--Launch cmd prompt in admin mode
    choco install terraform

--confirm:   
    terraform -help
    terraform -help plan


AZ CLI 
(there are various ways to perform az login, here is browser based example)
az login --use-device-code

az account list

If you have multiple subscriptions, note the 'isDefault' property to indicate the active subscription for these commands



Initialize Terraform:
Open a terminal, navigate to your new Terraform project directory, and run:

    terraform init

This will initialize Terraform and download the necessary provider plugins. 
(run it again to resync state if you modify the Azure resources)

Run the following command to see what changes Terraform will make:

(Specify the resource group name as a command line argument)  e.g.:  'upwork-demo-rg'  

    terraform plan -var="resource_group_name=upwork-demo-rg" -out=tfplan

If the plan looks good, apply the changes:
    
    terraform apply "tfplan"

Terraform will ask for confirmation before making any changes.

After applying, you can verify the azure resources are created in the Azure portal or using Azure CLI.

    az group show --name <resource-group-name>
    az group show --name upwork-demo-rg


Remember to run terraform destroy when you're done to clean up the resources and avoid unnecessary costs.


Once again, if you need to iterate terraform code changes, this is the loop:

    terraform plan -var="resource_group_name=upwork-demo-rg" -out=tfplan
    terraform apply "tfplan"


    