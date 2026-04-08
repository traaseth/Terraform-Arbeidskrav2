variable "subscription_id" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "mgmt_subnet_name" {
  type = string
}

variable "mgmt_subnet_prefixes" {
  type = list(string)
}

variable "web_subnet_name" {
  type = string
}

variable "web_subnet_prefixes" {
  type = list(string)
}

variable "future_subnet_name" {
  type = string
}

variable "future_subnet_prefixes" {
  type = list(string)
}

variable "admin_username" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "my_public_ip" {
  type = string
}