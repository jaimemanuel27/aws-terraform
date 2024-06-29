resource "aws_instance" "ins1" {
  ami = "ami-01b799c439fd5516a"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.sg-esp.id]
  associate_public_ip_address = true
  key_name = "ec2-key"

  tags = {
    Name = "EC2-i1"
  }
}

resource "aws_instance" "ins2" {
  ami = "ami-01b799c439fd5516a"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.sg-esp.id]
  associate_public_ip_address = true
  key_name = "ec2-key"

  tags = {
    Name = "EC2-i2"
  }
}

