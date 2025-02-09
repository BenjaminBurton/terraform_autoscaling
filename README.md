# terraform_autoscaling

## Terraform AWS Infrastructure

This Terraform project sets up a basic cloud infrastructure on AWS with the following components:

- Custom VPC with Public and Private Subnets
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG) for EC2 instances
- Security Groups for each component
- Remote backend for storing Terraform state in S3

## Prerequisites

- Terraform v1.0 or above
- AWS credentials configured (via AWS CLI or environment variables)

## Usage

1. Clone the repository:

```bash
   git clone https://github.com/BenjaminBurton/terraform_autoscaling.git
   cd terraform_autoscaling
```
