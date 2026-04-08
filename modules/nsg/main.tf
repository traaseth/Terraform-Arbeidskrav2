resource "azurerm_network_security_group" "mgmt" {
  name                = "nsg-mgmt"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh-from-my-ip"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.my_public_ip
    destination_address_prefix = "*"
  }

  tags = {
    Environment = "dev"
    Project     = "azure-web"
  }
}

resource "azurerm_network_security_group" "web" {
  name                = "nsg-web"
  location            = var.location
  resource_group_name = var.resource_group_name

 security_rule {
  name                       = "allow-http-from-any"
  priority                   = 120
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}

  security_rule {
    name                       = "allow-ssh-from-mgmt-subnet"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.mgmt_subnet_prefix
    destination_address_prefix = "*"
  }

  tags = {
    Environment = "dev"
    Project     = "azure-web"
  }
}

resource "azurerm_subnet_network_security_group_association" "mgmt_assoc" {
  subnet_id                 = var.mgmt_subnet_id
  network_security_group_id = azurerm_network_security_group.mgmt.id
}

resource "azurerm_subnet_network_security_group_association" "web_assoc" {
  subnet_id                 = var.web_subnet_id
  network_security_group_id = azurerm_network_security_group.web.id
}