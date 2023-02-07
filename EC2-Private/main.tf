resource "aws_instance" "EC2-Private" {
  ami           = var.ami-id
  subnet_id = var.subnet-id
  instance_type = var.instance-type
  provisioner "local-exec" {
    command = "echo ${lookup(self.tags, "Name")}   ${self.private_ip} >> ./private-ip.txt"
  }
  user_data = var.user-data
  vpc_security_group_ids = [var.SG-Private]
  depends_on = [
    var.nat
  ]
  tags = {
    Name = var.instance-name
  }
}