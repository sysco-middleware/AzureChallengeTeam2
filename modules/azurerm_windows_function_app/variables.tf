variable "enabled" {
  type        = bool
  description = "Is the App Service Enabled?"
  default     = true
}
variable "always_on" {
  type        = bool
  description = "(Optional) If this Windows Function App is Always On enabled. Defaults to true."
  default     = false
}
variable "name" {}
variable "rg_name" {}
variable "asp_name" {}
variable "sa_name" {}
variable "managed_identity_type" {
  type        = string
  description = "(Optional) The type of Managed Identity which should be assigned to the Linux Virtual Machine Scale Set. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`"
  default     = null
  validation {
    condition     = can(regex("^SystemAssigned$|^UserAssigned$|^SystemAssigned, UserAssigned$", var.managed_identity_type))
    error_message = "The variable 'managed_identity_type' must be: SystemAssigned, or UserAssigned or `SystemAssigned, UserAssigned`."
  }
}
variable "managed_identity_ids" {
  type        = list(string)
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Windows Virtual Machine Scale Set."
  default     = []
}
variable "auth_settings" {
  type = list(object({
    enabled                   = bool   # (Required) Should the Authentication / Authorization feature be enabled for the Windows Function App?
    default_provider          = string # (Optional) The default authentication provider to use when multiple providers are configured. Possible values include: AzureActiveDirectory, Facebook, Google, MicrosoftAccount, Twitter, Github
    unauth_client_action      = string # (Optional) The action to take when an unauthenticated client attempts to access the app. Possible values include: RedirectToLoginPage, AllowAnonymous.
    token_store_enabled       = bool   # (Optional) Should the Windows Function App durably store platform-specific security tokens that are obtained during login flows? Defaults to false.
    allowed_ext_redirect_urls = list(string)
    runtime_version           = string # Optional) The Runtime Version of the Authentication / Authorization feature in use for the Windows Function App. Choose between 1 (default) and 2
    active_directory = object({
      client_id     = string       # (Required) The ID of the Client to use to authenticate with Azure Active Directory.
      client_secret = string       # (Optional) The Client Secret for the Client ID. Cannot be used with client_secret_setting_name
      audiences     = list(string) # (Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory.
      # client_secret_setting_name - (Optional) The App Setting name that contains the client secret of the Client. Cannot be used with client_secret.
    })
    microsoft = object({
      client_id     = string # (Required) The OAuth 2.0 client ID that was created for the app used for authentication.
      client_secret = string # (Optional) The OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with client_secret_setting_name.
      # oauth_scopes - (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, wl.basic is used as the default scope.
    })

  }))
  description = "Authentication Settings"
  default     = []
}
variable "backup" {
  type = object({
    name                = string # (Required) Specifies the name for this Backup
    enabled             = bool   # (Required) Is this Backup enabled?
    storage_account_url = string
    schedule = object({
      frequency_interval       = string # (Required) Sets how often the backup should be executed.
      frequency_unit           = string # (Optional) Sets the unit of time for how often the backup should be executed. Possible values are Day or Hour.
      keep_at_least_one_backup = bool   # (Optional) Should at least one backup always be kept in the Storage Account by the Retention Policy, regardless of how old it is?
      retention_period_days    = string # (Optional) Specifies the number of days after which Backups should be deleted.
      start_time               = string # (Optional) Sets when the schedule should start working.
    })
  })
  description = "Backup for the App Service"
  default = {
    name                = "backup"
    enabled             = false
    storage_account_url = null
    schedule = {
      frequency_interval       = 1
      frequency_unit           = "Day"
      keep_at_least_one_backup = false
      retention_period_days    = 1
      start_time               = null
    }
  }
}
variable "connection_strings" {
  type = list(object({
    name = string
    type = string
    conn = string
  }))
  description = "A list of connectionstrings"
  default     = []

  validation {
    condition = alltrue([
      for item in var.connection_strings : can(regex("^SQLAzure$|^SQLServer$|^Custom$|^PIHub$|`^DocDb$|^EventHub$|^MySQL$|^NotificationHub$|^PostgreSQL$|^RedisCache$|^ServiceBus$", item.type))
    ])
    error_message = "The variable 'connection_strings' must have valid type: 'SQLAzure', 'SQLServer', 'Custom', .. ."
  }
}
variable "cors" {
  type = object({
    enabled             = bool
    allowed_origins     = list(string) # (Required) Specifies a list of origins that should be allowed to make cross-origin calls.
    support_credentials = bool         # (Optional) Whether CORS requests with credentials are allowed. Defaults to false
  })
  description = "Cross-Origin Resource Sharing (CORS) allows JavaScript code running in a browser on an external host to interact with your backend"
  default = {
    enabled             = false
    allowed_origins     = ["*"]
    support_credentials = true
  }
}
/*
variable "client_certificate_enabled" {
  type        = bool
  description = "(Optional) Should the function app use Client Certificates."
  default     = false
}
variable "client_certificate_mode" {
  type        = string
  description = "(Optional) The mode of the Function App's client certificates requirement for incoming requests. Possible values are Required, Optional, and OptionalInteractiveUser."
  default     = "Optional" # Similar to Allowed in the Web App resource if cert is enabled
  validation {
    condition     = can(regex("^Required$|^Optional$|OptionalInteractiveUser", var.client_certificate_mode))
    error_message = "The variable 'client_certificate_mode' must have value storage_account_type: Required, Optional, or OptionalInteractiveUser (Default)."
  }
}
*/
variable "client_certificate_mode" {
  type        = string
  description = "(Optional) Incoming client certificate mode. Possible values include Require, Allow (Default), Optional or Ignore."
  default     = "Allow"
  validation {
    condition     = can(regex("Require|Optional|Allow|Ignore", var.client_certificate_mode))
    error_message = "The variable 'client_certificate_mode' must be: Require, Allow (Default), Optional or Ignore."
  }
}
variable "managed_pipeline_mode" {
  type        = string
  description = "(Optional) Managed pipeline mode. Possible values include: Integrated, Classic."
  default     = "Integrated"
  validation {
    condition     = can(regex("Integrated|Classic", var.managed_pipeline_mode))
    error_message = "Variable 'load_balancing_mode' must be either Integrated (Default), or Classic."
  }
}
variable "minimum_tls_version" {
  type        = number
  description = "(Optional) Configures the minimum version of TLS required for SSL requests. Possible values include: 1.0, 1.1, and 1.2. Defaults to 1.2."
  default     = 1.2
  validation {
    condition     = can(regex("1\\.0|1\\.1|1\\.2", var.minimum_tls_version))
    error_message = "Variable 'minimum_tls_version' must be either 1.0, 1.1 or 1.2 (Default)."
  }
}
variable "ftps_state" {
  type        = string
  description = "(Optional) State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled. AppService log requires this to be activated."
  default     = "Disabled"
  validation {
    condition     = contains(["Disabled", "FtpsOnly", "AllAllowed"], var.ftps_state)
    error_message = "Variable 'ftps_state' must either be Disabled (Default), FtpsOnly or AllAllowed."
  }
}
variable "app_scale_limit" {
  type        = number
  description = "(Optional) The number of workers this function app can scale out to. Only applicable to apps on the Consumption and Premium plan."
  default     = null
}
variable "websockets_enabled" {
  type        = bool
  description = "(Optional) Should Web Sockets be enabled. Defaults to false."
  default     = false
}
variable "http2_enabled" {
  type        = bool
  description = "(Optional) Specifies if the http2 protocol should be enabled. Defaults to true."
  default     = true
}
variable "daily_memory_time_quota" {
  type        = number
  description = "(Optional) The amount of memory in gigabyte-seconds that your application is allowed to consume per day. Setting this value only affects function apps under the consumption plan. Defaults to 0."
  default     = null
}
variable "health_check_path" {
  type        = string
  description = "(Optional) Path which will be checked for this function app health. "
  default     = null
}

