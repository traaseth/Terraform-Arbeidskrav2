output "mgmt_subnet_id" {
  value = azurerm_subnet.mgmt.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web.id
}

output "vnet_id" {
  value = azurerm_virtual_network.this.id
}