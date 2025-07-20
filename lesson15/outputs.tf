output "vm_public_ip" {
  description = "Public IP address of the created VM"
  value       = module.vm.public_ip
}