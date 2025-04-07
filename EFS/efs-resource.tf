
variable "regions" {
  description = "List of AWS regions for multi-region deployment"
  type        = list(string)
  default     = ["eu-west-1", "eu-west-2", "eu-west-3"]
}

variable "efs_replication" {
  description = "Enable EFS replication (true/false)"
  type        = bool
  default     = true
}

resource "aws_security_group" "efs_allow_access" {
  for_each    = toset(var.regions)
  name        = "efs-allow-nfs-from-eks-vpc-${each.key}"
  description = "Allow Inbound NFS Traffic from VPC CIDR"
  vpc_id      = data.terraform_remote_state.eks[each.key].outputs.vpc_id

  ingress {
    description = "Allow Inbound NFS Traffic from EKS VPC CIDR to EFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.eks[each.key].outputs.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_nfs_from_eks_vpc-${each.key}"
  }
}

resource "aws_efs_file_system" "efs_file_system" {
  for_each       = toset(var.regions)
  creation_token = "efs-spree-${each.key}"

  tags = {
    Name = "efs-spree-${each.key}"
  }
}

resource "aws_efs_mount_target" "efs_mount_target" {
  for_each       = toset(var.regions)
  count          = 2
  file_system_id = aws_efs_file_system.efs_file_system[each.key].id
  subnet_id      = data.terraform_remote_state.eks[each.key].outputs.private_subnets[count.index]
  security_groups = [aws_security_group.efs_allow_access[each.key].id]
}

resource "aws_efs_replication_configuration" "efs_replica" {
  count = var.efs_replication ? 1 : 0

  source_file_system_id = aws_efs_file_system.efs_file_system["eu-west-1"].id  

  destination {
    region             = "us-west-2"
    kms_key_id         = null  
  }

  destination {
    region             = "eu-west-3"
    kms_key_id         = null  
  }
}


