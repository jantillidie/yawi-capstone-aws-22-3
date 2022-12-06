resource "aws_lb" "whoogle_alb" {
  name               = "whoogle-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.whoogle_vpc.public_subnets
  security_groups    = [module.whoogle_sg.security_group_id]
}



resource "aws_lb_target_group" "whoogle_api" {
  name        = "whoogle-api"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.whoogle_vpc.vpc_id

  health_check {
    enabled = true
    path    = "/"
  }
}

resource "aws_alb_listener" "http_listener" {
  load_balancer_arn = aws_lb.whoogle_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.whoogle_api.arn
  }
}
