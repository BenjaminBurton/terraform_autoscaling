# modules/vpc/variables.tf
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets_cidr_blocks" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnets_cidr_blocks" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}
