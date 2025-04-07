output "rds_instance_endpoints" {
  description = "RDS Instance Endpoints"
  value       = { for region, instance in aws_db_instance.rds_instance : region => instance.endpoint }
}

output "rds_read_replica_endpoints" {
  description = "Read Replica Endpoints"
  value       = { for region, replica in aws_db_instance.rds_read_replica : region => replica.endpoint }
}

output "rds_kms_keys" {
  description = "KMS Keys used for RDS encryption"
  value       = { for region, key in aws_kms_key.rds_key : region => key.arn }
}
