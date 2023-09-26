output "public_ip" {
  value = module.public_ip
}

output "virtual_network_subnets" {
  value = { for key, value in flatten([for key, value in module.virtual_network : value.network.subnet]) : value.name => value.id }
}

output "nsg" {
  value = module.network_security_group.nsg
}

output "nic" {
  value = { for key, value in module.network_nic : key => value.nic_id }
}

output "vm_ip" {
  value = { for key, value in module.virtual_machine : value.vm_ip.vm_name => value.vm_ip.ip }
}
