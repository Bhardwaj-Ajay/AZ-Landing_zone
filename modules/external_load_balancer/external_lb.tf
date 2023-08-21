# Creating Punlic IP for External Load Balancer Frontend
resource "azurerm_public_ip" "ext_lb_pip" {
  name                = "${var.env}-${var.app}-${var.ext_lb_env}-ext-lb-pip1"
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_version          = "IPv4"
  sku                 = "Standard"
  allocation_method   = "Static"
  sku_tier            = "Regional"
  zones               = ["1"]
}

# Creating External Load Balancer

resource "azurerm_lb" "ext_lb" {
  name                = "${var.env}-${var.app}-${var.ext_lb_env}-ext-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.ext_lb_sku
  frontend_ip_configuration {
    name                 = "${var.env}-${var.app}-${var.ext_lb_env}_frontend"
    public_ip_address_id = azurerm_public_ip.ext_lb_pip.id
  }
}

# Creating External LB probe

resource "azurerm_lb_probe" "ext_lb_probe" {
  name                = "${var.env}-${var.app}-${var.ext_lb_env}-probe"
  loadbalancer_id     = azurerm_lb.ext_lb.id
  protocol            = var.ext_lb_probe_protocol
  port                = var.ext_lb_probe_port
  interval_in_seconds = var.ext_lb_probe_interval
}


# Create backend address pools with their IP addresses

resource "azurerm_lb_backend_address_pool" "ext_lb_backend_pool" {
  name            = "${var.env}-${var.app}-${var.ext_lb_env}-backend-pool"
  loadbalancer_id = azurerm_lb.ext_lb.id
}


resource "azurerm_lb_backend_address_pool_address" "ext_lb_node" {
  count                   = length(var.ext_lb_backend_servers)
  name                    = "${var.env}-${var.app}-${var.ext_lb_env}-node${count.index + 1}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ext_lb_backend_pool.id
  ip_address              = var.ext_lb_backend_servers[count.index]
  virtual_network_id      = azurerm_virtual_network.vnets.id
}
# Creating External LB Rule

resource "azurerm_lb_rule" "ext_lb_rule" {
  name                           = "${var.env}-${var.app}-${var.ext_lb_env}-rule"
  loadbalancer_id                = azurerm_lb.ext_lb.id
  protocol                       = var.ext_lb_protocol
  frontend_port                  = var.ext_lb_frontend_port
  backend_port                   = var.ext_lb_backend_port
  frontend_ip_configuration_name = azurerm_lb.ext_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.ext_lb_backend_pool.id]
  probe_id                       = azurerm_lb_probe.ext_lb_probe.id
}