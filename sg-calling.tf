module "SG-Public" {
  source = "./SG-Pub"
  EC2-sg-name = var.ec2-sg-name[0]
  alb-name = var.sg-name-alb[0]
  vpc-cidr = module.vpc.vpc-id

}


module "SG-Private" {
  source = "./SG-Pri"
  EC2-sg-name = var.ec2-sg-name[1]
  alb-name = var.sg-name-alb[1]
  vpc-cidr = module.vpc.vpc-id
  public-EC2-SG = [module.SG-Public.public-sg-ec2]
}