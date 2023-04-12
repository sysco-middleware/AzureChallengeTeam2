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
| [azurerm_app_service.wa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service) | resource |
| [azurerm_app_service.wa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/app_service) | data source |
| [azurerm_app_service_plan.asp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/app_service_plan) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_command_line"></a> [app\_command\_line](#input\_app\_command\_line) | App service command line | `string` | `null` | no |
| <a name="input_app_insights"></a> [app\_insights](#input\_app\_insights) | Aplication insights | <pre>object({<br>    enabled             = bool<br>    instrumentation_key = string<br>    connection_string   = string<br>  })</pre> | <pre>{<br>  "connection_string": null,<br>  "enabled": false,<br>  "instrumentation_key": null<br>}</pre> | no |
| <a name="input_app_kind"></a> [app\_kind](#input\_app\_kind) | The App Service operating system type: Windows of Linux | `string` | `"windows"` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | Map of App Settings. This will be merged with default app settings | `map(string)` | `{}` | no |
| <a name="input_application_logs"></a> [application\_logs](#input\_application\_logs) | Application logs for the App Service | <pre>object({<br>    enabled = bool<br>    azure_blob_storage = object({<br>      level             = string # (Required) The level at which to log. Possible values include Error, Warning, Information, Verbose and Off. NOTE: this field is not available for http_logs<br>      sas_url           = string # (Required) The URL to the storage container with a shared access signature token appended.<br>      retention_in_days = number # (Required) The number of days to retain logs for.<br>    })<br>    file_system_level = string # (Optional) Log level for filesystem based logging. Supported values are Error, Information, Verbose, Warning and Off. Defaults to Off.<br>  })</pre> | <pre>{<br>  "azure_blob_storage": {<br>    "level": "Off",<br>    "retention_in_days": 10,<br>    "sas_url": null<br>  },<br>  "enabled": false,<br>  "file_system_level": "Off"<br>}</pre> | no |
| <a name="input_asp_name"></a> [asp\_name](#input\_asp\_name) | n/a | `any` | n/a | yes |
| <a name="input_auth_settings"></a> [auth\_settings](#input\_auth\_settings) | Authentication Settings | <pre>list(object({<br>    enabled  = bool<br>    provider = string<br>    active_directory = object({<br>      client_id     = string<br>      client_secret = string<br>      audiences     = list(string)<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | Backup for the App Service | <pre>object({<br>    name                = string # (Required) Specifies the name for this Backup<br>    enabled             = bool   # (Required) Is this Backup enabled?<br>    storage_account_url = string<br>    schedule = object({<br>      frequency_interval       = string # (Required) Sets how often the backup should be executed.<br>      frequency_unit           = string # (Optional) Sets the unit of time for how often the backup should be executed. Possible values are Day or Hour.<br>      keep_at_least_one_backup = bool   # (Optional) Should at least one backup always be kept in the Storage Account by the Retention Policy, regardless of how old it is?<br>      retention_period_in_days = string # (Optional) Specifies the number of days after which Backups should be deleted.<br>      start_time               = string # (Optional) Sets when the schedule should start working.<br>    })<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "name": "backup",<br>  "schedule": {<br>    "frequency_interval": 1,<br>    "frequency_unit": "Day",<br>    "keep_at_least_one_backup": false,<br>    "retention_period_in_days": 1,<br>    "start_time": null<br>  },<br>  "storage_account_url": null<br>}</pre> | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | Is this Backup enabled? | `bool` | `true` | no |
| <a name="input_client_affinity_enabled"></a> [client\_affinity\_enabled](#input\_client\_affinity\_enabled) | Should the App Service send session affinity cookies, which route client requests in the same session to the same instance? Disable for performance | `bool` | `false` | no |
| <a name="input_client_cert_enabled"></a> [client\_cert\_enabled](#input\_client\_cert\_enabled) | Does the App Service require client certificates for incoming requests? | `bool` | `false` | no |
| <a name="input_client_cert_mode"></a> [client\_cert\_mode](#input\_client\_cert\_mode) | (Optional) Mode of client certificates for this App Service. Possible values are Required, Optional and OptionalInteractiveUser. If this parameter is set, client\_cert\_enabled must be set to true, otherwise this parameter is ignored. | `string` | `"OptionalInteractiveUser"` | no |
| <a name="input_connection_strings"></a> [connection\_strings](#input\_connection\_strings) | A list of connectionstrings | <pre>list(object({<br>    name = string<br>    type = string<br>    conn = string<br>  }))</pre> | `[]` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | Cross-Origin Resource Sharing (CORS) allows JavaScript code running in a browser on an external host to interact with your backend | <pre>object({<br>    enabled             = bool<br>    allowed_origins     = list(string) # A list of origins which should be able to make cross-origin calls<br>    support_credentials = bool         # (Optional) Are credentials supported?<br>  })</pre> | <pre>{<br>  "allowed_origins": [<br>    "*"<br>  ],<br>  "enabled": false,<br>  "support_credentials": true<br>}</pre> | no |
| <a name="input_detailed_error_messages_enabled"></a> [detailed\_error\_messages\_enabled](#input\_detailed\_error\_messages\_enabled) | (Optional) Should Detailed error messages be enabled on this App Service? Default is false. | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Is the App Service Enabled? | `bool` | `true` | no |
| <a name="input_failed_request_tracing_enabled"></a> [failed\_request\_tracing\_enabled](#input\_failed\_request\_tracing\_enabled) | (Optional) Should Failed request tracing be enabled on this App Service? Defaults to false. | `bool` | `false` | no |
| <a name="input_ftps_state"></a> [ftps\_state](#input\_ftps\_state) | (Optional) State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled. AppService log requires this to be activated. | `string` | `"FtpsOnly"` | no |
| <a name="input_fx_version"></a> [fx\_version](#input\_fx\_version) | Web server side version: DOTNETCORE\|3.1, PYTHON\|3.9, etc | `string` | `"DOTNETCORE|3.1"` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | (Optional) The health check path to be pinged by App Service. https://azure.github.io/AppService/2020/08/24/healthcheck-on-app-service.html | `string` | `"/"` | no |
| <a name="input_http_logs"></a> [http\_logs](#input\_http\_logs) | HTTP logs for the App Service | <pre>object({<br>    enabled = bool<br>    file_system = object({<br>      retention_in_days = number # (Required) The number of days to retain logs for.<br>      retention_in_mb   = number # (Required) The maximum size in megabytes that http log files can use before being removed. <br>    })<br>    azure_blob_storage = object({<br>      sas_url           = string<br>      retention_in_days = number<br>    })<br>  })</pre> | <pre>{<br>  "azure_blob_storage": {<br>    "retention_in_days": 10,<br>    "sas_url": null<br>  },<br>  "enabled": false,<br>  "file_system": {<br>    "retention_in_days": 1,<br>    "retention_in_mb": 10<br>  }<br>}</pre> | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | Can the App Service only be accessed via HTTPS? | `bool` | `true` | no |
| <a name="input_ip_restrictions"></a> [ip\_restrictions](#input\_ip\_restrictions) | The IP Address used for this IP Restriction. One of either ip\_address, service\_tag or virtual\_network\_subnet\_id must be specified. IP\_address should be CIDR or IP-address/32 | <pre>list(object({<br>    name                      = string<br>    action                    = string<br>    priority                  = number<br>    ip_address                = string # (Optional) The IP Address used for this IP Restriction in CIDR notation.<br>    virtual_network_subnet_id = string<br>    service_tag               = string # (Optional) The Service Tag used for this IP Restriction<br>    headers = list(object({<br>      x_azure_fdid      = set(string)<br>      x_fd_health_probe = set(string)<br>      x_forwarded_for   = set(string)<br>      x_forwarded_host  = set(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The number of days to retain http or/and application logs for. | `number` | `8` | no |
| <a name="input_retention_in_mb"></a> [retention\_in\_mb](#input\_retention\_in\_mb) | The maximum size in megabytes that http log files can use before being removed. | `number` | `100` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `any` | n/a | yes |
| <a name="input_scm_type"></a> [scm\_type](#input\_scm\_type) | (Optional) The type of Source Control enabled for this App Service. Defaults to None. Possible values are: BitbucketGit, BitbucketHg, CodePlexGit, CodePlexHg, Dropbox, ExternalGit, ExternalHg, GitHub, LocalGit, None, OneDrive, Tfs, VSO, and VSTSRM | `string` | `"None"` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | This mounts the website on a storage account. Note: Will get '503 service unavailable', if the share isn't created | <pre>object({<br>    enabled      = bool<br>    name         = string # (Required) The name of the storage account identifier.<br>    type         = string # (Required) The type of storage. Possible values are AzureBlob and AzureFiles<br>    share_name   = string # (Required) The name of the file share (container name, for Blob storage)<br>    access_key   = string # (Required) The access key for the storage account.<br>    account_name = string # (Required) The name of the storage account<br>    mount_path   = string # (Optional) The path to mount the storage within the site's runtime environment. Ex: /var/www/html/assets<br>  })</pre> | <pre>{<br>  "access_key": null,<br>  "account_name": null,<br>  "enabled": false,<br>  "mount_path": null,<br>  "name": null,<br>  "share_name": null,<br>  "type": "AzureFiles"<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_use_32_bit_worker_process"></a> [use\_32\_bit\_worker\_process](#input\_use\_32\_bit\_worker\_process) | (Optional) Should the Function App run in 32 bit mode, rather than 64 bit mode?. When using an App Service Plan in the Free or Shared Tiers use\_32\_bit\_worker\_process must be set to true. | `bool` | `false` | no |
| <a name="input_vnet_route_all_enabled"></a> [vnet\_route\_all\_enabled](#input\_vnet\_route\_all\_enabled) | (Optional) Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied? Defaults to false. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_domain_verification_id"></a> [custom\_domain\_verification\_id](#output\_custom\_domain\_verification\_id) | An identifier used by App Service to perform domain ownership verification via DNS TXT record. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Web App |
| <a name="output_identity"></a> [identity](#output\_identity) | An identity block as defined below, which contains the Managed Service Identity information for this App Service. |
| <a name="output_outbound_ip_addresses"></a> [outbound\_ip\_addresses](#output\_outbound\_ip\_addresses) | A list of outbound IP addresses |
| <a name="output_possible_outbound_ip_addresses"></a> [possible\_outbound\_ip\_addresses](#output\_possible\_outbound\_ip\_addresses) | A list of outbound IP addresses - such as 52.23.25.3,52.143.43.12,52.143.43.17 - not all of which are necessarily in use. Superset of outbound\_ip\_addresses. |
