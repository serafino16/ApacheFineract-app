variable "cluster_config" {
  description = "Map of cluster configurations for each environment (devstage, prod, prod_backup)"
  type = map(object({
    cluster_name                        = string
    cluster_service_ipv4_cidr           = string
    cluster_version                     = string
    cluster_endpoint_private_access     = bool
    cluster_endpoint_public_access      = bool
    cluster_endpoint_public_access_cidrs = list(string)
    eks_oidc_root_ca_thumbprint         = string
  }))
}
variable "devstage_public_subnet_ids" {
  description = "Public subnets for devstage node groups"
  type        = list(string)
}

variable "devstage_private_subnet_ids" {
  description = "Private subnets for devstage node groups"
  type        = list(string)
}

variable "prod_public_subnet_ids" {
  description = "Public subnets for prod node groups"
  type        = list(string)
}

variable "prod_private_subnet_ids" {
  description = "Private subnets for prod node groups"
  type        = list(string)
}

variable "prod_backup_public_subnet_ids" {
  description = "Public subnets for prod_backup node groups"
  type        = list(string)
}

variable "prod_backup_private_subnet_ids" {
  description = "Private subnets for prod_backup node groups"
  type        = list(string)
}

variable "node_instance_types" {
  description = "Instance types for EKS nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 5
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_disk_size" {
  description = "Size of the disk for each node in GB"
  type        = number
  default     = 50
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "my-key-pair"
}

