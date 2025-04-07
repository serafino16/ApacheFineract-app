

provider "aws" {
  alias  = "prod"
  region = var.prod_region
}
provider "aws" {
  alias  = "prodbackup"
  region = var.prod_backup_region
}

resource "aws_vpc" "vpc_prodbackup" {
  provider = aws.dev
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}




resource "aws_elasticache_subnet_group" "redis_subnet_group_prodbackup" {
  provider = aws.dev
  name     = "redis-subnet-group-dev"
  subnet_ids = [
    "subnet-"10.0.151.0/24", "10.0.152.0/24"", 
    "subnet-"10.0.151.0/24", "10.1.152.0/24""  
  ]
  tags = {
    Name = "Redis Subnet Group in Dev"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet_group_prodbackup" {
  provider = aws.prod
  name     = "redis-subnet-group-prod"
  subnet_ids = [
    "subnet-"10.0.151.0/24", "10.2.152.0/24"", 
    "subnet-"10.0.151.0/24", "10.3.152.0/24""  
  ]
  tags = {
    Name = "Redis Subnet Group in Prod"
  }
}


resource "aws_security_group" "redis_sg_dev" {
  provider = aws.dev
  name        = "redis-security-group-dev"
  description = "Allow inbound traffic to Redis in Dev region"
  vpc_id      = aws_vpc.vpc_dev.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "redis_sg_prod" {
  provider = aws.prod
  name        = "redis-security-group-prod"
  description = "Allow inbound traffic to Redis in Prod region"
  vpc_id      = aws_vpc.vpc_prod.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_elasticache_replication_group" "redis_cluster_dev" {
  provider = aws.dev
  replication_group_id = "redis-cluster-dev"
  replication_group_description = "Multi-AZ Redis Cluster in Dev Region"
  engine = "redis"
  engine_version = "6.x"
  node_type = "cache.m5.large"
  number_of_cache_clusters = 3
  automatic_failover_enabled = true
  preferred_cache_cluster_aazs = ["az1", "az2", "az3"]
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group_dev.name
  security_group_ids = [aws_security_group.redis_sg_dev.id]
  snapshot_retention_limit = 7  
  snapshot_window = "06:00-07:00"  

  tags = {
    Name = "Dev Redis Cluster"
    Environment = "dev"
  }
}


resource "aws_elasticache_replication_group" "redis_cluster_prod" {
  provider = aws.prod
  replication_group_id = "redis-cluster-prod"
  replication_group_description = "Multi-AZ Redis Cluster in Prod Region"
  engine = "redis"
  engine_version = "6.x"
  node_type = "cache.m5.large"
  number_of_cache_clusters = 3
  automatic_failover_enabled = true
  preferred_cache_cluster_aazs = ["az1", "az2", "az3"]
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group_prod.name
  security_group_ids = [aws_security_group.redis_sg_prod.id]
  snapshot_retention_limit = 7  
  snapshot_window = "06:00-07:00"  

  tags = {
    Name = "Prod Redis Cluster"
    Environment = "prod"
  }
}


resource "aws_elasticache_replication_group" "redis_cluster_backup_prod" {
  provider = aws.prod
  replication_group_id = "redis-cluster-backup-prod"
  replication_group_description = "Backup Redis Cluster in Prod Region"
  engine = "redis"
  engine_version = "6.x"
  node_type = "cache.m5.large"
  number_of_cache_clusters = 3
  automatic_failover_enabled = true
  preferred_cache_cluster_aazs = ["az1", "az2", "az3"]
  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group_prod.name
  security_group_ids = [aws_security_group.redis_sg_prod.id]
  snapshot_retention_limit = 7  
  snapshot_window = "06:00-07:00"  


  global_datastore_name = "redis-global-datastore"
  cache_node_type = "cache.m5.large"
  engine_version = "6.x"
  snapshot_window = "06:00-07:00"

  tags = {
    Name = "Backup Prod Redis Cluster"
    Environment = "backup_prod"
  }
}
