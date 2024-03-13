#************************Common-n01660624************************
#************************datadisk-n01660624************************

#************************rgroup-n01660624************************
output "resource_group_name" {
  value = module.rgroup-n01660624.resource_group_name
}

#************************database-n01660624************************
output "postgresql_server_name" {
  value = module.database-n01660624.postgresql_server_name
}

#************************loadbalancer-n01660624************************
output "load_balancer_name" {
  value = module.loadbalancer-n01660624.load_balancer_name
}

#************************network-n01660624************************

#************************vmlinux-n01660624************************
output "vm_names" {
  value       = module.vmlinux-n01660624.vm_names
}

output "domain_names" {
  value       = module.vmlinux-n01660624.domain_names
}

output "private_ips" {
  value       = module.vmlinux-n01660624.private_ips
}

output "public_ips" {
  value       = module.vmlinux-n01660624.public_ips
}

#************************vmwindows-n01660624************************
output "hostname" {
  value       = module.vmwindows-n01660624.hostname
}

output "domain_name" {
  value       = module.vmwindows-n01660624.domain_name
}

output "private_ip" {
  value       = module.vmwindows-n01660624.private_ip
}

output "public_ip" {
  value       = module.vmwindows-n01660624.public_ip
}
