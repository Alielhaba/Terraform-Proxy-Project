resource "aws_subnet" "subnet" {
  count      = length(var.subnet-cidr-IP)
  vpc_id     = var.vpc-cidr
  cidr_block = var.subnet-cidr-IP[count.index]

  tags = {
    Name = var.subnet-name[count.index]
  }
}