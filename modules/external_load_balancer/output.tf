output "ext-lb-pip_id_output" {
  value = azurerm_public_ip.ext_lb_pip.id
}

output "ext_lb_pip_name_output" {
  value = azurerm_public_ip.ext_lb_pip.name
}

output "ext_lb_name_output" {
  value = azurerm_lb.ext_lb.name
}

output "ext_lb_id_output" {
  value = azurerm_lb.ext_lb.id
}

output "ex_lb_frontend_name_output" {
  value = azurerm_lb.ext_lb.frontend_ip_configuration[0].name
}

output "ext_lb_frontend_id_output" {
  value = azurerm_lb.ext_lb.frontend_ip_configuration[0].id
}