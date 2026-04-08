resource "azurerm_public_ip" "this" {
  name                = "pip-ansible-controller"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = "dev"
    Project     = "azure-web"
  }
}

resource "azurerm_network_interface" "this" {
  name                = "nic-ansible-controller"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this.id
  }

  tags = {
    Environment = "dev"
    Project     = "azure-web"
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "vm-ansible-controller"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B2s_v2"
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.this.id
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

  custom_data = base64encode(<<-EOF
    #cloud-config
    package_update: true
    packages:
      - ansible
      - python3-pip
  EOF
  )

  tags = {
    Environment = "dev"
    Project     = "azure-web"
    Role        = "ansible-controller"
  }
}