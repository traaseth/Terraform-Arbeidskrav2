output "private_ips" {
  value = azurerm_network_interface.web[*].private_ip_address
}