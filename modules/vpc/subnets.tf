resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[0]
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[1]
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[0]
  availability_zone = "us-east-1a"
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet_cidr_blocks[1]
  availability_zone = "us-east-1b"
  tags = {
    Name = "private-subnet-2"
  }
}
