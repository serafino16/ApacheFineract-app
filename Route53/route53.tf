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
  fqdn              = "prod.example.com"  n
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


resource "aws_lb" "prod_alb" {
  name               = "prod-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.sg.id]
  subnets           = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  enable_deletion_protection = false

  tags = {
    Name = "prod-alb"
  }
}


resource "aws_lb" "prod_nlb" {
  name               = "prod-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups   = [aws_security_group.sg.id]
  subnets           = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  enable_deletion_protection = false

  tags = {
    Name = "prod-nlb"
  }
}


resource "aws_lb" "prodbackup_alb" {
  name               = "prodbackup-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.sg.id]
  subnets           = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  enable_deletion_protection = false

  tags = {
    Name = "prodbackup-alb"
  }
}


resource "aws_lb" "prodbackup_nlb" {
  name               = "prodbackup-nlb"
  internal           = false
  load_balancer_type = "network"
  security_groups   = [aws_security_group.sg.id]
  subnets           = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  enable_deletion_protection = false

  tags = {
    Name = "prodbackup-nlb"
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
