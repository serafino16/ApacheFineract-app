
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

provider "aws" {
  alias  = "eu-central-1"
  region = "eu-central-1"
}


variable "waf_environments" {
  type = map(object({
    region   = string
    alb_arn  = string
    enable   = bool
  }))
  default = {
    devstage = { region = "us-east-1", alb_arn = "arn:aws:elasticloadbalancing:us-east-1:account-id:loadbalancer/app/devstage-alb-id", enable = true }
    prod     = { region = "us-west-1", alb_arn = "arn:aws:elasticloadbalancing:us-west-1:account-id:loadbalancer/app/prod-alb-id", enable = true }
    prodbackup = { region = "eu-central-1", alb_arn = "arn:aws:elasticloadbalancing:eu-central-1:account-id:loadbalancer/app/prodbackup-alb-id", enable = true }
  }
}


variable "region_providers" {
  type = map(string)
  default = {
    us-east-1    = "aws.us-east-1"
    us-west-1    = "aws.us-west-1"
    eu-central-1 = "aws.eu-central-1"
  }
}
