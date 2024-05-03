data "aws_instance" "ec2" {
  filter {
    name   = "tag:eks:eks_node_group_fiap_postech"
    values = ["NG-nginx"]
  }
}