variable "https_only" {
  type        = bool
  description = "Can the App Service only be accessed via HTTPS?"
  default     = false
}

variable "warmed_count" {
  type        = number
  description = "(Optional) The number of pre-warmed instances for this Windows Function App. Only affects apps on an Elastic Premium plan."
  default     = 1
}

variable "worker_count" {
  type        = number
  description = "(Optional) The number of Workers for this Windows Function App."
  default     = 2
}

variable "app_service_logs" {
  type = object({
    disk_quota_mb         = number # (Required) The amount of disk space to use for logs. Valid values are between 25 and 100.
    retention_period_days = number # (Optional) The retention period for logs in days. Valid values are between 0 and 99999. Defaults to 0 (never delete).
  })
  description = "Application service logs settings"
  default = {
    disk_quota_mb         = 25
    retention_period_days = 60
  }
}

variable "dotnet_version" {
  type        = string
  description = "(Optional) The version of .NET to use. Possible values include v3.0, v4.0 v6.0 and v7.0. If 6 is set then dotnet6_workaround must be applied too."
  default     = "v3.0"
  validation {
    condition     = can(regex("v3.0|v4.0|v6.0|v7.0", var.dotnet_version))
    error_message = "Variable 'dotnet_version' must either be v3.0 (default), v4.0 v6.0 and v7.0."
  }
}

variable "dotnet6_workaround" {
  type = object({
    subscription_id = string
    client_id       = string
    client_secret   = string
    tenant_id       = string
  })
  default = {
    subscription_id = null # $env:ARM_SUBSCRIPTION_ID
    client_id       = null # $env:ARM_CLIENT_ID
    client_secret   = null # $env:ARM_CLIENT_SECRET
    tenant_id       = null # $env:TENANT_ID
  }
}

