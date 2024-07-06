resource "aws_db_subnet_group" "subnet_rds" {
  name       = "subnet_rds"
  subnet_ids = [aws_subnet.public1.id, aws_subnet.public2.id]

  tags = {
    Name = "DB Subnet Group"
  }
}

resource "aws_db_instance" "db_rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  db_name              = "db_rds"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "pass_123"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.subnet_rds.name
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.sg-esp.id]

  tags = {
    Name = "RDS Instance"
  }
}