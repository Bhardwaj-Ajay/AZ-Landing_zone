# Calling resource_group module to create the resource groups.
module "resource_group" {
  source   = "../modules/resource_group"
  env      = var.env
  app      = var.app
  location = var.location
  rg_name  = var.rg_name
  
}


# Calling network module to create the production (pro) VNETs/Subnets and NSGs.
module "pro_network" {
  source              = "../modules/network"
  env                 = var.env[0]
  app                 = var.app
  location            = var.location
  resource_group_name = module.resource_group.output_resource_group[0].name
  address_space       = var.pro_address_space
  subnets             = var.pro_subnets
}

# Calling network module to create the development (dev) VNETs/Subnets and NSGs.
module "dev_network" {
  source              = "../modules/network"
  env                 = var.env[1]
  app                 = var.app
  location            = var.location
  resource_group_name = module.resource_group.output_resource_group[4].name
  address_space       = var.dev_address_space
  subnets             = var.dev_subnets
}
