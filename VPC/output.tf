output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "gw-id" {
  value = aws_internet_gateway.gw.id
}

output "nat-id" {
  value = aws_nat_gateway.nat.id
}

output "nat" {
  value = aws_nat_gateway.nat
}