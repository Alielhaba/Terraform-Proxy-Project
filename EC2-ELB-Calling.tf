data "aws_ami" "amazon-os" {
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

module "Public-Instance1" {
  source = "./EC2-Public"
  ami-id = data.aws_ami.amazon-os.id
  subnet-id = module.public-subnet.first-sub
  instance-type = var.type-of-instance
  SG-Public = module.SG-Public.public-sg-ec2
  instance-name = var.name-of-instance-public1
  instance-key-pair = var.key-pair-name
}

module "Public-Instance2" {
  source = "./EC2-Public"
  ami-id = data.aws_ami.amazon-os.id
  subnet-id = module.public-subnet.second-sub
  instance-type = var.type-of-instance
  SG-Public = module.SG-Public.public-sg-ec2
  instance-name = var.name-of-instance-public2
  instance-key-pair = var.key-pair-name
}

module "Private-Instance1" {
  source = "./EC2-Private"
  ami-id = data.aws_ami.amazon-os.id
  subnet-id = module.private-subnet.first-sub
  instance-type = var.type-of-instance
  SG-Private = module.SG-Private.sg-ec2
  instance-name = var.name-of-instance-private1
  user-data = <<EOF
    #!/bin/bash
    # install httpd (Linux Version2)
    yum update -y
    yum -y install httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<body>" > /var/www/html/index.html
    echo "<p style="text-align:center;">Private Instance 1</p>" >> /var/www/html/index.html
    echo "<p style="text-align:center;">Tagged Version : Private Instance Number One </p> ">> /var/www/html/index.html
    echo "</body>" >> /var/www/html/index.html
    EOF
    nat = module.vpc.nat
}

module "Private-Instance2" {
  source = "./EC2-Private"
  ami-id = data.aws_ami.amazon-os.id
  subnet-id = module.private-subnet.second-sub
  instance-type = var.type-of-instance
  SG-Private = module.SG-Private.sg-ec2
  instance-name = var.name-of-instance-private2
  user-data = <<EOF
    #!/bin/bash
    # install httpd (Linux Version2)
    yum update -y
    yum -y install httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<body>" > /var/www/html/index.html
    echo "<p style="text-align:center;">Private Instance 2</p>" >> /var/www/html/index.html
    echo "<p style="text-align:center;">Tagged Version : Private Instance Number One </p> ">> /var/www/html/index.html
    echo "</body>" >> /var/www/html/index.html
    EOF
    nat = module.vpc.nat

}


module "ELB-Public" {
  source = "./ELB"
  alb-name = "Public-ELB"
  AZ = [module.public-subnet.first-sub , module.public-subnet.second-sub]
  SG-ELB = module.SG-Public.public-sg--alb
  instances-id = [module.Public-Instance2.EC2-id , module.Public-Instance1.EC2-id ]
  check-cross-zone-load-balancing = true
  check-connection-draining = true

}

module "ELB-Private" {
  source = "./ELB"
  alb-name = "private-ELB"
  AZ = [module.private-subnet.first-sub , module.private-subnet.second-sub]
  SG-ELB = module.SG-Private.sg-alb
  instances-id = [module.Private-Instance2.EC2-id , module.Private-Instance1.EC2-id]
  check-cross-zone-load-balancing = true
  check-connection-draining = true

}

