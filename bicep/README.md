
# azure-iac-demo  Bicep  README


# Quickstart

1) Login Azure CLI to your account and desired subscription

2) Ensure you have an empty resource group named 'upwork-prod-resource-group-rg' in region 'West Europe' (to correspond with sample bicep file)

3) use az cli to deploy the sample 'params.bicep' bicep file:

    > az deployment group create --resource-group "upwork-prod-resource-group-rg" --template-file "params.bicep" 


# Next Steps

1) Parameterize the bicep file further, this is only a demo level of params provided by the Azure CLI 'az bicep decompile' operation.

2) Decide which path going forward to modify resources:
    a) Terraform first : Modify terraform scripts, apply them to Azure, export ARM templates, convert to bicep with az cli, and redeploy with az cli
    b) Bicep first:  modify bicep file and deploy with az cli
    c) Azure first:  modify azure resource in portal, and export ARM templates, convert to bicep with az cli, and redeploy with az cli


# Required:

1) target empty resource group exists
2) local bicep file exists (see how to below)
3) same region as resouce group is declared in bicep.


## Files in this folder:

- README.md    - this file

(the following files are examples only, if you modify the terraform or the resources, you must discard these and recreate them)
(Before the below files were created, the terraform scripts were run with region=westurope)

- wu-rg-arm-template.json         - this arm script file was created by performing Automation/Export Template in the resource group created by terraform.
- wu-rg-arm-template.bicep        - this file was created by using azure cli to transform the arm script file to a bicep file.
- params.bicep                    - this file is a parameterized version of 'wu-rg-arm-template.bicep'


after deploying the samnple bicep file, the pre-existing Resource Group will contain:

- Storage Account
- Function
- Static Web App

This will exactly recrate the infrastructure created by the terraform scripts.





1) If necessary, create an empty resource group, with the name expected by the bicep for the contained resources. 
    Ideally use the terraform naming scheme 'upwork-<ENV>>-<RESOURCE GROUP NAME>-rg' .  E.G. :  'upwork-prod-resource-group-rg'

    > az group create --name <RESOURCE GROUP NAME> --location <REGION>>

    2) deploy the resources to the resource group as defined in the bicep file.

    >  az deployment group create --resource-group "upwork-prod-resource-group-rg" --template-file "params.bicep" 

    
 



## How params.bicep was created

1) The terraform script was run to deploy azure resources. (set vars as required first)

2) In the created Azure resource group, select Automation export template. This displays an ARM script for all the resources in the resource group.

3) copy the ARM script to a local file  e,g,:  'wu-rg-arm-template.json'.
    > az bicep decompile --file wu-rg-arm-template.json

4) perform az decompilation to create bicep file 
    > az bicep decompile --file wu-rg-arm-template.json

    this will produce file:  wu-rg-arm-template.bicep

5) rename 'wu-rg-arm-template.bicep'  to 'params.bicep' (if you want) to use as a starting point for further customizations



# Issues


## disclaimer
 - below are warnings that were reported during the process.  No changes were made based on these warning, but superficially everything seems to have worked



In the Azure Portal resource group overview, selecting Automation/Export Template produces a json template, but also reports an error:

'2 resource types cannot be exported yet and are not included in the template'

## Resources of this type will not be exported: 
 - Microsoft.Web/sites/sitecontainer
 - Microsoft.Web/sites/hybridconnection


{"code":"ExportTemplateCompletedWithErrors","message":"Export template operation completed with errors. Some resources were not exported. Please see details for more information.","details":[{"code":"ExportTemplateProviderError","target":"Microsoft.Web/sites/sitecontainers","message":"Could not get resources of the type 'Microsoft.Web/sites/sitecontainers'. Resources of this type will not be exported."},{"code":"ExportTemplateProviderError","target":"Microsoft.Web/sites/hybridconnection","message":"Could not get resources of the type 'Microsoft.Web/sites/hybridconnection'. Resources of this type will not be exported."}]}


## Performing the bicep decompile from arm to bicep produces these warnings:


WARNING: Decompilation is a best-effort process, as there is no guaranteed mapping from ARM JSON to Bicep Template or Bicep Parameters.
You may need to fix warnings and errors in the generated bicep/bicepparam file(s), or decompilation may fail entirely if an accurate conversion is not possible.
If you would like to report any issues or inaccurate conversions, please see https://github.com/Azure/bicep/issues.
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(15,5) : Warning BCP073: The property "tier" is read-only. Expressions cannot be assigned to read-only properties. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(107,3) : Warning BCP073: The property "sku" is read-only. Expressions cannot be assigned to read-only properties. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(125,3) : Warning BCP073: The property "sku" is read-only. Expressions cannot be assigned to read-only properties. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(221,3) : Warning BCP187: The property "location" does not exist in the resource or type definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(222,3) : Warning BCP187: The property "tags" does not exist in the resource or type definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(234,3) : Warning BCP187: The property "location" does not exist in the resource or type definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(235,3) : Warning BCP187: The property "tags" does not exist in the resource or type definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(247,3) : Warning BCP187: The property "location" does not exist in the resource or type definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(248,3) : Warning BCP187: The property "tags" does not exist in the resource or type definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(329,3) : Warning BCP187: The property "location" does not exist in the resource or type definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(339,3) : Warning BCP187: The property "location" does not exist in the resource or type definition, although it might still be valid. If this is an inaccuracy in the documentation, please report it to the Bicep Team. [https://aka.ms/bicep-type-issues]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(357,5) : Warning no-unnecessary-dependson: Remove unnecessary dependsOn entry 'storageAccounts_upworkprodstgacctsa_name_resource'. [https://aka.ms/bicep/linter/no-unnecessary-dependson]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(373,5) : Warning no-unnecessary-dependson: Remove unnecessary dependsOn entry 'storageAccounts_upworkprodstgacctsa_name_resource'. [https://aka.ms/bicep/linter/no-unnecessary-dependson]
D:\Dev2024\git-rccnw\azure-iac-demo\bicep\wu-rg-arm-template.bicep(386,5) : Warning no-unnecessary-dependson: Remove unnecessary dependsOn entry 'storageAccounts_upworkprodstgacctsa_name_resource'. [https://aka.ms/bicep/linter/no-unnecessary-dependson]

# END