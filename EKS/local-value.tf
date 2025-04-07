resource "aws_eks_cluster" "eks_cluster" {
  for_each = local.regions

  name     = local.cluster_names[each.key]
  region   = each.value
  version  = local.cluster_version

  vpc_config {
    subnet_ids = var.subnet_ids[each.key]
    security_group_ids = var.security_group_ids[each.key]
  }

  endpoint_private_access = local.endpoint_config[each.key].private_access
  endpoint_public_access  = local.endpoint_config[each.key].public_access
  public_access_cidrs     = local.endpoint_config[each.key].public_access_cidrs

  tags = local.common_tags
}
locals {
  
  common_tags = {
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = var.environment
  }

  
  node_group_config = {
    devstage = {
      provider           = aws.devstage
      cluster_name       = aws_eks_cluster.eks_devstage.name
      public_subnets     = var.devstage_public_subnet_ids
      private_subnets    = var.devstage_private_subnet_ids
    }
    prod = {
      provider           = aws.prod
      cluster_name       = aws_eks_cluster.eks_prod.name
      public_subnets     = var.prod_public_subnet_ids
      private_subnets    = var.prod_private_subnet_ids
    }
    prod_backup = {
      provider           = aws.prod_backup
      cluster_name       = aws_eks_cluster.eks_prod_backup.name
      public_subnets     = var.prod_backup_public_subnet_ids
      private_subnets    = var.prod_backup_private_subnet_ids
    }
  }

  n
  node_instance_types  = var.node_instance_types
  node_desired_size    = var.node_desired_size
  node_max_size        = var.node_max_size
  node_min_size        = var.node_min_size
  node_disk_size       = var.node_disk_size
  node_role_arn        = aws_iam_role.node_group_role.arn
  ssh_key_name         = var.ssh_key_name
}
locals {
  name = "apache-fineract"
}
