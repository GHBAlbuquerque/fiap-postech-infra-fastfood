data "aws_instance" "ec2" {
  depends_on = [aws_eks_cluster.eks_cluster_fiap_postech]
  filter {
    #name   = "tag:eks:eks_node_group_fiap_postech"
    name   = "tag:eks:nodegroup-name"
    values = ["NG-nginx"]
  }
}