variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "spree-vpc"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = map(string)
  default = {
    "eu-west-3" = "10.0.0.0/16"
    "eu-west-2" = "10.1.0.0/16"
    "eu-west-1" = "10.2.0.0/16"
  }
}

variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type        = map(list(string))
  default = {
    "eu-west-3" = ["eu-west-3a", "eu-west-3b"]
    "eu-west-2" = ["eu-west-2a", "eu-west-2b"]
    "eu-west-1" = ["eu-west-1a", "eu-west-1b"]
  }
}

variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type        = map(list(string))
  default = {
    "eu-west-3" = ["10.0.101.0/24", "10.0.102.0/24"]
    "eu-west-2" = ["10.1.101.0/24", "10.1.102.0/24"]
    "eu-west-1" = ["10.2.101.0/24", "10.2.102.0/24"]
  }
}

variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type        = map(list(string))
  default = {
    "eu-west-3" = ["10.0.1.0/24", "10.0.2.0/24"]
    "eu-west-2" = ["10.1.1.0/24", "10.1.2.0/24"]
    "eu-west-1" = ["10.2.1.0/24", "10.2.2.0/24"]
  }
}

variable "vpc_database_subnets" {
  description = "VPC Database Subnets"
  type        = map(list(string))
  default = {
    "eu-west-3" = ["10.0.151.0/24", "10.0.152.0/24"]
    "eu-west-2" = ["10.1.151.0/24", "10.1.152.0/24"]
    "eu-west-1" = ["10.2.151.0/24", "10.2.152.0/24"]
  }
}

variable "vpc_create_database_subnet_group" {
  description = "VPC Create Database Subnet Group"
  type        = map(bool)
  default = {
    "eu-west-1" = true
    "eu-west-2" = true
    "eu-west-3" = true
  }
}

variable "vpc_create_database_subnet_route_table" {
  description = "VPC Create Database Subnet Route Table"
  type        = map(bool)
  default = {
    "eu-west-1" = true
    "eu-west-2" = true
    "eu-west-3" = true
  }
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type        = map(bool)
  default = {
    "eu-west-1" = true
    "eu-west-2" = true
    "eu-west-3" = true
  }
}


variable "vpc_ids" {
  description = "Map of VPC IDs for different environments"
  type        = map(string)
  default = {
    "devstage"     = "vpc-0a12b345c678d9e0f"  
    "prod"         = "vpc-1a23b456c789d0e1f"  
    "prod_backup"  = "vpc-0a12b345c678d9e0f"  
  }
}

variable "tgw_attachment_ids" {
  description = "Map of Transit Gateway attachment IDs for different environments"
  type        = map(string)
  default = {
    "devstage"     = "tgw-01234abcd5678efgh"  
    "prod"         = "tgw-1a234bcd56789fgh"  
    "prod_backup"  = "tgw-2b345cde67890hij"  
  }
}
