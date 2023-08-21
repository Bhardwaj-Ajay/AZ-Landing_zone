output "ngw_pip_id_output" {
    value = azurerm_public_ip.ngw_pip.id
}

output "ngw_pip_name_output" {
    value = azurerm_public_ip.ngw_pip.name
}

output "ngw_id_output" {
    value = azurerm_nat_gateway.ngw.id
}

output "ngw_name_output" {
    value = azurerm_nat_gateway.ngw.name
}


