output "vpc_id" {
  value = aws_vpc.dell_vpc
}

output "public_subnet_id" {
  value = aws_subnet.publicsubnet.id
}

output "private_subnet_id" {
  value = aws_subnet.privatesubnet.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.Igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}
