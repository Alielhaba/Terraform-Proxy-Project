#-------------------------------------------------------VPC 
vpc-cidrblock = "10.0.0.0/16"
vpc-main-name = "Dev-VPC"
#-------------------------------------------------------Internet Gateway
gateway-main-name = "Dev-Gateway"
ec2-sg-name = ["SG-Public-EC2" , "Private-SG-EC2"]
sg-name-alb = ["SG-Public-ALB" , "Private-SG-ALB"]
#-------------------------------------------------------Subnets
public-subnet-cidr-blocks = ["10.0.0.0/24","10.0.2.0/24"]
subnet-public-name = ["dev-public-subnet1","dev-public-subnet2"]
private-subnet-cidr-blocks = ["10.0.1.0/24","10.0.3.0/24"]
subnet-private-name = ["dev-private-subnet1","dev-private-subnet2"]
#-------------------------------------------------------Nat-Gateway
nat-gateway-main-name = "dev-nat-gateway"
#-------------------------------------------------------Route Tables
public-tb-main-name = "dev-public-route-tb"
private-tb-main-name = "dev-private-route-tb"
#-------------Public Instances------------------
value-of-checks = "true"
key-pair-name = "terraform-west"
type-of-instance = "t2.micro"
type-of-connect = "ssh"
user-of-instance = "ec2-user"
private-key-path = "./devops.pem"
name-of-instance-public1 = "dev-instance-one-public"
name-of-instance-public2 = "dev-instance-two-public"
#-------------Public Instances------------------
name-of-instance-private1 = "dev-instance-one-private"
name-of-instance-private2 = "dev-instance-two-private"
#-------------------------------------------------------Load-Balancer
#---------------Public-load-balancer--------------------
name-of-the-pub-lb = "dev-public-load-balancer"
#-------Listners
port-of-instance-alb-listners = 8000
protocol-of-instance-alb-listners = "http"
port-of-alb-listners = 80
protocol-of-alb-listners = "http"
#--------General Requires
name-of-pub-alb-in-tags = "dev-public-alb"