variable "extension_version" {
  type        = string
  description = "(Optional) The runtime version associated with the Function App. Defaults to ~4."
  default     = "~4"
}

variable "use_dotnet_isolated_runtime" {
  type        = bool
  description = "(Optional) Should the DotNet process use an isolated runtime. Defaults to false."
  default     = false
}

variable "java_version" {
  type        = number
  description = "(Optional) The version of Java to run. Possible values include 8, 11 and 17."
  default     = null
}

variable "node_version" {
  type        = string
  description = "(Optional) The version of Node to run. Possible values include 12, 14, 16 and 18."
  default     = null
}
variable "powershell_core_version" {
  type        = number
  description = "(Optional) The version of Powershell Core to run. Possible values are 7 and 7.2."
  default     = null
  #validation {
  #  condition     = contains(["7", "7.2"], var.powershell_core_version) || var.powershell_core_version == null
  #  error_message = "Variable 'powershell_core_version' must either be '7' (Default) or '7.2'."
  #}
}

variable "use_custom_runtime" {
  type        = bool
  description = "(Optional) Should the Windows Function App use a custom runtime? This must be null or else terraform plan will generate 'Error: Conflicting configuration arguments'."
  default     = null
}

variable "app_settings_default" {
  type        = bool
  description = "BUGFIX: Won't reset app_settings values. This sould be enabled only when creating resource for the first."
  default     = false
}

variable "app_settings" {
  type        = map(any)
  description = "Map of App Settings. This will be merged with default app settings. https://docs.microsoft.com/en-us/azure/azure-functions/functions-app-settings."
  default     = {}
}

variable "app_insights" {
  type = object({
    enabled             = bool
    instrumentation_key = string # (Optional) The Instrumentation Key for connecting the Windows Function App to Application Insights.
    connection_string   = string # (Optional) The Connection String for linking the Windows Function App to Application Insights.
  })
  description = "Aplication insights"
  default = {
    enabled             = false
    instrumentation_key = null
    connection_string   = null
  }
}
variable "builtin_logging_enabled" {
  type        = bool
  description = "(Optional) Should the built-in logging of this Function App be enabled? Defaults to true"
  default     = true
}
variable "ip_restrictions" {
  type = list(object({
    name                      = string
    action                    = string
    priority                  = number
    ip_address                = string # (Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
    virtual_network_subnet_id = string # (Optional) The Virtual Network Subnet ID used for this IP Restriction.
    service_tag               = string # (Optional) The Service Tag used for this IP Restriction
    headers = list(object({
      x_azure_fdid      = set(string)
      x_fd_health_probe = set(string)
      x_forwarded_for   = set(string)
      x_forwarded_host  = set(string)
    }))
  }))
  description = "The IP Address used for this IP Restriction. One of either ip_address, service_tag or virtual_network_subnet_id must be specified. IP_address should be CIDR or IP-address/32"
  default     = []
}

variable "scm_use_main" {
  type        = bool
  description = "(Optional) Should the Windows Function App ip_restriction configuration be used for the SCM also."
  default     = false
}

variable "scm_ip_restrictions" {
  type = list(object({
    name                      = optional(string) # (Optional) The name which should be used for this ip_restriction
    action                    = optional(string) # (Optional) The action to take. Possible values are Allow or Deny.
    priority                  = optional(number) # (Optional) The priority value of this ip_restriction.
    ip_address                = optional(string) # (Optional) The CIDR notation of the IP or IP Range to match. For example: 10.0.0.0/24 or 192.168.10.1/32
    virtual_network_subnet_id = optional(string) # (Optional) The Virtual Network Subnet ID used for this IP Restriction.
    service_tag               = optional(string) # (Optional) The Service Tag used for this IP Restriction
    headers = list(object({
      x_azure_fdid      = set(string)
      x_fd_health_probe = set(string)
      x_forwarded_for   = set(string)
      x_forwarded_host  = set(string)
    }))
  }))
  description = "The IP Address used for this SCM IP Restriction. SCN is used by Kudo, DevOps and Visual Studio. One of either ip_address, service_tag or virtual_network_subnet_id must be specified. IP_address should be CIDR or IP-address/32"
  default     = []
}
variable "vnet_route_all_enabled" {
  type        = bool
  description = "(Optional) Should all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied? Defaults to true."
  default     = true
}
variable "use_32_bit_worker" {
  type        = bool
  description = "(Optional) Should the Linux Web App use a 32-bit worker process. Defaults to true."
  default     = false
}
variable "vnet_subnet_id" {
  type        = string
  description = "(Optional) The subnet id which will be used by this Web App for regional virtual network integration https://docs.microsoft.com/en-us/azure/app-service/overview-vnet-integration#regional-virtual-network-integration."
  default     = null
}
variable "time_zone" {
  type        = string
  description = "The function app time zone. https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/default-time-zones?view=windows-11"
  default     = "W. Europe Standard Time"
}
variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
