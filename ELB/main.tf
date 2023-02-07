resource "aws_elb" "load-balancer" {
  name               = var.alb-name
  availability_zones = var.AZ
  security_groups = [var.SG-ELB]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = var.instances-id
  cross_zone_load_balancing   = var.check-cross-zone-load-balancing
  idle_timeout                = 400
  connection_draining         = var.check-connection-draining
  connection_draining_timeout = 400

  tags = {
    Name = var.alb-name
  }
}