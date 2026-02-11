resource "azurerm_firewall_network_rule_collection" "firewall_network_rule_collections" {
  for_each = var.firewall_network_rule_collections

  action              = each.value.action
  azure_firewall_name = each.value.azure_firewall_name
  name                = each.value.name
  priority            = each.value.priority
  resource_group_name = each.value.resource_group_name

  dynamic "rule" {
    for_each = each.value.rule
    content {
      description           = rule.value.description
      destination_addresses = rule.value.destination_addresses
      destination_fqdns     = rule.value.destination_fqdns
      destination_ip_groups = rule.value.destination_ip_groups
      destination_ports     = rule.value.destination_ports
      name                  = rule.value.name
      protocols             = rule.value.protocols
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
    }
  }
}

