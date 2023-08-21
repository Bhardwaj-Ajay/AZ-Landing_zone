
# This code will create one public IP for NAT Gateway
resource "azurerm_public_ip" "ngw_pip" {
    name                = "${var.env}-${var.app}-ngw1-pip1"
    resource_group_name = var.resource_group_name
    location            = var.location
    ip_version          = "IPv4"
    sku                 = "Standard"
    allocation_method   = "Static"
    sku_tier            = "Regional"
    zones               = ["1"]
}



# Crearte NAT Gateway
resource "azurerm_nat_gateway" "ngw" {
    name                    = "${var.env}-${var.app}-vnet-ngw1"
    resource_group_name     = var.resource_group_name
    location                = var.location
    sku_name                = var.ngw_sku
    idle_timeout_in_minutes = 10
    zones                   = ["1"]
}

# Associate Public IP with NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "ngw_ips" {
    nat_gateway_id       = azurerm_nat_gateway.ngw.id
    public_ip_address_id = azurerm_public_ip.ngw_pip.id

}

# Associate Subnets with NAT Gateway
resource "azurerm_subnet_nat_gateway_association" "sn_nat_gw_association" {
    for_each           = toset(ngw_subnet_values)
    subnet_id          = module.network.subnet_address_map[each.key].id
    nat_gateway_id     = azurerm_nat_gateway.ngw.id
}

locals {
  ngw_subnet_values = values(var.ngw_subnet)
}