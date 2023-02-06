output "first-sub" {
  value = aws_subnet.subnet[0].id
}

output "second-sub" {
  value = aws_subnet.subnet[1].id
}