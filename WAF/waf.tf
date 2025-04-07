
resource "aws_waf_web_acl" "waf" {
  for_each    = { for k, v in var.waf_environments : k => v if v.enable }
  provider    = aws.region_providers[each.value.region]
  name        = "waf-${each.key}"
  metric_name = "${each.key}_WAF_Metric"

  default_action {
    type = "ALLOW"
  }

  rule {
    action {
      type = "BLOCK"
    }
    priority = 1
    rule_id  = aws_waf_rule.sqli[each.key].id
    type     = "REGULAR"
  }

  rule {
    action {
      type = "BLOCK"
    }
    priority = 2
    rule_id  = aws_waf_rule.xss[each.key].id
    type     = "REGULAR"
  }
}


resource "aws_waf_rule" "sqli" {
  for_each    = { for k, v in var.waf_environments : k => v if v.enable }
  provider    = aws.region_providers[each.value.region]
  name        = "SQLiRule-${each.key}"
  metric_name = "SQLiMetric_${each.key}"

  predicates {
    data_id = aws_waf_sql_injection_match_set.sqli_match[each.key].id
    negated = false
    type    = "SqlInjectionMatch"
  }
}

resource "aws_waf_sql_injection_match_set" "sqli_match" {
  for_each = { for k, v in var.waf_environments : k => v if v.enable }
  provider = aws.region_providers[each.value.region]
  name     = "SQLInjectionMatchSet_${each.key}"

  sql_injection_match_tuples {
    field_to_match {
      type = "QUERY_STRING"
    }
    text_transformation = "URL_DECODE"
  }
}

resource "aws_wafregional_web_acl_association" "waf_association" {
  for_each     = { for k, v in var.waf_environments : k => v if v.enable }
  provider     = aws.region_providers[each.value.region]
  resource_arn = each.value.alb_arn
  web_acl_id   = aws_waf_web_acl.waf[each.key].id
}
