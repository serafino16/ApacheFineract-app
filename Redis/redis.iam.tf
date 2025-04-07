resource "aws_iam_policy" "allow_redis_access" {
  name        = "AllowRedisAccess"
  description = "Policy to allow EC2 instances to access Redis clusters in multiple regions"
  policy      = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticache:DescribeCacheClusters",
          "elasticache:DescribeReplicationGroups",
          "elasticache:Connect"
        ],
        "Resource" : "*"
      }
    ]
  })
}
resource "aws_iam_policy" "allow_redis_snapshot_management" {
  name        = "AllowRedisSnapshotManagement"
  description = "Policy to allow management of Redis snapshots for backup purposes"
  policy      = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticache:CreateSnapshot",
          "elasticache:DeleteSnapshot",
          "elasticache:DescribeSnapshots",
          "elasticache:CopySnapshot"
        ],
        "Resource" : "*"
      }
    ]
  })
}
resource "aws_iam_policy" "allow_redis_global_datastore_management" {
  name        = "AllowRedisGlobalDatastoreManagement"
  description = "Policy to allow management of Redis global datastores for cross-region replication"
  policy      = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "elasticache:CreateGlobalReplicationGroup",
          "elasticache:DescribeGlobalReplicationGroups",
          "elasticache:DeleteGlobalReplicationGroup",
          "elasticache:FailoverGlobalReplicationGroup"
        ],
        "Resource" : "*"
      }
    ]
  })
}
