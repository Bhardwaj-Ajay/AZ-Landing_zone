output "output_vnet_names" {
    value = azurerm_virtual_network.vnets[*].name
}

output "output_subnet_names" {
    value = [for subnet_name, _ in azurerm_subnet.subnets : subnet_name]
}

output "output_subnet_ids" {
    value = [for _, subnet in azurerm_subnet.subnets : subnet.id]
}

output "output_nsg_names" {
    value = [for nsg_name, _ in azurerm_network_security_group.nsg : nsg_name]
}

output "output_nsg_ids" {
    value = [for _, nsg in azurerm_network_security_group.nsg  : nsg.id]
}

output "subnet_address_map" {
  value = local.subnet_address_map
}

# Output the subnet IDs
#output "subnet_ids" {
 # value = { for key, subnet in azurerm_subnet.subnets : key => subnet.id }
#}