#====================================================
# Autoscaling
#====================================================
resource "aws_appautoscaling_target" "ecs_target" {
  min_capacity       = 3
  max_capacity       = 5
  resource_id        = "service/${aws_ecs_cluster.whoogle_ecs_cluster.name}/${aws_ecs_service.whoogle_ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

#====================================================
# Autoscaling Policies
#====================================================
resource "aws_appautoscaling_policy" "appautoscaling_policy_cpu" {
  name               = "application-scale-policy-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 80
  }
}

resource "aws_appautoscaling_policy" "appautoscaling_policy_memory" {
  name               = "application-scale-policy-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 80
  }
}
