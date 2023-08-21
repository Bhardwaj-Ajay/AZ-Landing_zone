# This Code will create VNETs
resource "azurerm_virtual_network" "vnets" {
    name                = "vnet-${var.env}-${var.app}"
    address_space       = var.address_space
    location            = var.location
    resource_group_name = var.resource_group_name
}

# This code will create subnets

resource "azurerm_subnet" "subnets" {
    for_each = var.subnets

    name                 = "snet-${var.env}-${var.app}-${each.key}"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnets.name
    address_prefixes     = [each.value.address_prefix]
}


# This code will create Network Security groups
resource "azurerm_network_security_group" "nsg" {
    for_each            = var.subnets
    name                = "nsg-${var.env}-${var.app}-${each.key}"
    location            = var.location
    resource_group_name = var.resource_group_name
}

# This code will associate the NSG to the their respective subnets
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
    for_each                  = azurerm_subnet.subnets
    subnet_id                 = azurerm_subnet.subnets[each.key].id
    network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

locals {
  subnet_address_map = { for subnet in azurerm_subnet.subnets : subnet.name => subnet }
}