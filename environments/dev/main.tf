module "resource_group" {
  source              = "../../modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source                = "../../modules/network"
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.location
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  mgmt_subnet_name      = var.mgmt_subnet_name
  mgmt_subnet_prefixes  = var.mgmt_subnet_prefixes
  web_subnet_name       = var.web_subnet_name
  web_subnet_prefixes   = var.web_subnet_prefixes
  future_subnet_name    = var.future_subnet_name
  future_subnet_prefixes = var.future_subnet_prefixes
}

module "nsg" {
  source              = "../../modules/nsg"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  my_public_ip        = var.my_public_ip
  mgmt_subnet_id      = module.network.mgmt_subnet_id
  web_subnet_id       = module.network.web_subnet_id
  mgmt_subnet_prefix  = var.mgmt_subnet_prefixes[0]
}

module "ansible_controller" {
  source              = "../../modules/ansible_controller"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  subnet_id           = module.network.mgmt_subnet_id
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
}

module "load_balancer" {
  source              = "../../modules/load_balancer"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
}

module "web_vms" {
  source                = "../../modules/web_vms"
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.location
  subnet_id             = module.network.web_subnet_id
  admin_username        = var.admin_username
  ssh_public_key_path   = var.ssh_public_key_path
  backend_pool_id       = module.load_balancer.backend_pool_id
}

module "policy" {
  source              = "../../modules/policy"
  resource_group_id   = module.resource_group.resource_group_id
  location            = var.location
}