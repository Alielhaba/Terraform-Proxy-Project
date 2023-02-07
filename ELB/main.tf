resource "aws_lb" "ALB" {
  name               = var.alb-name
  internal           = var.check-internal
  load_balancer_type = var.alb-type
  security_groups    = [var.SG-alb]
  subnets            = var.subnets-id

  enable_cross_zone_load_balancing = var.check-cross-zone-load-balancing
  enable_deletion_protection = var.deny-check

  tags = {
    Name = var.alb-name
  }
}

resource "aws_lb_target_group" "target-grp" {
   name               = var.target-name
   target_type        = var.target-type
   port               = 80
   protocol           = "HTTP"
   vpc_id             = var.vpc-id
   health_check {
    healthy_threshold   = 2
    interval            = 30
    unhealthy_threshold = 2
    timeout             = 3
    path                = "/"
    port                = 80
  }
}

resource "aws_lb_target_group_attachment" "target_attachment" {
    count = length(var.instances-id)
    target_group_arn = aws_lb_target_group.target-grp.arn
    target_id        = var.instances-id[count.index]
    port             = 80
}


resource "aws_lb_listener" "alb-listener-http" {
   load_balancer_arn    = aws_lb.ALB.arn
   port                 = 80
   protocol             = "HTTP"
   default_action {
    target_group_arn = aws_lb_target_group.target-grp.arn
    type             = "forward"
  }
}