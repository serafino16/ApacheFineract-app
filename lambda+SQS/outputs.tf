output "user_creation_lambda_arns" {
  description = "ARNs of the user creation Lambda functions in each region"
  value = { for region in var.regions : region => aws_lambda_function.user_creation_lambda[region].arn }
}

output "loan_creation_lambda_arns" {
  description = "ARNs of the loan creation Lambda functions in each region"
  value = { for region in var.regions : region => aws_lambda_function.loan_creation_lambda[region].arn }
}

output "loan_repayment_lambda_arns" {
  description = "ARNs of the loan repayment Lambda functions in each region"
  value = { for region in var.regions : region => aws_lambda_function.loan_repayment_lambda[region].arn }
}

output "balance_threshold_alert_lambda_arns" {
  description = "ARNs of the balance threshold alert Lambda functions in each region"
  value = { for region in var.regions : region => aws_lambda_function.balance_threshold_alert_lambda[region].arn }
}

output "account_closure_lambda_arns" {
  description = "ARNs of the account closure Lambda functions in each region"
  value = { for region in var.regions : region => aws_lambda_function.account_closure_lambda[region].arn }
}

output "sqs_queue_urls" {
  description = "URLs of the SQS queues in each region"
  value = {
    "user_creation_queue" = { for region in var.regions : region => aws_sqs_queue.user_creation_queue[region].url },
    "loan_creation_queue" = { for region in var.regions : region => aws_sqs_queue.loan_creation_queue[region].url },
    "loan_repayment_queue" = { for region in var.regions : region => aws_sqs_queue.loan_repayment_queue[region].url },
    "balance_threshold_alert_queue" = { for region in var.regions : region => aws_sqs_queue.balance_threshold_alert_queue[region].url },
    "account_closure_queue" = { for region in var.regions : region => aws_sqs_queue.account_closure_queue[region].url }
  }
}

