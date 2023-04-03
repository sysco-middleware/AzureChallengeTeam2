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
| [azurerm_vpn_gateway.vpn](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/vpn_gateway) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_route_translation_for_nat_enabled"></a> [bgp\_route\_translation\_for\_nat\_enabled](#input\_bgp\_route\_translation\_for\_nat\_enabled) | (Optional) Is BGP route translation for NAT on this VPN Gateway enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_bgp_settings"></a> [bgp\_settings](#input\_bgp\_settings) | n/a | <pre>object({<br>    asn                   = string       # (Required) The ASN of the BGP Speaker. Changing this forces a new resource to be created.<br>    peer_weight           = number       # (Required) The weight added to Routes learned from this BGP Speaker. Changing this forces a new resource to be created.<br>    instance_0_custom_ips = list(string) # (Required) A list of custom BGP peering addresses to assign to instance 0.<br>    instance_1_custom_ips = list(string) # (Required) A list of custom BGP peering addresses to assign to instance 1.<br>  })</pre> | <pre>{<br>  "asn": null,<br>  "instance_0_custom_ips": [],<br>  "instance_1_custom_ips": [],<br>  "peer_weight": 100<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. Changing this forces a new resource to be created. Uses resource group location by default | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `any` | n/a | yes |
| <a name="input_routing"></a> [routing](#input\_routing) | (Optional) Azure routing preference lets you to choose how your traffic routes between Azure and the internet. You can choose to route traffic either via the Microsoft network (default value, Microsoft Network), or via the ISP network (public internet, set to Internet). More context of the configuration can be found in the Microsoft Docs to create a VPN Gateway. Changing this forces a new resource to be created. | `string` | `"Microsoft Network"` | no |
| <a name="input_scale_unit"></a> [scale\_unit](#input\_scale\_unit) | (Optional) The Scale Unit for this VPN Gateway. Defaults to 1 | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_virtual_hub_id"></a> [virtual\_hub\_id](#input\_virtual\_hub\_id) | (Required) The ID of the Virtual Hub within which this VPN Gateway should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the VPN Gateway. |
