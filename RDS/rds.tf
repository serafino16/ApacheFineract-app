variable "regions" {
  description = "List of AWS regions for RDS deployment"
  type        = list(string)
  default     = ["eu-west-2", "eu-west-3", "eu-west-1"]
}
resource "aws_kms_key" "rds_key" {
  for_each    = toset(var.regions)
  description = "RDS KMS key for encryption in ${each.key}"
}
resource "aws_security_group" "rds_sg" {
  for_each    = toset(var.regions)
  name        = "rds-security-group-${each.key}"
  description = "Security group for RDS in ${each.key}"
  vpc_id      = data.terraform_remote_state.eks[each.key].outputs.vpc_id

  ingress {
    from_port   = 3306 
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.eks[each.key].outputs.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_subnet_group" "rds_subnet_group" {
  for_each   = toset(var.regions)
  name       = "rds-subnet-group-${each.key}"
  subnet_ids = data.terraform_remote_state.eks[each.key].outputs.private_subnets

  tags = {
    Name = "RDS Subnet Group - ${each.key}"
  }
}
resource "aws_db_parameter_group" "rds_parameter_group" {
  for_each    = toset(var.regions)
  name        = "custom-rds-parameter-group-${each.key}"
  family      = "postgres14"  
  description = "Custom parameter group for RDS in ${each.key}"

  parameter {
    name  = "max_connections"
    value = "500"
  }

  parameter {
    name  = "query_cache_size"
    value = "256MB"
  }
}
resource "aws_db_instance" "rds_instance" {
  for_each                = toset(var.regions)
  identifier              = "rds-spree-${each.key}"
  engine                  = "postgres"
  engine_version          = "14.4"
  instance_class          = "db.m5.large"
  allocated_storage       = 100
  max_allocated_storage   = 200
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.rds_key[each.key].key_id
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group[each.key].name
  vpc_security_group_ids  = [aws_security_group.rds_sg[each.key].id]
  multi_az                = true
  publicly_accessible     = false
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  preferred_maintenance_window = "sun:05:00-sun:06:00"
  auto_minor_version_upgrade   = true
  db_parameter_group_name      = aws_db_parameter_group.rds_parameter_group[each.key].name
  iam_database_authentication_enabled = true

  tags = {
    Name = "RDS Spree ${each.key}"
    Environment = "production"
  }
}
resource "aws_db_instance" "rds_read_replica" {
  for_each           = toset(var.regions)
  replicate_source_db = aws_db_instance.rds_instance["eu-west-3"].id  
  instance_class     = "db.m5.large"
  availability_zone  = "${each.key}a"
  skip_final_snapshot = true

  tags = {
    Name = "rds-replica-${each.key}"
  }
}


