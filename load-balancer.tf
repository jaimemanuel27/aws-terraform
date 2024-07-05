resource "aws_lb" "load_balancer" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-esp.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "tg-esp" {
  name     = "tg-esp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-esp.arn
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment_1" {
  count            = 2
  target_group_arn = aws_lb_target_group.tg-esp.arn
  target_id        = aws_instance.ins1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_2" {
  count            = 2
  target_group_arn = aws_lb_target_group.tg-esp.arn
  target_id        = aws_instance.ins2.id
  port             = 80
}