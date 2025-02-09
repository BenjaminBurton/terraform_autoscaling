variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID where EC2 instances will be launched"
  type        = string
}
