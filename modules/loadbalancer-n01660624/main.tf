resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip-${var.resource_group_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation_method
  sku                 = "Basic"
}

resource "azurerm_lb" "public_lb" {
  name                = "public-lb-${var.resource_group_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku                 = "Basic"
  frontend_ip_configuration {
    name                 = "publicFrontend"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.public_lb.id
  name            = "backendPool-${var.resource_group_name}"
}

resource "azurerm_lb_probe" "http_probe" {
  #resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.public_lb.id
  name                = "httpProbe"
  protocol            = "Http"
  request_path        = "/"
  port                = 80
}

resource "azurerm_lb_rule" "http_rule" {
  #resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.public_lb.id
  name                           = "httpRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "publicFrontend"
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_pool_association" {
  count                   = length(var.vm_network_interface_ids)
  network_interface_id    = element(var.vm_network_interface_ids, count.index)
  ip_configuration_name   = "internal" #"ipconfig${count.index + 1}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}
