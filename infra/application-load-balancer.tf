resource "aws_alb" "alb-cluster-fiap" {
  depends_on         = [aws_eks_cluster.eks_cluster_fiap_postech]
  name               = "alb-cluster-fiap"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.subnet_id_a, var.subnet_id_b, var.subnet_id_c, var.subnet_id_d]
  security_groups    = [aws_security_group.sg.id]
  idle_timeout       = 60
}

resource "aws_lb_target_group" "target-group-cluster-fiap" {
  name        = "tg-cluster-fiap"
  port        = 30007
  target_type = "instance"
  protocol    = "HTTP"

  vpc_id = var.vpc_id

  health_check {
    path     = "/actuator/health"
    port     = 30007
    matcher  = "200"
    interval = 90
    timeout  = 60
  }
}

resource "aws_lb_target_group_attachment" "attach" {
  depends_on       = [aws_eks_cluster.eks_cluster_fiap_postech]
  target_group_arn = aws_lb_target_group.target-group-cluster-fiap.arn
  target_id        = data.aws_instance.ec2.id
  port             = 30007
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.alb-cluster-fiap.arn
  port              = "80" #era porta 80 no exemplo
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group-cluster-fiap.arn
  }
}

output "dns_loadbalancer" {
  value = aws_alb.alb-cluster-fiap.dns_name
}

