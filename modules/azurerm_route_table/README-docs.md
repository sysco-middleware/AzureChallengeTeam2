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
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.srta](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disable_propagation"></a> [disable\_propagation](#input\_disable\_propagation) | (Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | n/a | `any` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | n/a | <pre>list(object({<br>    name                   = string # (Required) The name of the Backend Address Pool.<br>    address_prefix         = string # (Optional) A list of IP Addresses in CIDR which should be part of the Backend Address Pool.<br>    next_hop_type          = string # (Required) The type of Azure hop the packet should be sent to. Possible values are VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None<br>    next_hop_in_ip_address = string # (Optional) Contains the IP address packets should be forwarded to. Next hop values are only allowed in routes where the next hop type is VirtualAppliance.<br>  }))</pre> | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Required/Optional) A list of Subnet IDs the Route Table which should be associated with. Changing this forces a new resource to be created. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Route Table ID. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The collection of Subnets associated with this route table. |
