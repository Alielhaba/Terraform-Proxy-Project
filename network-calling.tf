module "vpc" {
  source = "./VPC"  
  cidr-vpc = var.vpc-cidrblock
  name-vpc = var.vpc-main-name
  gateway-name = var.gateway-main-name
  subnet-pub = module.private-subnet.first-sub
  nat-name = var.nat-gateway-main-name
}

module "public-subnet" {
  source = "./subnet"
  vpc-cidr = module.vpc.vpc-id
  subnet-cidr-IP = var.public-subnet-cidr-blocks
  subnet-name = var.subnet-public-name
}

module "private-subnet" {
  source = "./subnet"
  vpc-cidr = module.vpc.vpc-id
  subnet-cidr-IP = var.private-subnet-cidr-blocks
  subnet-name = var.subnet-private-name
}


module "route-tables" {
  source = "./route-tables"
  vpc-cider = module.vpc.vpc-id
  gw-id = module.vpc.gw-id
  Public-Table = var.public-tb-main-name
  nat-gw = module.vpc.nat-id
  Private-Table = var.private-tb-main-name
}

module "Association-public" {
  source = "./Route-Association"
  subnet-ip = [module.public-subnet.first-sub,module.public-subnet.second-sub]
  table-id =  module.route-tables.public-Table-id
}

module "Association-private" {
  source = "./Route-Association"
  subnet-ip = [module.private-subnet.first-sub,module.private-subnet.second-sub]
  table-id =  module.route-tables.private-Table-id
}
