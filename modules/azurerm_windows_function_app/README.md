



### Module resources
---

* https://docs.microsoft.com/en-us/azure/azure-functions/functions-premium-plan?tabs=azurecli#features

### Module info
---

`app_settimgs` https://docs.microsoft.com/en-us/azure/azure-functions/functions-app-settings        


#### Issues

When choosing dotnet=6, and runtime=~4 then it shows up as as Runtime version custom()~4 and "netFrameworkVersion": "v6.0"
https://github.com/hashicorp/terraform-provider-azurerm/issues/16417
The solution is>
az functionapp config set --net-framework-version v6.0 -n $FunctionApp -g $resourceGroup



#### ERROR


│ Error: creating Windows Function App: (Site Name "*" / Resource Group "*"): web.AppsClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="BadRequest" Message="Creation 
of storage file share failed with: 'The remote server returned an error: (403) Forbidden.'. Please check if the storage account is accessible." Details=[{"Message":"Creation of storage file share failed with: 'The remote server returned an error: (403) Forbidden.'. Please check if the storage account is accessible."},{"Code":"BadRequest"},{"ErrorEntity":{"Code":"BadRequest","ExtendedCode":"99022","Message":"Creation of storage file share failed with: 'The remote server returned an error: (403) Forbidden.'. Please check if the storage account is accessible.","MessageTemplate":"Creation of storage file share failed with: '{0}'. Please check if the storage account is accessible.","Parameters":["The remote server returned an error: (403) Forbidden."]}}]