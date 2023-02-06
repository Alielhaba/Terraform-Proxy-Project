output "public-sg-ec2" {
  value = aws_security_group.sg-public-ec2.id
}

output "public-sg--alb" {
  value = aws_security_group.sg-public-alb.id
}
