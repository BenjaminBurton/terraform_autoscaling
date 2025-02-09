output "asg_id" {
  description = "ID of the created Auto Scaling Group"
  value       = aws_autoscaling_group.asg.id
}
