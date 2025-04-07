resource "aws_eks_node_group" "devstage_public_nodes" {
  provider            = aws.devstage
  cluster_name        = aws_eks_cluster.eks_devstage.name
  node_group_name     = "${var.project_name}-devstage-public"
  node_role_arn       = aws_iam_role.node_group_role.arn
  subnet_ids          = var.devstage_public_subnet_ids
  instance_types      = var.node_instance_types
  capacity_type       = "ON_DEMAND"

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  disk_size = var.node_disk_size
  ami_type  = "AL2_x86_64"

  remote_access {
    ec2_ssh_key = var.ssh_key_name
  }

  tags = merge(local.common_tags, { "Environment" = "devstage", "Type" = "public" })
}


resource "aws_eks_node_group" "devstage_private_nodes" {
  provider            = aws.devstage
  cluster_name        = aws_eks_cluster.eks_devstage.name
  node_group_name     = "${var.project_name}-devstage-private"
  node_role_arn       = aws_iam_role.node_group_role.arn
  subnet_ids          = var.devstage_private_subnet_ids
  instance_types      = var.node_instance_types
  capacity_type       = "ON_DEMAND"

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  disk_size = var.node_disk_size
  ami_type  = "AL2_x86_64"

  tags = merge(local.common_tags, { "Environment" = "devstage", "Type" = "private" })
}