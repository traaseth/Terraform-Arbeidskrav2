resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "dev"
    Project     = "azure-web"
    Owner       = "student"
  }
}