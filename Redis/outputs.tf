
output "redis_dev_endpoint" {
  description = "Dev Redis Cluster Endpoint"
  value = aws_elasticache_replication_group.redis_cluster_dev.primary_endpoint
}

output "redis_prod_endpoint" {
  description = "Prod Redis Cluster Endpoint"
  value = aws_elasticache_replication_group.redis_cluster_prod.primary_endpoint
}

output "redis_backup_prod_endpoint" {
  description = "Backup Prod Redis Cluster Endpoint"
  value = aws_elasticache_replication_group.redis_cluster_backup_prod.primary_endpoint
}