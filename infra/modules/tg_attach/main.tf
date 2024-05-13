#FIXME criar um modulo de attach e fazer uma regra para gerar um attach por instancia encontrada, ou teria o erro
#FIXME │ Error: multiple EC2 Instances matched; use additional constraints to reduce matches to a single EC2 Instance
resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = var.target_group_arn
  target_id        = data.aws_instance.ec2.id
  port             = 30007
}