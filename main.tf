module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets_cidr_blocks = var.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
}

module "asg" {
  source = "./modules/asg"
  desired_capacity = var.asg.desired_capacity
  min_size = var.asg.min_size
  max_size = var.asg.max_size
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  private_subnet_id = module.vpc.private_subnet_1_id
}
