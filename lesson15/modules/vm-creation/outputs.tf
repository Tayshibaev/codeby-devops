output "instance_id" {
  description = "ID of the created instance"
  value       = aws_instance.vm.id
}

output "public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.vm.public_ip
}