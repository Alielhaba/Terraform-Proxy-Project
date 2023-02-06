output "sg-ec2" {
  value = aws_security_group.sg-private-ec2.id
}

output "sg-alb" {
  value = aws_security_group.sg-private-alb.id
}