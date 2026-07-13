variable "firewall_network_rule_collections" {
  description = <<EOT
Map of firewall_network_rule_collections, attributes below
Required:
    - action
    - azure_firewall_name
    - name
    - priority
    - resource_group_name
    - rule (block):
        - description (optional)
        - destination_addresses (optional)
        - destination_fqdns (optional)
        - destination_ip_groups (optional)
        - destination_ports (required)
        - name (required)
        - protocols (required)
        - source_addresses (optional)
        - source_ip_groups (optional)
EOT

  type = map(object({
    action              = string
    azure_firewall_name = string
    name                = string
    priority            = number
    resource_group_name = string
    rule = list(object({
      description           = optional(string)
      destination_addresses = optional(list(string))
      destination_fqdns     = optional(list(string))
      destination_ip_groups = optional(list(string))
      destination_ports     = list(string)
      name                  = string
      protocols             = list(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.firewall_network_rule_collections : (
        length(v.rule) >= 1
      )
    ])
    error_message = "Each rule list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_network_rule_collections : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_network_rule_collections : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_network_rule_collections : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_network_rule_collections : (
        v.priority >= 100 && v.priority <= 65000
      )
    ])
    error_message = "must be between 100 and 65000"
  }
  validation {
    condition = alltrue([
      for k, v in var.firewall_network_rule_collections : (
        alltrue([for item in v.rule : (length(item.name) > 0)])
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 5 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

