
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "eu-west-1"  
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "prodbackup"
}

variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "eu-west-2"  
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "prod"
}
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "eu-west-3"  
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "devstage"
}
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "SAP"
}
