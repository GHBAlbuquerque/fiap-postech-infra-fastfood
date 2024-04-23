resource "aws_eks_cluster" "eks_cluster_fiap_postech" {
  name     = "eks_cluster_fiap_postech"
  role_arn = var.lab_role_arn

  vpc_config {
    subnet_ids = [var.subnet_id_a, var.subnet_id_b, var.subnet_id_c, var.subnet_id_d]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
#  depends_on = [
#    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
#    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
#  ]
}

output "endpoint" {
  value = aws_eks_cluster.eks_cluster_fiap_postech.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster_fiap_postech.certificate_authority[0].data
}

resource "aws_eks_node_group" "eks_node_group_fiap_postech" {
  cluster_name    = aws_eks_cluster.eks_cluster_fiap_postech.name
  node_group_name = "eks_node_group_fiap_postech"
  node_role_arn   = var.lab_role_arn
  subnet_ids      = [var.subnet_id_a, var.subnet_id_b, var.subnet_id_c, var.subnet_id_d]
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#  depends_on = [
#    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
#    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
#    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
#  ]
}

// lets assume we have two target group arn.
// one points to node port 80 and one to 30000
#resource "aws_lb" "nlb-cluster-fiap" {
#  name               = "nlb-cluster-fiap"
#  internal           = false
#  load_balancer_type = "network"
#  subnets            =  [var.subnet_id_a, var.subnet_id_b, var.subnet_id_c, var.subnet_id_d]
#
#  enable_deletion_protection = true
#
#  target_groups = [
#    {
#      name_prefix      = "${local.target_group_names[0]}-"
#      backend_protocol = "TCP"
#      backend_port     = 80
#      target_type      = "instance"
#    },
#    {
#      name_prefix      = "${local.target_group_names[1]}-"
#      backend_protocol = "TCP"
#      backend_port     = 30000
#      target_type      = "instance"
#    }
#  ]
#
#  http_tcp_listeners = [
#    {
#      port               = 80
#      protocol           = "TCP"
#      target_group_index = 0
#    },
#    {
#      port               = 81
#      protocol           = "TCP"
#      target_group_index = 1
#    }
#  ]
#
#}
