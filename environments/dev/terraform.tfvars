#Must be changed to your Azure Sub ID. Can be found in your Azure portal under Subscription
subscription_id      = "30662edb-4cd5-4dd7-ba41-244d66d3a842"
location             = "Sweden Central"
resource_group_name  = "rg-web-dev"
vnet_name            = "vnet-web-dev"
vnet_address_space   = ["10.0.0.0/16"]

mgmt_subnet_name     = "snet-mgmt"
mgmt_subnet_prefixes = ["10.0.1.0/24"]

web_subnet_name      = "snet-web"
web_subnet_prefixes  = ["10.0.2.0/24"]

future_subnet_name     = "snet-future"
future_subnet_prefixes = ["10.0.3.0/24"]

admin_username      = "azureuser"
#must be changed to your .ssh folder on your local machine. Should look like "C:/Users/*UserName*/.ssh/*YourSSHKey*"
ssh_public_key_path = "C:/Users/Traaseth/.ssh/id_rsa_azure.pub"
#Must be changed to your devices public IP https://whatismyipaddress.com/
my_public_ip        = "85.252.210.200"