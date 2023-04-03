locals {
  appsettings_default = {
    WEBSITE_RUN_FROM_PACKAGE        = 1
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = true
    WEBSITE_TIME_ZONE               = var.time_zone
  }
  app_settings = merge(local.appsettings_default, var.app_settings)

  identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? toset(var.managed_identity_ids) : null

  is_consumption_plan = can(regex("Y1", data.azurerm_service_plan.sp.sku_name)) || can(regex("FunctionApp", data.azurerm_service_plan.sp.kind))
  vnet_subnet_id      = local.is_consumption_plan ? null : var.vnet_subnet_id

  client_certificate = {
    # All requests must be authenticated through a client certificate.
    "Require" = {
      enabled = true
      mode    = "Required"
    }
    # Clients will be prompted for a certificate, if no certificate is provided fallback to SSO or other means of authentication. Unauthenticated requests will be blocked.
    "Allow" = {
      enabled = true
      mode    = "Optional"
    }
    # Clients will not be prompted for a certificate by default. Unless the request can be authenticated through other means (like SSO), it will be blocked.
    "Optional" = {
      enabled = false
      mode    = "OptionalInteractiveUser"
    }
    # No client authentication is required. Unauthenticated requests will not be blocked.
    "Ignore" = {
      enabled = false
      mode    = "Optional"
    }
  }
  client_certificate_enabled = local.client_certificate[var.client_certificate_mode].enabled
  client_certificate_mode    = local.client_certificate[var.client_certificate_mode].mode
  ip_restrictions            = length(var.ip_restrictions) == 0 ? local.ip_allow_all : var.ip_restrictions
  scm_ip_restrictions        = length(var.scm_ip_restrictions) == 0 ? null : var.scm_ip_restrictions

  ip_allow_all = [
    {
      ip_address                = "0.0.0.0/24"
      action                    = "Allow"
      priority                  = 2147483647
      name                      = "Allow all"
      description               = "Allow all access"
      virtual_network_subnet_id = null
      service_tag               = null
      headers                   = []
    }
  ]
  ip_deny_all = [
    {
      ip_address  = "0.0.0.0/24"
      action      = "Deny"
      priority    = 2147483647
      name        = "Deny all"
      description = "Deny all access"
    }
  ]
}
