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

Note:  ensure that you install Terraform Core 1.90 and terraform-provider-azurerm 3.110.0

https://github.com/hashicorp/terraform-provider-azurerm/blob/main/CHANGELOG.md
azurerm_static_web_app  requires terraform-provider-azurerm version >= 3.95.0


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
(there are various ways to perform az login, here is the browser based example - use it if you have problems with az login)
az login --use-device-code

az account list

If you have multiple subscriptions, note the 'isDefault' property to indicate the active subscription for these commands



Initialize Terraform:
Open a terminal, navigate to your new Terraform project directory, and run:

    terraform init

This will initialize Terraform and download the necessary provider plugins. 
(run it again to resync state if you destroy or otherwise modify the Azure resources)

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

    terraform destroy -var-file="terraform.tfvars"

Once again, if you need to iterate terraform code changes, this is the loop:

    terraform plan -var-file="terraform.tfvars" -out=tfplan

    terraform apply "tfplan"



Notes re azurerm_service_plan plan selection 'Y1'

The "Y1" SKU specifically refers to the Consumption plan for Azure Functions:
Y: Indicates that this is a Consumption (serverless) plan
1: Denotes the performance tier within the Consumption plan category

Key characteristics of the Y1 (Consumption) plan:

Serverless: It automatically scales based on workload.
Pay-per-use: You're billed based on the number of executions, execution time, and memory used.
No dedicated compute resources: Resources are allocated dynamically as needed.
Ideal for sporadic workloads or when you want to minimize costs for low-usage scenarios.



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



troubleshoot:

check the current role assignments for your service principal
az role assignment list --assignee 19ea67f7-e415-43ac-a5b6-35eb4ee77801

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




az login --service-principal -u 19ea67f7-e415-43ac-a5b6-35eb4ee77801 -p Bvc8Q~AJYEwoeC3yE9vXMFMfsH-df0RMBRVSQc4D --tenant d7a6613d-4ffe-429b-a248-93557529b50f


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

