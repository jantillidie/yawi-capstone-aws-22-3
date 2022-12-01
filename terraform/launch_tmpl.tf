resource "aws_launch_template" "whoogle_instance" {
  name                   = "whoogle-template"
  image_id               = "ami-094125af156557ca2"
  instance_type          = "t3.micro"
  user_data              = filebase64("user_data.sh")
  vpc_security_group_ids = [aws_security_group.allow_http.id]
}

resource "aws_autoscaling_group" "whoogleasg" {
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  max_size            = 3
  min_size            = 1
  desired_capacity    = 2
  launch_template {
    id      = aws_launch_template.whoogle_instance.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.whoogleasg.id
  lb_target_group_arn    = aws_lb_target_group.whoogle_target.arn
}
