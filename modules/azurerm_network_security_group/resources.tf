# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "nsg" {
  depends_on = [data.azurerm_resource_group.rg]

  name                = var.name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  tags                = var.tags

  lifecycle {
    ignore_changes = [tags["update_date"], name]
  }
}

resource "azurerm_network_security_rule" "nsg_rule_inbound" {
  depends_on = [azurerm_network_security_group.nsg]
  for_each   = { for item in var.nsg_rules_inbound : item.name => item } # This instead of count, prevents update conflicts in the list

  name                                       = each.value.name
  priority                                   = try(each.value.priority, 100)
  direction                                  = "Inbound"
  access                                     = try(each.value.access, "Allow")                      # Allow | Deny
  protocol                                   = try(each.value.protocol, "*")                        # Tcp | Udp | *
  source_port_range                          = try(each.value.source_port_range, "*")               # 1-65NNN | *
  source_port_ranges                         = try(toset(each.value.source_port_ranges), null)      # 1-65NNN | *
  destination_port_range                     = try(each.value.destination_port_range, "*")          # IP | CIDR | *
  destination_port_ranges                    = try(toset(each.value.destination_port_ranges), null) # [CIDR]
  source_address_prefix                      = try(each.value.source_address_prefix, "*")           # IP | CIDR | *
  source_address_prefixes                    = try(toset(each.value.source_address_prefixes), null) # [CIDR]
  source_application_security_group_ids      = try(each.value.source_asg_ids, [])
  destination_address_prefix                 = try(each.value.destination_address_prefix, "*")           # IP | CIDR | *
  destination_address_prefixes               = try(toset(each.value.destination_address_prefixes), null) # [CIDR]
  destination_application_security_group_ids = try(each.value.destination_asg_ids, [])
  resource_group_name                        = data.azurerm_resource_group.rg.name
  network_security_group_name                = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "nsg_rule_outbound" {
  depends_on = [azurerm_network_security_group.nsg]
  for_each   = { for item in var.nsg_rules_outbound : item.name => item } # This instead of count, prevents update conflicts in the list 

  name                                       = each.value.name
  priority                                   = try(each.value.priority, 100)
  direction                                  = "Outbound"
  access                                     = try(each.value.access, "Allow")                    # Allow | Deny
  protocol                                   = try(each.value.protocol, "*")                      # Tcp | Udp | *
  source_port_range                          = try(each.value.source_port_range, "*")             # 1-65NNN | *
  source_port_ranges                         = try(toset(each.value.source_port_ranges), [])      # 1-65NNN | *s
  destination_port_range                     = try(each.value.destination_port_range, "*")        # IP | CIDR | *
  destination_port_ranges                    = try(toset(each.value.destination_port_ranges), []) # [CIDR]
  source_address_prefix                      = try(each.value.source_address_prefix, "*")         # IP | CIDR | *
  source_address_prefixes                    = try(toset(each.value.source_address_prefixes), []) # [CIDR]
  source_application_security_group_ids      = try(each.value.source_asg_ids, [])
  destination_address_prefix                 = try(each.value.destination_address_prefix, "*")         # IP | CIDR | *
  destination_address_prefixes               = try(toset(each.value.destination_address_prefixes), []) # [CIDR]
  destination_application_security_group_ids = try(each.value.destination_asg_ids, [])
  resource_group_name                        = data.azurerm_resource_group.rg.name
  network_security_group_name                = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "nsga" {
  depends_on = [azurerm_network_security_group.nsg]

  subnet_id                 = data.azurerm_subnet.snet.id
  network_security_group_id = azurerm_network_security_group.nsg.id

  lifecycle {
    ignore_changes = [subnet_id, network_security_group_id]
  }
}
