
resource "aws_iam_role" "lambda_user_creation_role" {
  for_each = toset(var.regions)

  name = "lambda-user-creation-role-${each.value}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  
}


resource "aws_iam_role" "lambda_loan_creation_role" {
  for_each = toset(var.regions)

  name = "lambda-loan-creation-role-${each.value}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  
}


resource "aws_iam_role" "lambda_loan_repayment_role" {
  for_each = toset(var.regions)

  name = "lambda-loan-repayment-role-${each.value}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

 
}


resource "aws_iam_role" "lambda_balance_threshold_alert_role" {
  for_each = toset(var.regions)

  name = "lambda-balance-threshold-alert-role-${each.value}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  
}


resource "aws_iam_role" "lambda_account_closure_role" {
  for_each = toset(var.regions)

  name = "lambda-account-closure-role-${each.value}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  
}


resource "aws_iam_policy" "lambda_sqs_policy" {
  for_each = toset(var.regions)

  name        = "lambda-sqs-policy-${each.value}"
  description = "IAM policy to allow Lambda functions to interact with SQS in each region"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"]
        Effect   = "Allow"
        Resource = [
          aws_sqs_queue.user_creation_queue[each.value].arn,
          aws_sqs_queue.loan_creation_queue[each.value].arn,
          aws_sqs_queue.loan_repayment_queue[each.value].arn,
          aws_sqs_queue.balance_threshold_alert_queue[each.value].arn,
          aws_sqs_queue.account_closure_queue[each.value].arn
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_user_creation_policy_attachment" {
  for_each = toset(var.regions)

  policy_arn = aws_iam_policy.lambda_sqs_policy[each.value].arn
  role       = aws_iam_role.lambda_user_creation_role[each.value].name
}

resource "aws_iam_role_policy_attachment" "lambda_loan_creation_policy_attachment" {
  for_each = toset(var.regions)

  policy_arn = aws_iam_policy.lambda_sqs_policy[each.value].arn
  role       = aws_iam_role.lambda_loan_creation_role[each.value].name
}

resource "aws_iam_role_policy_attachment" "lambda_loan_repayment_policy_attachment" {
  for_each = toset(var.regions)

  policy_arn = aws_iam_policy.lambda_sqs_policy[each.value].arn
  role       = aws_iam_role.lambda_loan_repayment_role[each.value].name
}

resource "aws_iam_role_policy_attachment" "lambda_balance_threshold_alert_policy_attachment" {
  for_each = toset(var.regions)

  policy_arn = aws_iam_policy.lambda_sqs_policy[each.value].arn
  role       = aws_iam_role.lambda_balance_threshold_alert_role[each.value].name
}

resource "aws_iam_role_policy_attachment" "lambda_account_closure_policy_attachment" {
  for_each = toset(var.regions)

  policy_arn = aws_iam_policy.lambda_sqs_policy[each.value].arn
  role       = aws_iam_role.lambda_account_closure_role[each.value].name
}

