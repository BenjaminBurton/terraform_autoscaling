module "subnets" {
  source = "./subnets"
  vpc_id = aws_vpc.custom_vpc.id
}

module "alb" {
  source = "./alb"
  public_subnets = module.subnets.public_subnets
}

module "internet_gateway" {
  source = "./internet_gateway"
  vpc_id = aws_vpc.custom_vpc.id
}

module "nat_gateway" {
  source = "./nat_gateway"
  public_subnets = module.subnets.public_subnets
}

resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "custom-vpc"
  }
}

output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.custom_vpc.id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = module.subnets.private_subnet_ids
}

output "alb_target_group_arn" {
  description = "The ARN of the application load balancer's target group."
  value       = module.alb.target_group_arn
}
