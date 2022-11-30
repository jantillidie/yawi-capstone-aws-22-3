resource "aws_lb_target_group" "whoogle_target" {
  name     = "whoogletarget"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.whoogle_vpc.id
}


resource "aws_security_group" "allow_http_lb" {
  name        = "http"
  description = "Allow http"
  vpc_id      = aws_vpc.whoogle_vpc.id

  ingress {
    description = "Http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_lb" "whoogle_lb" {
  name               = "whooglelb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_lb.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

}

resource "aws_lb_listener" "whoogle_listener" {
  load_balancer_arn = aws_lb.whoogle_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.whoogle_target.arn
  }
}

output "lb_public_dns_name" {
  value = aws_lb.whoogle_lb.dns_name
}
