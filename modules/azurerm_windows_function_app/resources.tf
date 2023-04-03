# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app
resource "azurerm_windows_function_app" "wfa" {
  depends_on = [
    data.azurerm_resource_group.rg,
    data.azurerm_service_plan.sp,
  data.azurerm_storage_account.sa]

  enabled                     = var.enabled
  name                        = var.name
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  service_plan_id             = data.azurerm_service_plan.sp.id
  https_only                  = var.https_only
  builtin_logging_enabled     = var.builtin_logging_enabled
  storage_account_name        = data.azurerm_storage_account.sa.name
  storage_account_access_key  = data.azurerm_storage_account.sa.primary_access_key
  client_certificate_enabled  = local.client_certificate_enabled
  client_certificate_mode     = local.client_certificate_mode
  daily_memory_time_quota     = var.daily_memory_time_quota
  functions_extension_version = var.extension_version
  virtual_network_subnet_id   = local.vnet_subnet_id
  tags                        = var.tags

  # TODO: key_vault_reference_identity_id - (Optional) The User Assigned Identity ID used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block. For more information see - Access vaults with a user-assigned identity

  # BUG! Overwrites existing configuration settings. This bug Needs to be resolved before using this.
  app_settings = var.app_settings_default ? local.app_settings : null

  dynamic "auth_settings" {
    for_each = length(var.auth_settings) > 0 ? var.auth_settings : []
    iterator = each
    content {
      enabled                        = each.value.enabled
      default_provider               = each.value.default_provider
      unauthenticated_client_action  = each.value.unauth_client_action
      token_store_enabled            = each.value.token_store_enabled
      allowed_external_redirect_urls = each.value.allowed_ext_redirect_urls
      runtime_version                = each.value.runtime_version
      active_directory {
        client_id         = each.value.active_directory.client_id     # (Required) The Client ID of this relying party application. Enables OpenIDConnection authentication with Azure Active Directory.
        client_secret     = each.value.active_directory.client_secret # (Optional) The Client Secret of this relying party application. If no secret is provided, implicit flow will be used.
        allowed_audiences = each.value.active_directory.audiences
      }
      microsoft {
        client_id     = each.value.microsoft.client_id
        client_secret = each.value.microsoft.client_secret
        # oauth_scopes - (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, wl.basic is used as the default scope.
      }
    }
  }

  dynamic "connection_string" {
    for_each = length(var.connection_strings) > 0 ? var.connection_strings : []
    iterator = each
    content {
      name  = each.value.name
      type  = each.value.type
      value = each.value.conn
    }
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = local.identity_ids
    }
  }

  dynamic "backup" {
    for_each = var.backup.enabled ? [var.backup] : []
    iterator = each
    content {
      name                = each.value.name
      enabled             = each.value.enabled
      storage_account_url = each.value.storage_account_url

      schedule {
        frequency_interval       = each.value.schedule.frequency_interval
        frequency_unit           = each.value.schedule.frequency_unit
        keep_at_least_one_backup = each.value.schedule.keep_at_least_one_backup
        retention_period_days    = each.value.schedule.retention_period_days
        start_time               = each.value.schedule.start_time
      }
    }
  }

  site_config {
    always_on = var.always_on
    # TODO: api_definition_url - (Optional) The URL of the API definition that describes this Linux Function App.
    # TODO: api_management_api_id - (Optional) The ID of the API Management API for this Linux Function App.
    # TODO: app_command_line - (Optional) App command line to launch, e.g. /sbin/myserver -b 0.0.0.0.

    app_scale_limit                        = var.app_scale_limit
    application_insights_connection_string = var.app_insights.enabled ? var.app_insights.connection_string : null
    application_insights_key               = var.app_insights.enabled ? var.app_insights.instrumentation_key : null

    #Cross-Origin Resource Sharing (CORS) allows JavaScript code running in a browser on an external host to interact with your backend. Specify the origins that should be allowed to make cross-origin calls (for example: http://example.com:12345). To allow all, use "*" and remove all other origins from the list. 
    #Slashes are not allowed as part of domain or after TLD. Learn more
    dynamic "cors" {
      for_each = var.cors.enabled ? [var.cors] : []
      iterator = each
      content {
        allowed_origins     = each.value.allowed_origins
        support_credentials = each.value.support_credentials
      }
    }

    health_check_path           = var.health_check_path
    websockets_enabled          = var.websockets_enabled
    http2_enabled               = var.http2_enabled
    use_32_bit_worker           = var.use_32_bit_worker
    vnet_route_all_enabled      = var.vnet_route_all_enabled
    ftps_state                  = var.ftps_state
    ip_restriction              = local.ip_restrictions
    scm_ip_restriction          = local.scm_ip_restrictions
    scm_use_main_ip_restriction = var.scm_use_main
    worker_count                = var.worker_count
    managed_pipeline_mode       = var.managed_pipeline_mode
    minimum_tls_version         = var.minimum_tls_version
    pre_warmed_instance_count   = var.warmed_count

    # TODO: remote_debugging_enabled - (Optional) Should Remote Debugging be enabled. Defaults to false.
    # TODO: remote_debugging_version - (Optional) The Remote Debugging Version. Possible values include VS2017 and VS2019.
    # TODO: runtime_scale_monitoring_enabled - (Optional) Should Scale Monitoring of the Functions Runtime be enabled?
    # TODO: scm*

    dynamic "app_service_logs" {
      for_each = local.is_consumption_plan ? [] : [var.app_service_logs]
      iterator = each

      content {
        disk_quota_mb         = each.value.disk_quota_mb
        retention_period_days = each.value.retention_period_days
      }
    }

    application_stack {
      dotnet_version              = var.dotnet_version
      java_version                = var.java_version
      node_version                = var.node_version
      powershell_core_version     = var.powershell_core_version
      use_dotnet_isolated_runtime = var.use_dotnet_isolated_runtime
      use_custom_runtime          = var.use_custom_runtime
    }
  }

  lifecycle {
    ignore_changes = [tags, location, storage_account_access_key, app_settings] # ,  Bug! needs to fixed
  }
}


# https://github.com/hashicorp/terraform-provider-azurerm/issues/16417
# https://github.com/hashicorp/terraform-provider-azurerm/issues/16927
resource "null_resource" "netfx" {
  depends_on = [azurerm_windows_function_app.wfa]
  count      = var.dotnet_version == 6 ? 1 : 0

  provisioner "local-exec" {
    interpreter = ["pwsh", "-Command"]
    command     = <<EOT
      $subscriptionId = '${var.dotnet6_workaround.subscription_id}'
      $tenantId = '${var.dotnet6_workaround.tenant_id}'
      $clientId = '${var.dotnet6_workaround.client_id}'
      $secret = '${var.dotnet6_workaround.client_secret}'
      az login --service-principal --username $clientId --password $secret --tenant $tenantId --output none;
      az account set --subscription $subscriptionId;
      az functionapp config set --net-framework-version v6.0 -g '${var.rg_name}' -n '${var.name}' --output none;
    EOT
  }
}