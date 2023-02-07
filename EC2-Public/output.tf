output "EC2-id" {
  value = aws_instance.EC2-public.id
}

output "public-ip-ec2" {
  value = aws_instance.EC2-public.public_ip
}
