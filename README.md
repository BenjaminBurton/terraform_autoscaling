# Terraform Autoscaling

## Overview

This Terraform project sets up an autoscaling cloud infrastructure on AWS. It provisions a highly available and scalable architecture, including a Custom VPC with both Public and Private Subnets, an Application Load Balancer (ALB), an Auto Scaling Group (ASG), and EC2 instances running a web application. It is designed to automatically scale the number of instances based on traffic demand.

The project also leverages AWS networking components like Internet Gateway (IGW) and NAT Gateway to provide internet access for resources in both public and private subnets. Security Groups are created to manage network access to resources, ensuring the environment is both secure and scalable.

### Key Features

This infrastructure includes the following components:

Custom VPC:

- CIDR Block: Defines a private network for your resources.
- Subnets: The VPC contains 2 public subnets (for load balancers and NAT gateways) and 2 private subnets (for EC2 instances).
- Route Tables: One for public subnet routing (with IGW) and one for private subnets (with NAT gateway for internet access).

Application Load Balancer (ALB):

- The ALB is used to distribute incoming traffic evenly across the EC2 instances in the private subnets, improving the availability and fault tolerance of your web application.

Auto Scaling Group (ASG):

- The ASG ensures that your EC2 instances can automatically scale up or down based on traffic demand. The configuration sets a minimum of 2 instances and a maximum of 5 instances, ensuring that there are always enough resources to handle the incoming load.

EC2 Instances:

- EC2 instances are created within private subnets to run your application. These instances are launched with a simple Apache Web Server as part of their user data configuration to serve content.

Security Groups:

- Security Groups are created for each component (ALB, EC2 instances) to control access. The ALB’s Security Group allows HTTP/HTTPS access, and the EC2 instances' Security Group allows inbound traffic only from the ALB.

Remote Backend (S3 & DynamoDB):

- Terraform’s state is stored remotely in an S3 bucket for consistency, and DynamoDB is used for state locking, preventing race conditions during Terraform runs in team environments.

### Project Structure

The project is modularized to make it easy to manage and customize. Below is an outline of the project’s file structure:

```bash
/terraform
├── main.tf                 # Root module, calls other modules (including VPC, ASG, EC2, etc.)
├── variables.tf            # All input variables
├── outputs.tf              # All output values from the Terraform execution
├── providers.tf            # AWS provider configuration for Terraform
├── backend.tf              # S3 backend configuration for state management (already added)

├── modules/
│   ├── vpc/               # Custom VPC module, which includes networking configurations
│   │   ├── main.tf        # VPC resources (subnets, route tables, etc.)
│   │   ├── variables.tf   # Variables for VPC (e.g., CIDR blocks)
│   │   ├── outputs.tf     # Outputs related to VPC (e.g., VPC ID, subnet IDs)
│   │   ├── subnets.tf     # Public and private subnet definitions
│   │   ├── route_tables.tf # Definitions for public and private route tables
│   │   ├── igw.tf         # Internet Gateway configuration for public subnets
│   │   ├── nat_gateway.tf # NAT Gateway configuration for private subnets
│   │   ├── alb.tf         # Application Load Balancer configuration in public subnets

│   ├── asg/               # Auto Scaling Group module
│   │   ├── main.tf        # Resources for the Auto Scaling Group (ASG)
│   │   ├── variables.tf   # ASG-related variables (e.g., desired capacity)
│   │   ├── outputs.tf     # Outputs related to the ASG (e.g., ASG name)

│   ├── ec2/               # EC2 instance module
│   │   ├── main.tf        # EC2 instance creation and configuration
│   │   ├── variables.tf   # EC2-related variables (e.g., AMI ID, subnet)
│   │   ├── outputs.tf     # Outputs related to EC2 instances (e.g., instance IDs)

└── ...                     # Additional modules as needed
```

### Modules Directory

- vpc/: Contains resources for creating a custom VPC, including subnets, route tables, and internet access configurations.
- asg/: Defines the Auto Scaling Group that manages the EC2 instances.
- ec2/: Defines the EC2 instances, including user data scripts to install software and configure them on startup.
- alb/: Contains configurations for setting up the Application Load Balancer.
- internet_gateway/: Configures the internet gateway required for public internet access.
- nat_gateway/: Configures the NAT gateway for private subnet internet access.

### Terraform Directory

- main.tf: This file serves as the entry point for the Terraform configuration. It references all the modules that make up the infrastructure.
- variables.tf: Defines all the variables used in the Terraform configuration. These variables allow you to customize the configuration as needed.
- outputs.tf: Defines the outputs that will be displayed after the Terraform run, such as the VPC ID, subnet IDs, and the ALB DNS name.
- providers.tf: Specifies the AWS provider for Terraform, including the region and credentials.
- backend.tf: Configures the backend for storing the Terraform state in S3 and using DynamoDB for state locking.

### Prerequisites

Before you begin, ensure the following requirements are met:

Terraform v1.0 or higher: This project uses Terraform to manage the infrastructure. Make sure you have Terraform installed. If you don't, follow the installation guide on the official Terraform website.

AWS Credentials: Terraform needs AWS credentials to interact with AWS resources. You can configure AWS CLI with the aws configure command to set up the required credentials and region.

### Usage

Follow these steps to deploy the infrastructure:

### Step 1: Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/BenjaminBurton/terraform_autoscaling.git
cd terraform_autoscaling
```

### Step 2: Set Up AWS Credentials

Ensure your AWS credentials are configured. You can set this up using AWS CLI by running:

```bash
aws configure
```

This will prompt you to enter your AWS Access Key ID, Secret Access Key, and region.

### Step 3: Initialize Terraform

Before applying any configurations, initialize Terraform to download the required provider plugins:

```bash
terraform init
```

### Step 4: Review the Terraform Plan

It’s a good practice to review the execution plan before applying changes. This allows you to see what resources Terraform will create, modify, or delete:

```bash
terraform plan
```

### Step 5: Apply the Terraform Configuration

Once you’re happy with the plan, apply the configuration to provision the resources:

```bash
terraform apply
```

Terraform will prompt you for confirmation. Type yes to proceed.

### Step 6: Access Your Resources

Once Terraform has successfully applied the changes, the following resources will be provisioned:

- VPC: A custom VPC with 2 public and 2 private subnets.
- ALB: An Application Load Balancer (ALB) that distributes incoming traffic.
- ASG: An Auto Scaling Group that dynamically scales EC2 instances based on traffic demand.
- EC2 Instances: EC2 instances running in private subnets with Apache web server.

### Step 7: Clean Up Resources

To destroy the infrastructure and remove all resources, run:

```bash
terraform destroy
```

This will remove the resources created by Terraform.

### Customizing the Infrastructure

To modify the infrastructure, edit the respective module’s configuration files. For example:

To change the CIDR block of the VPC, modify the variables.tf in the vpc module.
To adjust the desired capacity of the Auto Scaling Group, edit the variables.tf file in the asg module.
To change the instance type of EC2 instances, update the variables.tf in the ec2 module.

Once you make changes, run terraform plan and terraform apply to update the infrastructure accordingly.

### Conclusion

This project provides an automated, scalable, and secure AWS infrastructure using Terraform. By leveraging AWS services like VPC, ALB, EC2, and Auto Scaling, you can easily manage and scale a web application. The modular approach ensures that configurations are organized and reusable, making it easier to maintain and customize for different environments.

By using a remote S3 backend for storing the Terraform state and DynamoDB for state locking, this project enables secure collaboration and prevents conflicts when working in teams.
