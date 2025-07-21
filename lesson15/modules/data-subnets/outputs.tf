output "subnets" {
  description = "Map of all subnets in the VPC with their details"
  value       = data.aws_subnet.details
}

output "subnet_ids_by_zone" {
  description = "Map of subnet IDs grouped by availability zone"
  value = {
    for subnet in data.aws_subnet.details :
    subnet.availability_zone => subnet.id...
  }
}