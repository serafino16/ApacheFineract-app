
output "efs_helm_metadata" {
  description = "Metadata Block outlining status of the deployed release."
  value = helm_release.efs_csi_driver.metadata
}

output "efs_file_system_dns_names" {
  description = "EFS File System DNS Names for each region"
  value = { for region, fs in aws_efs_file_system.efs_file_system : region => fs.dns_name }
}

output "efs_mount_target_dns_names" {
  description = "EFS Mount Target DNS Names for each region"
  value = { for region, mt in aws_efs_mount_target.efs_mount_target : region => mt[*].mount_target_dns_name }
}

output "efs_file_system_ids" {
  description = "EFS File System IDs per region"
  value       = { for region, efs in aws_efs_file_system.efs_file_system : region => efs.id }
}

output "efs_mount_target_ids" {
  description = "EFS Mount Target IDs per region"
  value       = { for region, target in aws_efs_mount_target.efs_mount_target : region => target.*.id }
}

output "efs_replication_configuration" {
  description = "EFS Replication Configuration per region"
  value       = { for region, replication in aws_efs_replication_configuration.efs_replication : region => replication.id }
}

output "efs_security_group_ids" {
  description = "EFS Security Group IDs per region"
  value       = { for region, sg in aws_security_group.efs_allow_access : region => sg.id }
}