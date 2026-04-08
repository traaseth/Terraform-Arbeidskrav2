variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "vnet_name" { type = string }
variable "vnet_address_space" { type = list(string) }

variable "mgmt_subnet_name" { type = string }
variable "mgmt_subnet_prefixes" { type = list(string) }

variable "web_subnet_name" { type = string }
variable "web_subnet_prefixes" { type = list(string) }

variable "future_subnet_name" { type = string }
variable "future_subnet_prefixes" { type = list(string) }