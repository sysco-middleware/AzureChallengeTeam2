## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_certificate.cert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_key.key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_management_lock.kv_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_role_assignment.role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [null_resource.kv_recover](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policies"></a> [access\_policies](#input\_access\_policies) | The Access Policies. This is ignored if variable 'enable\_rbac\_authorization' is true. | <pre>list(object({<br>    object_id               = string       # (Required) The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.<br>    key_permissions         = list(string) # "Create", "Get", "Purge", "Recover", "List", "Delete", "Update", "Backup", "Restore"<br>    secret_permissions      = list(string) # "Get", "List", "Set", "Delete", "Purge", "Recover", "Backup", "Restore"<br>    certificate_permissions = list(string) # "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"<br>    storage_permissions     = list(string) # "Backup", "Delete","Get","List","Restore","Update","Recover","RegenerateKey". Is ignored if sku is premium. <br>  }))</pre> | `[]` | no |
| <a name="input_access_policies_rbac"></a> [access\_policies\_rbac](#input\_access\_policies\_rbac) | Predifined Access Policy permissions using RBAC definition names. This is ignored if variable 'enable\_rbac\_authorization' is true. | <pre>list(object({<br>    object_id        = string # (Required) The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.<br>    key_role         = string # Owner, Contributor, Reader<br>    secret_role      = string # Owner, Contributor, Reader<br>    certificate_role = string # Owner, Contributor, Reader<br>    storage_role     = string # Owner, Contributor, Reader. Is ignored if sku is premium. <br>  }))</pre> | <pre>[<br>  {<br>    "certificate_role": "Contributor",<br>    "key_role": "Contributor",<br>    "object_id": null,<br>    "secret_role": "Contributor",<br>    "storage_role": "Reader"<br>  }<br>]</pre> | no |
| <a name="input_certificates_pfx"></a> [certificates\_pfx](#input\_certificates\_pfx) | A list of Key Vault PFX certificates | <pre>list(object({<br>    name     = string<br>    pfx_file = string<br>    password = string<br>  }))</pre> | `[]` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Activates RBAC on the resource | `bool` | `false` | no |
| <a name="input_keys"></a> [keys](#input\_keys) | A list of Key Vault Keys. | <pre>list(object({<br>    name     = string<br>    key_type = string       # RSA<br>    key_size = number       # 2048<br>    key_opts = list(string) # If empty the all rights are added<br>  }))</pre> | `[]` | no |
| <a name="input_lock_resource"></a> [lock\_resource](#input\_lock\_resource) | Adds lock level CanNotDelete to the resource | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | (Required) Network rules for the Key Vault. | <pre>object({<br>    default_action             = string       # (Required) Specifies the default action of allow or deny when no other rules match.<br>    bypass                     = string       # (Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None.<br>    ip_rules                   = list(string) # (Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault.<br>    virtual_network_subnet_ids = list(string) # (Optional) One or more Subnet ID's which should be able to access this Key Vault.<br>  })</pre> | <pre>{<br>  "bypass": "AzureServices",<br>  "default_action": "Allow",<br>  "ip_rules": [],<br>  "virtual_network_subnet_ids": []<br>}</pre> | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | CAUSES PROBLEMS IN TERRAFORM!! (Optional) Is Purge Protection enabled for this Key Vault? Defaults to false. Once Purge Protection is enabled, this option cannot be disabled. | `bool` | `null` | no |
| <a name="input_rbac_roles"></a> [rbac\_roles](#input\_rbac\_roles) | Role definition name to give access to, ex: Key Vault Administrator. Note: var.enable\_rbac\_authorization must be true | <pre>list(object({<br>    role_definition_name = string<br>    principal_id         = string<br>  }))</pre> | `[]` | no |
| <a name="input_recover_keyvault"></a> [recover\_keyvault](#input\_recover\_keyvault) | Tries to Recover Keyvault is previously deleted within soft\_delete\_retention\_days | `bool` | `false` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `any` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | A list of Key Vault secrets | <pre>list(object({<br>    name         = string<br>    value        = string<br>    content_type = string<br>  }))</pre> | `[]` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium. | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days (7-90) that items should be retained for once soft-deleted. Can't changes this after deploy | `number` | `14` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | key vault id |
| <a name="output_key_ids"></a> [key\_ids](#output\_key\_ids) | key vault key ids |
| <a name="output_name"></a> [name](#output\_name) | key vault name |
| <a name="output_secret_ids"></a> [secret\_ids](#output\_secret\_ids) | key vault key secrets |
| <a name="output_sku"></a> [sku](#output\_sku) | Sku name |
| <a name="output_url"></a> [url](#output\_url) | key vault url |
