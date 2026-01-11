resource "azurerm_firewall_network_rule_collection" "firewall_network_rule_collections" {
  for_each = var.firewall_network_rule_collections

  action              = each.value.action
  azure_firewall_name = each.value.azure_firewall_name
  name                = each.value.name
  priority            = each.value.priority
  resource_group_name = each.value.resource_group_name

  rule {
    description           = each.value.rule.description
    destination_addresses = each.value.rule.destination_addresses
    destination_fqdns     = each.value.rule.destination_fqdns
    destination_ip_groups = each.value.rule.destination_ip_groups
    destination_ports     = each.value.rule.destination_ports
    name                  = each.value.rule.name
    protocols             = each.value.rule.protocols
    source_addresses      = each.value.rule.source_addresses
    source_ip_groups      = each.value.rule.source_ip_groups
  }
}

