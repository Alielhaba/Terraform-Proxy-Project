data "aws_ami" "amazon-os" {
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

module "Public-Instance1" {
  source = "./EC2-Public"
  ami-id = data.aws_ami.ubuntu.id
  subnet-id = module.public-subnet.first-sub
  instance-type = var.type-of-instance
  SG-Public = module.SG-Public.public-sg-ec2
  instance-name = var.name-of-instance-public1
  instance-key-pair = var.key-pair-name
  private-ALB-DNS = module.ALB-Private.ALB-DNS
}

module "Public-Instance2" {
  source = "./EC2-Public"
  ami-id = data.aws_ami.ubuntu.id
  subnet-id = module.public-subnet.second-sub
  instance-type = var.type-of-instance
  SG-Public = module.SG-Public.public-sg-ec2
  instance-name = var.name-of-instance-public2
  instance-key-pair = var.key-pair-name
  private-ALB-DNS = module.ALB-Private.ALB-DNS

}

module "Private-Instance1" {
  source = "./EC2-Private"
  ami-id = data.aws_ami.amazon-os.id
  subnet-id = module.private-subnet.first-sub
  instance-type = var.type-of-instance
  SG-Private = module.SG-Private.sg-ec2
  instance-name = var.name-of-instance-private1
 user-data =  <<EOF
    #!/bin/bash
   yum update -y
   yum install -y httpd
   systemctl start httpd
   systemctl enable httpd
   echo "Hello World from $(hostname -f)" > /var/www/html/index.html
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
  user-data =  <<EOF
   #!/bin/bash
   yum update -y
   yum install -y httpd
   systemctl start httpd
   systemctl enable httpd
   echo "Hello World from $(hostname -f)" > /var/www/html/index.html
  EOF
    nat = module.vpc.nat
}


module "ALB-Public" {
  source = "./ELB"
  alb-name = var.name-of-the-pub-lb
  alb-type = var.alb-type
  check-internal = false
  SG-alb = module.SG-Public.public-sg--alb
  subnets-id = [module.public-subnet.first-sub,module.public-subnet.second-sub]
  check-cross-zone-load-balancing = true
  deny-check = false
  target-name = var.target-name-public
  target-type = var.target-type
  instances-id = [module.Public-Instance2.EC2-id,module.Public-Instance1.EC2-id]
  vpc-id = module.vpc.vpc-id
  
}

module "ALB-Private" {
  source = "./ELB"
  alb-name = var.name-of-the-pri-lb
  alb-type = var.alb-type
  check-internal = false
  SG-alb = module.SG-Private.sg-alb
  subnets-id = [module.private-subnet.first-sub,module.private-subnet.second-sub]
  check-cross-zone-load-balancing = true
  deny-check = false
  target-name = var.target-name-private
  target-type = var.target-type
  instances-id = [module.Private-Instance1.EC2-id,module.Private-Instance2.EC2-id]
  vpc-id = module.vpc.vpc-id
}

