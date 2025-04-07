
output "public_route53_zone_id" {
  description = "The ID of the public Route 53 hosted zone"
  value       = aws_route53_zone.public_zone.id
}


output "private_route53_zone_id" {
  description = "The ID of the private Route 53 hosted zone"
  value       = aws_route53_zone.private_zone.id
}


output "prod_health_check_id" {
  description = "The ID of the health check for the prod region"
  value       = aws_route53_health_check.prod_health_check.id
}


output "prodbackup_health_check_id" {
  description = "The ID of the health check for the prodbackup region"
  value       = aws_route53_health_check.prodbackup_health_check.id
}


output "prod_alb_dns_name" {
  description = "The DNS name of the Application Load Balancer (ALB) in the prod region"
  value       = aws_lb.prod_alb.dns_name
}


output "prod_nlb_dns_name" {
  description = "The DNS name of the Network Load Balancer (NLB) in the prod region"
  value       = aws_lb.prod_nlb.dns_name
}


output "prodbackup_alb_dns_name" {
  description = "The DNS name of the Application Load Balancer (ALB) in the prodbackup region"
  value       = aws_lb.prodbackup_alb.dns_name
}


output "prodbackup_nlb_dns_name" {
  description = "The DNS name of the Network Load Balancer (NLB) in the prodbackup region"
  value       = aws_lb.prodbackup_nlb.dns_name
}


output "prod_alb_failover_record" {
  description = "The DNS record for the ALB in the prod region (Primary failover)"
  value       = aws_route53_record.prod_alb_failover_record.fqdn
}


output "prod_nlb_failover_record" {
  description = "The DNS record for the NLB in the prod region (Primary failover)"
  value       = aws_route53_record.prod_nlb_failover_record.fqdn
}


output "prodbackup_alb_failover_record" {
  description = "The DNS record for the ALB in the prodbackup region (Secondary failover)"
  value       = aws_route53_record.prodbackup_alb_failover_record.fqdn
}


output "prodbackup_nlb_failover_record" {
  description = "The DNS record for the NLB in the prodbackup region (Secondary failover)"
  value       = aws_route53_record.prodbackup_nlb_failover_record.fqdn
}


output "vpc_id" {
  description = "The ID of the VPC used for the setup"
  value       = aws_vpc.main.id
}


output "prod_subnet_ids" {
  description = "The IDs of the subnets in the prod region"
  value       = [aws_subnet.subnet_1]
}