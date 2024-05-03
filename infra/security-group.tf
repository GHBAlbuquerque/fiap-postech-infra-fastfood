resource "aws_security_group" "sg" {
  name        = "sec-group-cluster-fiap"
  description = "Seucirty Group for EKS Cluster"
  vpc_id      = var.vpc_id

  ingress {
    description = "All"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # semantically equivalent to all
    cidr_blocks = [var.vpc_cidr_block]
  }


  egress {
    description = "All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # semantically equivalent to all
    cidr_blocks = ["0.0.0.0/0"]
  }
}