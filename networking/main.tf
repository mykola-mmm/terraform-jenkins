variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "cidr_private_subnet" {}
variable "availability_zone" {}


resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.cidr_public_subnet)
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)
  
  tags = {
    Name = "${var.vpc_name} public subnet #${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "${var.vpc_name} private subnet #${count.index + 1}"
  }
}

resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "internet gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_igw.id
  }
  tags = {
    Name = "public route table"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count = length(var.cidr_public_subnet)
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "private route table"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count = length(aws_subnet.private_subnet)
  subnet_id = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}