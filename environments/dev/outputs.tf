output "ansible_public_ip" {
  value = module.ansible_controller.public_ip
}

output "load_balancer_public_ip" {
  value = module.load_balancer.public_ip
}

output "web_private_ips" {
  value = module.web_vms.private_ips
}