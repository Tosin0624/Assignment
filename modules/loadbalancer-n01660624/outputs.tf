output "load_balancer_name" {
  value       = azurerm_lb.public_lb.name
  description = "The name of the public load balancer."
}
