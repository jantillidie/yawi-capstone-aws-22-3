# NEEDS FURTHER TESTING:
# resource "aws_cloudwatch_metric_alarm" "whoogle_metric_alarm" {
#   alarm_name          = "whoogle_metric_alarm"
#   alarm_description   = "This alarm will trigger when there are less than 2 tasks running in the ECS cluster"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "RunningTasks"
#   namespace           = "AWS/ECS"
#   period              = "60"
#   statistic           = "Minimum"
#   threshold           = "2"

#   dimensions = {
#     ClusterName = "whoogle-ecs-cluster"
#     ServiceName = "whoogle-ecs-service"
#   }

#   alarm_actions = [aws_sns_topic.ecs_topic.arn]
# }

#====================================================
# Cloudwatch Metric Alarm
#====================================================
resource "aws_cloudwatch_metric_alarm" "whoogle_metric_alarm" {
  alarm_name          = "whoogle_metric_alarm"
  alarm_description   = "This metric monitors cpu utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    ClusterName = "whoogle-ecs-cluster"
    ServiceName = "whoogle-ecs-service"
  }

  alarm_actions = [aws_sns_topic.ecs_topic.arn]
}

#====================================================
# Cloudwatch notification with sns
#====================================================
resource "aws_sns_topic" "ecs_topic" {
  name = "ecs_alarm_sns_topic"
}

resource "aws_sns_topic_subscription" "ecs_email_subscription" {
  topic_arn = aws_sns_topic.ecs_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email
}
