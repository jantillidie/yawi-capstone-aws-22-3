resource "aws_cloudwatch_metric_alarm" "whoogle_metric_alarm" {
  alarm_name          = "whoogle_metric_alarm"
  alarm_description   = "Alarm when there are too few instances in the ECS cluster"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ContainerInsightsReachesThreshold"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "2"

  alarm_actions = [aws_sns_topic.ecs_topic.arn]
}

resource "aws_sns_topic" "ecs_topic" {
  name = "ecs_alarm_sns_topic"
}

resource "aws_sns_topic_subscription" "ecs_email_subscription" {
  topic_arn = aws_sns_topic.ecs_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email
}
