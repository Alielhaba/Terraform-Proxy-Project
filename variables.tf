variable "vpc-cidrblock" {
  type    = string
}

variable "vpc-main-name" {
  type = string
}

variable "gateway-main-name" {
  type = string
}

variable "public-subnet-cidr-blocks" {
  type = list
  
}

variable "subnet-public-name" {
  type = list
}

variable "private-subnet-cidr-blocks" {
  type = list
}

variable "subnet-private-name" {
  type = list
}

variable "nat-gateway-main-name" {
  type = string
}

variable "public-tb-main-name" {
  type = string
}

variable "private-tb-main-name" {
  type = string
}

variable "ec2-sg-name" {
  type = list
}

variable "sg-name-alb" {
  type = list
}

variable "key-pair-name" {
  type = string
}

variable "type-of-instance" {
  type = string
}

variable "name-of-instance-public1" {
  type = string
}

variable "name-of-instance-public2" {
  type = string
}

variable "name-of-instance-private1" {
  type = string
}

variable "name-of-instance-private2" {
  type = string
}

variable "name-of-the-pub-lb" {
  type = string
}

variable "name-of-the-pri-lb" {
  type = string
  
}

variable "alb-type" {
  
}

variable "target-name-public" {
  type = string
  
}

variable "target-name-private" {
  type = string
  
}


variable "target-type" {
  type = string
 
}

