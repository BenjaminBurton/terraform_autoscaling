module "asg" {
  source = "./asg"

  desired_capacity     = 2
  min_size             = 2
  max_size             = 5
  vpc_id               = aws_vpc.custom_vpc.id
  private_subnet_ids   = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}
