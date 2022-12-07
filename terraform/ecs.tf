resource "aws_ecs_cluster" "whoogle_ecs_cluster" {
  name = "whoogle-ecs-cluster"
}

resource "aws_ecs_task_definition" "whoogle_ecs_task" {
  family = "whoogle-ecs-task-family"
  cpu    = 512
  memory = 1024
  container_definitions = jsonencode([{
    name  = "whoogle"
    image = "benbusby/whoogle-search:latest"
    # image     = "nginx:latest"
    essential = true
    portMappings = [{
      containerPort = var.container_port
    }]
  }])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}

resource "aws_ecs_service" "whoogle_ecs_service" {
  name            = "whoogle-ecs-service"
  cluster         = aws_ecs_cluster.whoogle_ecs_cluster.id
  task_definition = aws_ecs_task_definition.whoogle_ecs_task.arn
  launch_type     = "FARGATE"
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.whoogle_api.arn
    container_name   = "whoogle"
    container_port   = var.container_port
  }

  network_configuration {
    assign_public_ip = false

    security_groups = [
      module.whoogle_sg.security_group_id,
      aws_security_group.ingress_api.id
    ]

    subnets = module.whoogle_vpc.private_subnets
  }
}
