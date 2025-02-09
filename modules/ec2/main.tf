resource "aws_instance" "web_server" {
  ami             = var.ami_id
  instance_type   = "t2.micro"
  subnet_id       = var.private_subnet_id
  user_data       = file("user_data.sh")
  security_groups = [aws_security_group.sg.id]

  tags = {
    Name = "WebServer"
  }
}

resource "aws_security_group" "sg" {
  name        = "web_server_sg"
  description = "Allow inbound HTTP and SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
