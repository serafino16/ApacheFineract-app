


region_providers = {
  us-east-1    = "aws.us-east-1"
  us-west-1    = "aws.us-west-1"
  eu-central-1 = "aws.eu-central-1"
}


waf_environments = {
  devstage = {
    region  = "us-east-1"
    alb_arn = "arn:aws:elasticloadbalancing:us-east-1:${account_id}:loadbalancer/app/devstage-alb-id"
    enable  = true
  }
  prod = {
    region  = "us-west-1"
    alb_arn = "arn:aws:elasticloadbalancing:us-west-1:${account_id}:loadbalancer/app/prod-alb-id"
    enable  = true
  }
  prodbackup = {
    region  = "eu-central-1"
    alb_arn = "arn:aws:elasticloadbalancing:eu-central-1:${account_id}:loadbalancer/app/prodbackup-alb-id"
    enable  = true
  }
}


waf_default_action = "ALLOW"


alb_security_group_cidrs = ["0.0.0.0/0"]


waf_rules = {
  sql_injection = {
    enable = true
    priority = 1
  }
  xss_protection = {
    enable = true
    priority = 2
  }
  ip_blocking = {
    enable = false
    priority = 3
  }
}
