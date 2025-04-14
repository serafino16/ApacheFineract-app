
provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

provider "aws" {
  alias  = "us-west-3"
  region = "us-west-3"
}


variable "waf_environments" {
  type = map(object({
    region   = string
    alb_arn  = string
    enable   = bool
  }))
  default = {
    devstage = { region = "us-west-3", alb_arn = "arn:aws:elasticloadbalancing:us-east-1:account-id:loadbalancer/app/devstage-alb-id", enable = true }
    prod     = { region = "us-west-1", alb_arn = "arn:aws:elasticloadbalancing:us-west-1:account-id:loadbalancer/app/prod-alb-id", enable = true }
    prodbackup = { region = "us-west-2", alb_arn = "arn:aws:elasticloadbalancing:eu-central-1:account-id:loadbalancer/app/prodbackup-alb-id", enable = true }
  }
}


variable "region_providers" {
  type = map(string)
  default = {
    us-east-1    = "aws.us-west-3"
    us-west-1    = "aws.us-west-1"
    eu-central-1 = "aws.us-west-2"
  }
}
