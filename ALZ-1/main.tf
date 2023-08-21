# Calling resource_group module to create the resource groups.
module "resource_group" {
  source   = "../modules/resource_group"
  env      = var.env
  app      = var.app
  location = var.location
  rg_name  = var.rg_name
  
}


# Calling network module to create the VNETs/Subnets and NSGs.
module "network" {
  source              = "../modules/network"
  env                 = var.env[0]
  app                 = var.app
  location            = var.location
  resource_group_name = module.resource_group.output_resource_group[0].name
  address_space       = var.address_space
  subnets             = var.subnets
}
