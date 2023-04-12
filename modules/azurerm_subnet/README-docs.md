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
| [azurerm_subnet.snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delegation_actions"></a> [delegation\_actions](#input\_delegation\_actions) | value | `list(string)` | <pre>[<br>  "Microsoft.Network/networkinterfaces/*",<br>  "Microsoft.Network/virtualNetworks/subnets/action",<br>  "Microsoft.Network/virtualNetworks/subnets/join/action",<br>  "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",<br>  "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"<br>]</pre> | no |
| <a name="input_enforce_private_link_endpoint_network_policies"></a> [enforce\_private\_link\_endpoint\_network\_policies](#input\_enforce\_private\_link\_endpoint\_network\_policies) | (Optional) Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false. | `bool` | `false` | no |
| <a name="input_enforce_private_link_service_network_policies"></a> [enforce\_private\_link\_service\_network\_policies](#input\_enforce\_private\_link\_service\_network\_policies) | (Optional) Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false. | `bool` | `false` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `any` | n/a | yes |
| <a name="input_service_endpoint_policy_ids"></a> [service\_endpoint\_policy\_ids](#input\_service\_endpoint\_policy\_ids) | (Optional) The list of IDs of Service Endpoint Policies to associate with the subnet. Requires minimum 1 policy if defined. | `list(string)` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet names, cidr prefixes, service endpoints and subnet deligation | <pre>list(object({<br>    name       = string<br>    cidr       = list(string)<br>    tags       = list(string)<br>    endpoints  = list(string) # Endpoints are services that can connect to the Subnet<br>    delegation = list(string) # The service that can be installed in the Subnet<br>  }))</pre> | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_prefixes"></a> [address\_prefixes](#output\_address\_prefixes) | n/a |
| <a name="output_ids"></a> [ids](#output\_ids) | n/a |
| <a name="output_network_security_group_ids"></a> [network\_security\_group\_ids](#output\_network\_security\_group\_ids) | n/a |
