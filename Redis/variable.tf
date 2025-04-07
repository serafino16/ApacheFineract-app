variable "dev_region" {
  description = "AWS region for development environment"
  type        = string
  default     = "eu-west-3" 
}

variable "prod_region" {
  description = "AWS region for production environment"
  type        = string
  default     = "eu-west-2"  
}

variable "prod_backup_region" {
  description = "AWS region for production backup"
  type        = string
  default     = "eu-west-1"  
}
