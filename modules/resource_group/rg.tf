 # This code will create the resource group.

locals {
    resource_group_names = flatten([
      for env in var.env :
    [
      for rg in var.rg_name :
        "rg-${env}-${var.app}-${rg}"
    ]
    ])
}

resource "azurerm_resource_group" "rg" {
    for_each = { for idx, name in local.resource_group_names : idx => {
      name     = name
      location = var.location
    } }

    name     = each.value.name
    location = var.location
}