resource "azurerm_network_interface" "web" {
  count               = 2
  name                = "nic-web-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Environment = "dev"
    Project     = "azure-web"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "web_assoc" {
  count                   = 2
  network_interface_id    = azurerm_network_interface.web[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = var.backend_pool_id
}

resource "azurerm_linux_virtual_machine" "web" {
  count               = 2
  name                = "vm-web-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B2s_v2"
  admin_username      = var.admin_username
  zone                = tostring(count.index + 1)

  network_interface_ids = [
    azurerm_network_interface.web[count.index].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    Environment = "dev"
    Project     = "azure-web"
    Role        = "web"
  }
}