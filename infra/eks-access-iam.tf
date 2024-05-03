/*resource "aws_eks_access_policy_association" "eks-policy" {
  cluster_name  = aws_eks_cluster.eks_cluster_fiap_postech.name
  policy_arn    = var.policy_arn
  principal_arn = var.principal_arn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "access-entry" {
  cluster_name      = aws_eks_cluster.eks_cluster_fiap_postech.name
  principal_arn     = var.principal_arn
  kubernetes_groups = ["fiap", "live"]
  type              = "STANDARD"
}*/