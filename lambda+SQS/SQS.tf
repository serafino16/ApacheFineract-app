provider "aws" {
  region = var.regions[0]
}


resource "aws_sqs_queue" "user_creation_queue" {
  for_each = toset(var.regions)

  name              = "user-creation-queue-${each.value}"
  region            = each.value
  delay_seconds     = 0
  message_retention_seconds = 86400
}

resource "aws_sqs_queue" "loan_creation_queue" {
  for_each = toset(var.regions)

  name              = "loan-creation-queue-${each.value}"
  region            = each.value
  delay_seconds     = 0
  message_retention_seconds = 86400
}

resource "aws_sqs_queue" "loan_repayment_queue" {
  for_each = toset(var.regions)

  name              = "loan-repayment-queue-${each.value}"
  region            = each.value
  delay_seconds     = 0
  message_retention_seconds = 86400
}

resource "aws_sqs_queue" "balance_threshold_alert_queue" {
  for_each = toset(var.regions)

  name              = "balance-threshold-alert-queue-${each.value}"
  region            = each.value
  delay_seconds     = 0
  message_retention_seconds = 86400
}

resource "aws_sqs_queue" "account_closure_queue" {
  for_each = toset(var.regions)

  name              = "account-closure-queue-${each.value}"
  region            = each.value
  delay_seconds     = 0
  message_retention_seconds = 86400
}
