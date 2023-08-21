# Creating Internal Load Balancer

resource "azurerm_lb" "int_lb" {
  name                = "${var.env}-${var.app}-${var.int_lb_env}-int-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.int_lb_sku
  frontend_ip_configuration {
    name                          = "${var.env}-${var.app}-${var.int_lb_env}_frontend"
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    private_ip_address            = var.int_lb_frontend_ip
    subnet_id                     = azurerm_subnet.subnets[var.int_lb_subnet].id
  }
}

# Creating Internal LB probe

resource "azurerm_lb_probe" "int_lb_probe" {
  name                = "${var.env}-${var.app}-${var.int_lb_env}-probe"
  loadbalancer_id     = azurerm_lb.int_lb.id
  protocol            = var.int_lb_probe_protocol
  port                = var.int_lb_probe_port
  interval_in_seconds = var.int_lb_probe_interval
}


# Create backend address pools with their IP addresses

resource "azurerm_lb_backend_address_pool" "int_lb_backend_pool" {
  name            = "${var.env}-${var.app}-${var.int_lb_env}-backend-pool"
  loadbalancer_id = azurerm_lb.int_lb.id
}


resource "azurerm_lb_backend_address_pool_address" "int_lb_node" {
  count                   = length(var.int_lb_backend_servers)
  name                    = "${var.env}-${var.app}-${var.int_lb_env}-node${count.index + 1}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.int_lb_backend_pool.id
  ip_address              = var.int_lb_backend_servers[count.index]
  virtual_network_id      = azurerm_virtual_network.vnets.id
}
# Creating External LB Rule

resource "azurerm_lb_rule" "int_lb_rule" {
  name                           = "${var.env}-${var.app}-${var.int_lb_env}-rule"
  loadbalancer_id                = azurerm_lb.int_lb.id
  protocol                       = var.int_lb_protocol
  frontend_port                  = var.int_lb_frontend_port
  backend_port                   = var.int_lb_backend_port
  frontend_ip_configuration_name = azurerm_lb.int_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.int_lb_backend_pool.id]
  probe_id                       = azurerm_lb_probe.int_lb_probe.id
}