variable "desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID where ASG will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ASG instances"
  type        = list(string)
}
