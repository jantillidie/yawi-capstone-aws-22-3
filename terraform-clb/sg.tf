resource "aws_security_group" "allow_http" {
  name        = "whoogle_http"
  description = "Allow http"
  vpc_id      = aws_vpc.whoogle_vpc.id

  ingress {
    description     = "http"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_http_lb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
