
resource "aws_lambda_function" "loan_creation_lambda" {
  for_each = toset(var.regions)

  function_name = "loan-creation-lambda-${each.value}"

  role = aws_iam_role.lambda_loan_creation_role[each.value].arn

  handler = "index.lambda_handler"
  runtime = "python3.8"

  
  filename         = "path_to_loan_creation_lambda.zip"
  source_code_hash = filebase64sha256("path_to_loan_creation_lambda.zip")

  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.loan_creation_queue[each.value].url
    }
  }
}


resource "aws_lambda_function" "loan_repayment_lambda" {
  for_each = toset(var.regions)

  function_name = "loan-repayment-lambda-${each.value}"

  role = aws_iam_role.lambda_loan_repayment_role[each.value].arn

  handler = "index.lambda_handler"
  runtime = "python3.8"

  
  filename         = "path_to_loan_repayment_lambda.zip"
  source_code_hash = filebase64sha256("path_to_loan_repayment_lambda.zip")

  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.loan_repayment_queue[each.value].url
    }
  }
}


resource "aws_lambda_function" "balance_threshold_alert_lambda" {
  for_each = toset(var.regions)

  function_name = "balance-threshold-alert-lambda-${each.value}"

  role = aws_iam_role.lambda_balance_threshold_alert_role[each.value].arn

  handler = "index.lambda_handler"
  runtime = "python3.8"

  
  filename         = "path_to_balance_threshold_alert_lambda.zip"
  source_code_hash = filebase64sha256("path_to_balance_threshold_alert_lambda.zip")

  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.balance_threshold_alert_queue[each.value].url
    }
  }
}


resource "aws_lambda_function" "account_closure_lambda" {
  for_each = toset(var.regions)

  function_name = "account-closure-lambda-${each.value}"

  role = aws_iam_role.lambda_account_closure_role[each.value].arn

  handler = "index.lambda_handler"
  runtime = "python3.8"

  
  filename         = "path_to_account_closure_lambda.zip"
  source_code_hash = filebase64sha256("path_to_account_closure_lambda.zip")

  environment {
    variables = {
      SQS_QUEUE_URL = aws_sqs_queue.account_closure_queue[each.value].url
    }
  }
}