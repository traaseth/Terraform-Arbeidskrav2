output "mgmt_nsg_id" {
  value = azurerm_network_security_group.mgmt.id
}

output "web_nsg_id" {
  value = azurerm_network_security_group.web.id
}