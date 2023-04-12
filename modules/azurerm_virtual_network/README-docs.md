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
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | (Required) A list of address spaces that is used the virtual network. At least one is required. | `list(string)` | n/a | yes |
| <a name="input_ddospp_enabled"></a> [ddospp\_enabled](#input\_ddospp\_enabled) | Azure DDoS Protection plan is very expensive. https://azure.microsoft.com/en-us/pricing/calculator/. Only one resource supported per Subscription | `bool` | `false` | no |
| <a name="input_ddospp_id"></a> [ddospp\_id](#input\_ddospp\_id) | DDOS protection plan id. By default not configured | `string` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Since dns\_servers can be configured both inline and via the separate azurerm\_virtual\_network\_dns\_servers resource, we have to explicitly set it to empty slice ([]) to remove it. | `list(string)` | `[]` | no |
| <a name="input_flow_timeout_in_minutes"></a> [flow\_timeout\_in\_minutes](#input\_flow\_timeout\_in\_minutes) | (Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes. | `string` | `4` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. Changing this forces a new resource to be created. Uses resource group location by default | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `any` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional) Can be specified multiple times to define multiple subnets. Each subnet block supports fields documented below. Since subnet can be configured both inline and via the separate azurerm\_subnet resource, we have to explicitly set it to empty slice ([]) to remove it. | <pre>list(object({<br>    name              = string # (Required) The name of the subnet.<br>    address_prefix    = string # (Required) The address prefix to use for the subnet.<br>    security_group_id = string # (Optional) The Network Security Group to associate with the subnet. (Referenced by id, ie. azurerm_network_security_group.example.id)<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_use_azure_dns"></a> [use\_azure\_dns](#input\_use\_azure\_dns) | Wheather or not use Azure DNS server. If true the variable dns\_servers wil be null. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_space"></a> [address\_space](#output\_address\_space) | The list of address spaces used by the virtual network |
| <a name="output_guid"></a> [guid](#output\_guid) | The GUID of the virtual network. |
| <a name="output_id"></a> [id](#output\_id) | The virtual NetworkConfiguration ID. |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Zero or more subnet ids. |
