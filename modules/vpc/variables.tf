variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnet IDs."
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnet IDs."
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}
