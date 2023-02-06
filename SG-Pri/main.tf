resource "aws_security_group" "sg-private-ec2" {
  name        = var.EC2-sg-name
  vpc_id      = var.vpc-cidr
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.sg-private-alb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name = var.EC2-sg-name
  }
}


resource "aws_security_group" "sg-private-alb" {
  name        = var.alb-name
  vpc_id      = var.vpc-cidr
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = var.public-EC2-SG
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name = var.alb-name
  }
}

