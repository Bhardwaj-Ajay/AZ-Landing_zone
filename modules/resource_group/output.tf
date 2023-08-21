# This is the output of the resource group module.
output "output_resource_group" {
    value = { for idx, rg in azurerm_resource_group.rg : idx => {
    name = rg.name
    id   = rg.id
    } }
}