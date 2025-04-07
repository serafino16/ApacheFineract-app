resource "aws_iam_policy" "route53_policy" {
  name        = "route53-policy"
  description = "IAM policy to manage Route 53 and its resources."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "route53:CreateHostedZone",
          "route53:DeleteHostedZone",
          "route53:ListHostedZones",
          "route53:GetHostedZone",
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets",
          "route53:GetHealthCheck",
          "route53:CreateHealthCheck",
          "route53:DeleteHealthCheck",
          "route53:ListHealthChecks"
        ]
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role" "route53_role" {
  name = "route53-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "route53.amazonaws.com"  
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_instance_profile" "route53_instance_profile" {
  name = "route53-instance-profile"
  role = aws_iam_role.route53_role.name
}
