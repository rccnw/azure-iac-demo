
# azure-iac-demo  Bicep  README


Files in this folder:

README.md    - this file

(the following files are examples only, if you modify the terraform or the resources, you must discard these and recreate them)

(Before the below files were created, the terraform scripts were run with region=westurope)

wu-rg-arm-template.json         - this arm script file was created by performing Automation/Export Template in the resource group created by terraform.
wu-rg-arm-template.bicep        - this file was created by using azure cli to transform the arm script file to a bicep file.
params.bicep                    - this file is a parameterized version of 'wu-rg-arm-template.bicep'







Bicep scripts are a modern alternative to ARM scripts for use in manual or CI/CD deployment of azure resources.
They serve the same purpose as Terraform scripts, but are native to the Microsoft devops toolchain. Terraform has excellent support as well though.

The file 'resource-group-arm.bicep' will create 3 additional resources within an existing resource group. (See below for how it was created)

after dploying bicep files, pre-existing Resource Group will contain:

- Storage Account
- Function
- Static Web App

This will exactly recrate the infrastructure created by the terraform scripts.

# TODO:  this bicep code is not (yet) parameterized, it needs to be.


# Required:

1) target empty resource group exists
2) local bicep file exists (see how to below)
3) same region as resouce group is declared in bicep.



1) If necessary, create an empty resource group, with the name expected by the bicep for the contained resources. 
    Ideally use the terraform naming scheme 'upwork-<ENV>>-<RESOURCE GROUP NAME>-rg' .  E.G. :  'upwork-prod-resource-group-rg'

    > az group create --name <RESOURCE GROUP NAME> --location <REGION>>

    2) deploy the resources to the resource group as defined in the bicep file.

    >  az deployment group create --resource-group "upwork-prod-resource-group-rg" --template-file "params.bicep" 

    
 



## How resource-group-arm.bicep was created

1) The terraform script was run to deploy azure resources. (set vars as required first)
2) In the created Azure resource group, select Automation export template. This displays an ARM script for all the resources in the resource group.
3) copy the ARM script to a local file 'resource-group-arm.json'.
4) perform az decompilation to create bicep file 'resource-group-arm.bicep': 
    
    > az bicep decompile --file resource-group-arm.json

az bicep decompile --file wu-rg-arm-template.json


# Issues

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