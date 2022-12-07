#====================================================
# ALB Application Load Balancer
#====================================================
resource "aws_lb" "whoogle_alb" {
  name               = "whoogle-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.whoogle_vpc.public_subnets
  security_groups    = [module.whoogle_sg.security_group_id]
}

#====================================================
# ALB Target Group
#====================================================
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

#====================================================
# ALB Listener for http port 80
#====================================================
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.whoogle_alb.id
  port              = "80"
  protocol          = "HTTP"

  depends_on = [aws_lb_target_group.whoogle_api]

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

#====================================================
# ALB Listener for https port 443
#====================================================
resource "aws_lb_listener" "whoogle_https" {
  load_balancer_arn = aws_lb.whoogle_alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  depends_on        = [aws_lb_target_group.whoogle_api]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.whoogle_api.arn
  }

  certificate_arn = aws_acm_certificate_validation.whoogle_site.certificate_arn
}
