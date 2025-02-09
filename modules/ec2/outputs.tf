output "ec2_instance_ids" {
  description = "The IDs of the EC2 instances in the Auto Scaling Group."
  value       = aws_instance.web_instances[*].id
}
