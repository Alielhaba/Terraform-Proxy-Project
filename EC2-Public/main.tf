resource "aws_instance" "EC2-public" {
  ami           = var.ami-id
  subnet_id = var.subnet-id
  instance_type = var.instance-type
  associate_public_ip_address = true
  key_name = var.instance-key-pair
  vpc_security_group_ids = [var.SG-Public]
  provisioner "local-exec" {
    command = "echo ${lookup(self.tags, "Name")}   ${self.public_ip} >> ./private-ip.txt"
  }

  # user_data = <<EOF
  #   #!/bin/bash
  #   # install httpd (Linux Version2)
  #   yum update -y
  #   yum -y install httpd
  #   systemctl start httpd
  #   EOF
  provisioner "remote-exec" {
  
    inline = [
     "sudo apt update -y",
      "sudo apt install nginx -y ",
      "echo 'server {\nlisten 80 default_server;\nlisten [::]:80 default_server;\nserver_name _;\nlocation / {\nproxy_pass http://${var.private-ALB-DNS};\n}\n}' > default",
      "sudo mv default /etc/nginx/sites-enabled/default",
      "sudo systemctl restart nginx"
    ]
  }
  connection {
      type = "ssh"
      host = self.public_ip
      user        = "ubuntu"
      private_key = file("~/.ssh/ali.pem")
    }
  tags = {
    Name = var.instance-name
  }
}