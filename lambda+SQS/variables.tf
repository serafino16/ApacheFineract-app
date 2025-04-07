
variable "regions" {
  description = "List of AWS regions for multi-region setup"
  type        = list(string)
  default     = ["eu-west-1", "eu-west-2", "eu-west-3"]
}


variable "lambda_runtime" {
  description = "Lambda runtime version"
  type        = string
  default     = "python3.8"
}


variable "sns_topic_arn" {
  description = "SNS Topic ARN for Lambda notifications"
  type        = string
}


variable "user_creation_queue_urls" {
  description = "List of SQS URLs for user creation events by region"
  type        = map(string)
}

variable "loan_creation_queue_urls" {
  description = "List of SQS URLs for loan creation events by region"
  type        = map(string)
}

variable "loan_repayment_queue_urls" {
  description = "List of SQS URLs for loan repayment events by region"
  type        = map(string)
}

variable "balance_threshold_alert_queue_urls" {
  description = "List of SQS URLs for balance threshold alert events by region"
  type        = map(string)
}

variable "account_closure_queue_urls" {
  description = "List of SQS URLs for account closure events by region"
  type        = map(string)
}

