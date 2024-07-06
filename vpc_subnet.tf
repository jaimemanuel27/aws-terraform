provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "20.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "cloud-esp-vpc2"
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "20.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-1"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "20.0.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "20.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-2"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "20.0.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "gateway-esp"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}

resource "aws_route_table_association" "public1_association" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public2_association" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}


