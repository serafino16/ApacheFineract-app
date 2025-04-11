provider "aws" {
  region = "us-east-1"  
}

resource "aws_route53_zone" "public_zone" {
  name = "example.com"  

  tags = {
    Name = "public-zone"
  }
}

resource "aws_route53_health_check" "prod_health_check" {
  fqdn              = "prod.example.com"
  type              = "HTTP"
  resource_path     = "/health"
  failure_threshold = 3
  request_interval  = 30
  port              = 80
  protocol          = "HTTP"

  tags = {
    Name = "prod-health-check"
  }
}

resource "aws_route53_health_check" "prodbackup_health_check" {
  fqdn              = "prodbackup.example.com"
  type              = "HTTP"
  resource_path     = "/health"
  failure_threshold = 3
  request_interval  = 30
  port              = 80
  protocol          = "HTTP"

  tags = {
    Name = "prodbackup-health-check"
  }
}

resource "aws_route53_record" "prod_alb_failover_record" {
  zone_id = aws_route53_zone.public_zone.id
  name    = "frontend.example.com"  
  type    = "A"
  ttl     = 60
  failover_routing_policy {
    type               = "PRIMARY"
    health_check_id    = aws_route53_health_check.prod_health_check.id
  }
  alias {
    name                   = aws_lb.prod_alb.dns_name
    zone_id                = aws_lb.prod_alb.zone_id
    evaluate_target_health = true
  }

  tags = {
    Name = "prod-alb-failover-record"
  }
}

resource "aws_route53_record" "prod_nlb_failover_record" {
  zone_id = aws_route53_zone.public_zone.id
  name    = "backend.example.com"  
  type    = "A"
  ttl     = 60
  failover_routing_policy {
    type               = "PRIMARY"
    health_check_id    = aws_route53_health_check.prod_health_check.id
  }
  alias {
    name                   = aws_lb.prod_nlb.dns_name
    zone_id                = aws_lb.prod_nlb.zone_id
    evaluate_target_health = true
  }

  tags = {
    Name = "prod-nlb-failover-record"
  }
}

resource "aws_route53_record" "prodbackup_alb_failover_record" {
  zone_id = aws_route53_zone.public_zone.id
  name    = "frontend.example.com"  
  type    = "A"
  ttl     = 60
  failover_routing_policy {
    type               = "SECONDARY"
    health_check_id    = aws_route53_health_check.prodbackup_health_check.id
  }
  alias {
    name                   = aws_lb.prodbackup_alb.dns_name
    zone_id                = aws_lb.prodbackup_alb.zone_id
    evaluate_target_health = true
  }

  tags = {
    Name = "prodbackup-alb-failover-record"
  }
}

resource "aws_route53_record" "prodbackup_nlb_failover_record" {
  zone_id = aws_route53_zone.public_zone.id
  name    = "backend.example.com"  
  type    = "A"
  ttl     = 60
  failover_routing_policy {
    type               = "SECONDARY"
    health_check_id    = aws_route53_health_check.prodbackup_health_check.id
  }
  alias {
    name                   = aws_lb.prodbackup_nlb.dns_name
    zone_id                = aws_lb.prodbackup_nlb.zone_id
    evaluate_target_health = true
  }

  tags = {
    Name = "prodbackup-nlb-failover-record"
  }
}

resource "aws_route53_record" "prod_failover_record" {
  zone_id = data.aws_route53_zone.main.id
  name    = "prod.example.com"
  type    = "A"
  ttl     = 60
  failover_routing_policy {
    primary {
      endpoint {
        dns_name = aws_db_instance.rds_instance["eu-west-1"].endpoint
        evaluate_target_health = true
      }
    }
    secondary {
      endpoint {
        dns_name = aws_db_instance.rds_read_replica["eu-west-2"].endpoint
        evaluate_target_health = true
      }
    }
  }
}

