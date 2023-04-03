## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_share.share](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool. | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_allow_public"></a> [allow\_public](#input\_allow\_public) | Allow or disallow nested items within this Account to opt into being public. Defaults to true. | `bool` | `true` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | Manages a Container within Azure Storage. | <pre>list(object({<br>    category    = string<br>    name        = string<br>    access_type = string<br>  }))</pre> | `[]` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | Blob, share, queue and table CORS rule properties | <pre>list(object({<br>    allowed_headers    = list(string)<br>    allowed_methods    = list(string)<br>    allowed_origins    = list(string)<br>    exposed_headers    = list(string)<br>    max_age_in_seconds = number<br>  }))</pre> | `[]` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | n/a | <pre>object({<br>    name   = string # (Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.<br>    verify = bool   # (Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?<br>  })</pre> | <pre>{<br>  "name": null,<br>  "verify": false<br>}</pre> | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | (Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created. | `string` | `null` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Activates RBAC on the resource | `bool` | `false` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | (Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The the location for the storage account. If omittted then the resource group will be used | `string` | `null` | no |
| <a name="input_managed_identity_ids"></a> [managed\_identity\_ids](#input\_managed\_identity\_ids) | (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Windows Virtual Machine Scale Set. | `list(string)` | `[]` | no |
| <a name="input_managed_identity_type"></a> [managed\_identity\_type](#input\_managed\_identity\_type) | (Optional) The type of Managed Identity which should be assigned to the Linux Virtual Machine Scale Set. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned` | `string` | `null` | no |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the storage account. Possible values are TLS1\_0, TLS1\_1, and TLS1\_2. | `string` | `"TLS1_2"` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | (Required) Network rules for the storage account. | <pre>object({<br>    default_action             = string       # (Required) Specifies the default action of allow or deny when no other rules match. When Deny, one of either ip_rules or virtual_network_subnet_ids must be specified.<br>    bypass                     = list(string) # (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.<br>    ip_rules                   = list(string) # (Optional) List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed. /31 and /32 is not allowed<br>    virtual_network_subnet_ids = list(string) # (Optional) A list of resource ids for subnets.<br>    private_link_access = list(object({       #  (Optional) One or More private_link_access block as defined below.<br>      endpoint_resource_id = string           # (Required) The resource id of the resource access rule to be granted access.<br>      endpoint_tenant_id   = string           # (Optional) The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.<br>    }))<br>  })</pre> | <pre>{<br>  "bypass": [<br>    "Logging",<br>    "AzureServices",<br>    "Metrics"<br>  ],<br>  "default_action": "Allow",<br>  "ip_rules": [],<br>  "private_link_access": [],<br>  "virtual_network_subnet_ids": []<br>}</pre> | no |
| <a name="input_rbac_roles"></a> [rbac\_roles](#input\_rbac\_roles) | Role definition name to give access to, ex: Storage Blob Data Contributor. Note: var.enable\_rbac\_authorization must be true | <pre>list(object({<br>    role_definition_name = string<br>    principal_id         = string<br>  }))</pre> | `[]` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | Specifies the number of days that the azurerm\_storage\_share should be retained, between 1 and 365 days. Defaults to 35. Must be higher than softdelete | `number` | `35` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `any` | n/a | yes |
| <a name="input_shares"></a> [shares](#input\_shares) | Manages a File Share within Azure Storage. The permissions which should be associated with this Shared Identifier has a combination of r (read), w (write), d (delete), and l (list) | <pre>list(object({<br>    name        = string<br>    quota       = number<br>    permissions = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connectionstring"></a> [connectionstring](#output\_connectionstring) | Storage accont primary connectionstring |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Storage Account. |
| <a name="output_metric_namespace"></a> [metric\_namespace](#output\_metric\_namespace) | The Resource Metric namespace |
| <a name="output_name"></a> [name](#output\_name) | The name of the Storage Account. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the storage account. |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The endpoint URL for blob storage in the primary location. |
| <a name="output_primary_location"></a> [primary\_location](#output\_primary\_location) | The primary location of the storage account. |
| <a name="output_secondary_blob_endpoint"></a> [secondary\_blob\_endpoint](#output\_secondary\_blob\_endpoint) | The endpoint URL for blob storage in the secondary location. |
| <a name="output_storage_account_tier"></a> [storage\_account\_tier](#output\_storage\_account\_tier) | n/a |
