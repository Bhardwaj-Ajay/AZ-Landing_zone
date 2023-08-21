# Calling resource_group module to create the resource groups.
module "resource_group" {
    source   = "../modules/resource_group"
    env      = var.env
    app      = var.app
    location = var.location
    rg_name  = var.rg_name
  
}


# Calling network module to create the production (pro) VNETs/Subnets and NSGs.
module "network" {
    source              = "../modules/network"
    env                 = var.env[0]
    app                 = var.app
    location            = var.location
    resource_group_name = module.resource_group.output_resource_group[0].name
    address_space       = var.address_space
    subnets             = var.subnets
}


# Calling NAT Gateway Module to create the NAT Gateway in along with Public IP.
module "nat_gateway" {
    source              = "../modules/nat_gateway"
    env                 = var.env[0]
    app                 = var.app
    location            = var.location
    resource_group_name = module.resource_group.output_resource_group[0].name
    ngw_sku             = var.ngw_sku
    ngw_subnet          = var.ngw_subnet
    subnet_id           = var.subnet_id
}