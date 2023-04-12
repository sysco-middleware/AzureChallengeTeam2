variable "name" {}
variable "rg_name" {}
variable "location" {
  type        = string
  description = "The the location for the storage account. If omittted then the resource group will be used"
  default     = null
}
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

variable "containers" {
  type = list(object({
    category    = string
    name        = string
    access_type = string
  }))
  description = "Manages a Container within Azure Storage."
  default     = []
}
variable "shares" {
  type = list(object({
    name        = string
    quota       = number
    permissions = string
  }))
  description = "Manages a File Share within Azure Storage. The permissions which should be associated with this Shared Identifier has a combination of r (read), w (write), d (delete), and l (list)"
  default     = []
}
variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created."
  default     = "StorageV2"
  validation {
    condition     = can(regex("BlobStorage|BlockBlobStorage|FileStorage|Storage$|StorageV2", var.account_kind))
    error_message = "Variable 'account_kind' must be either BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2 (Default)."
  }
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa"
  default     = "LRS"
  validation {
    condition     = can(regex("LRS|GRS|RAGRS|ZRS|GZRS|RAGZRS", var.account_replication_type))
    error_message = "Variable 'account_replication_type' must be either LRS (Default), GRS, RAGRS, ZRS, GZRS or RAGZRS."
  }
}

variable "access_tier" {
  type        = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool."
  default     = "Hot"
  validation {
    condition     = can(regex("Hot|Cool", var.access_tier))
    error_message = "Variable 'access_tier' must be either Hot (Default) or Cool."
  }
}

variable "edge_zone" {
  type        = string
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  default     = null
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2."
  default     = "TLS1_2"
}
variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "(Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false"
  default     = false
}

variable "retention_in_days" {
  type        = number
  description = "Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 35. Must be higher than softdelete"
  default     = 35
}
variable "enable_rbac_authorization" {
  type        = bool
  description = "Activates RBAC on the resource"
  default     = false
}
variable "rbac_roles" {
  type = list(object({
    role_definition_name = string
    principal_id         = string
  }))
  description = "Role definition name to give access to, ex: Storage Blob Data Contributor. Note: var.enable_rbac_authorization must be true"
  default     = []
}

variable "cors_rules" {
  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  description = "Blob, share, queue and table CORS rule properties"
  default     = []
}

variable "allow_public" {
  type        = bool
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true."
  default     = true
}

variable "network_rules" {
  type = object({
    default_action             = string       # (Required) Specifies the default action of allow or deny when no other rules match. When Deny, one of either ip_rules or virtual_network_subnet_ids must be specified.
    bypass                     = list(string) # (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None.
    ip_rules                   = list(string) # (Optional) List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed. /31 and /32 is not allowed
    virtual_network_subnet_ids = list(string) # (Optional) A list of resource ids for subnets.
    private_link_access = list(object({       #  (Optional) One or More private_link_access block as defined below.
      endpoint_resource_id = string           # (Required) The resource id of the resource access rule to be granted access.
      endpoint_tenant_id   = string           # (Optional) The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.
    }))
  })
  description = "(Required) Network rules for the storage account."
  default = {
    default_action             = "Allow"
    bypass                     = ["Logging", "AzureServices", "Metrics"]
    ip_rules                   = []
    virtual_network_subnet_ids = []
    private_link_access        = []
  }
  validation {
    condition     = can(regex("^Allow$|^Deny$", var.network_rules.default_action)) && length(var.network_rules) < 31
    error_message = "The variable 'network_rules' must have valid default_action: 'Allow', 'Deny' ."
  }
}

variable "custom_domain" {
  type = object({
    name   = string # (Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
    verify = bool   # (Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
  })
  description = ""
  default = {
    name   = null
    verify = false
  }
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
