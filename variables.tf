#-------------------------------------------------------VPC 
variable "vpc-cidrblock" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc-main-name" {
  type = string
  default = "Default-vpc"
}
#-------------------------------------------------------Internet Gateway
variable "gateway-main-name" {
  type = string
  default = "default-gateway"
}
#-------------------------------------------------------Subnets
variable "public-subnet-cidr-blocks" {
  type = list
  default = ["10.0.0.0/24","10.0.2.0/24"]
}

variable "subnet-public-name" {
  type = list
}

variable "private-subnet-cidr-blocks" {
  type = list
  default = ["10.0.1.0/24","10.0.3.0/24"]
}

variable "subnet-private-name" {
  type = list
}
#-------------------------------------------------------Nat-Gateway
variable "nat-gateway-main-name" {
  type = string
  default = "default-Nat-gateway"
}
#-------------------------------------------------------Route Tables

variable "public-tb-main-name" {
  type = string
  default = "default-public-tb"
}

variable "private-tb-main-name" {
  type = string
  default = "default-private-tb"
}
#-------------------------------------------------------Security Groups
#-----------Public EC2 Security Group Variables ------#


variable "ec2-sg-name" {
  type = list
}
variable "sg-name-alb" {
  type = list
}

#-----------General EC2-ALB Security Group Variables ------#
variable "port-of-http" {
  type = number
  default = 80
}

variable "port-of-ssh" {
  type = number
  default = 22
}

variable "tcp-protocol" {
  type = string
  default = "tcp"
}

variable "public-ip-add-list" {
  type = list
  default = ["0.0.0.0/0"]
}

variable "zero-port" {
  type = number
  default = 0
}

variable "all-traf-protocol" {
  type = string
  default = "-1"
}

#-------------------------------------------------------Instances-EC2
#-----------Public EC2 ------------------------------#
variable "value-of-checks" {
  
}

variable "key-pair-name" {
  type = string
  default = "K-P_first-ins.pem"
}

variable "type-of-instance" {
  type = string
  default = "t2.micro"
}

variable "type-of-connect" {
  type = string
  default = "ssh"
}

variable "user-of-instance" {
  type = string
  default = "ec2-user"
}

variable "private-key-path" {
  type = string
  default = "./devops.pem"
}

variable "name-of-instance-public1" {
  type = string
  default = "public-instance-one"
}

variable "name-of-instance-public2" {
  type = string
  default = "public-instance-two"
}

#-----------Public EC2 ------------------------------#
variable "name-of-instance-private1" {
  type = string
  default = "public-instance-one"
}
variable "name-of-instance-private2" {
  type = string
  default = "public-instance-two"
}

#-------------------------------------------------------Load-Balancer
#---------------Public-load-balancer--------------------

variable "name-of-the-pub-lb" {
  type = string
  default = "public-elb"
}
#-----------listners
variable "port-of-instance-alb-listners" {
  type = number
  default = 8000
}

variable "protocol-of-instance-alb-listners" {
  type = string
  default = "http"
}

variable "port-of-alb-listners" {
  type = number
  default = 80
}

variable "protocol-of-alb-listners" {
  type = string
  default = "http"
}
#-----------General Requires---

variable "name-of-pub-alb-in-tags" {
  type = string
  default = "pub-alb"
}