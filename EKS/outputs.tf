output "devstage_cluster_id" {
  description = "The name/id of the DevStage EKS cluster."
  value       = aws_eks_cluster.devstage_eks_cluster.id
}

output "prod_cluster_id" {
  description = "The name/id of the Prod EKS cluster."
  value       = aws_eks_cluster.prod_eks_cluster.id
}

output "prod_backup_cluster_id" {
  description = "The name/id of the Prod Backup EKS cluster."
  value       = aws_eks_cluster.prod_backup_eks_cluster.id
}

output "devstage_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the DevStage cluster."
  value       = aws_eks_cluster.devstage_eks_cluster.arn
}

output "prod_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the Prod cluster."
  value       = aws_eks_cluster.prod_eks_cluster.arn
}

output "prod_backup_cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the Prod Backup cluster."
  value       = aws_eks_cluster.prod_backup_eks_cluster.arn
}

output "devstage_cluster_endpoint" {
  description = "The endpoint for the DevStage EKS Kubernetes API."
  value       = aws_eks_cluster.devstage_eks_cluster.endpoint
}

output "prod_cluster_endpoint" {
  description = "The endpoint for the Prod EKS Kubernetes API."
  value       = aws_eks_cluster.prod_eks_cluster.endpoint
}

output "prod_backup_cluster_endpoint" {
  description = "The endpoint for the Prod Backup EKS Kubernetes API."
  value       = aws_eks_cluster.prod_backup_eks_cluster.endpoint
}

output "devstage_node_group_public_id" {
  description = "DevStage Public Node Group ID"
  value       = aws_eks_node_group.devstage_eks_ng_public.id
}

output "prod_node_group_public_id" {
  description = "Prod Public Node Group ID"
  value       = aws_eks_node_group.prod_eks_ng_public.id
}

output "prod_backup_node_group_public_id" {
  description = "Prod Backup Public Node Group ID"
  value       = aws_eks_node_group.prod_backup_eks_ng_public.id
}

output "devstage_node_group_private_id" {
  description = "DevStage Private Node Group ID"
  value       = aws_eks_node_group.devstage_eks_ng_private.id
}

output "prod_node_group_private_id" {
  description = "Prod Private Node Group ID"
  value       = aws_eks_node_group.prod_eks_ng_private.id
}

output "prod_backup_node_group_private_id" {
  description = "Prod Backup Private Node Group ID"
  value       = aws_eks_node_group.prod_backup_eks_ng_private.id
}
output "prod_cluster_name" {
  value = var.cluster_config["prod"].cluster_name
}

output "prod_cluster_version" {
  value = var.cluster_config["prod"].cluster_version
}
