resource "aws_vpc" "vpc" {
  cidr_block = var.cidr-vpc
  tags = {
    "Name" = var.name-vpc
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.gateway-name
  }
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.subnet-pub

  tags = {
    Name = var.nat-name
  }
  depends_on = [aws_internet_gateway.gw]
}
