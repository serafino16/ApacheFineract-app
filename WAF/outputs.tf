
output "waf_ids" {
  value = { for k, v in aws_waf_web_acl.waf : k => v.id }
  description = "WAF WebACL IDs for each environment"
}


output "waf_associations" {
  value = { for k, v in aws_wafregional_web_acl_association.waf_association : k => v.resource_arn }
  description = "WAF WebACL associations with ALBs"
}


output "waf_regions" {
  value = { for k, v in var.waf_environments : k => v.region if v.enable }
  description = "Regions where WAF is deployed"
}
