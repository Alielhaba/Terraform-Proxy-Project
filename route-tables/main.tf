resource "aws_route_table" "public-Table" {
  vpc_id = var.vpc-cider

  route {
    cidr_block = "0.0.0.0/24"
    gateway_id = var.gw-id
  } 
  
  tags = {
    Name = var.Public-Table
  }
}

resource "aws_route_table" "private-Table" {
  vpc_id = var.vpc-cider

  route {
    cidr_block = "0.0.0.0/24"
    nat_gateway_id = var.nat-gw
  } 
  
  tags = {
    Name = var.Private-Table
  }
}