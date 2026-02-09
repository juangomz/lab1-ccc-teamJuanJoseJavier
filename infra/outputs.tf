output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "ec2_public_dns" {
  value = aws_instance.team_vm.public_dns
}

output "peering_connection_id" {
  description = "VPC peering connection ID (pcx-...) if created, otherwise null"
  value       = length(aws_vpc_peering_connection.peer) > 0 ? aws_vpc_peering_connection.peer[0].id : null
}
