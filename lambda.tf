resource "aws_iam_role" "lambda_role" {
  name = "terraform_aws_lambda_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
           "Service": "lambda.amazonaws.com"
        },
        "Effect":"Allow",
        "Sid": ""
       }
    ]
}
EOF
}

resource "aws_iam_policy" "iam_policy_for_lamda" {

    name         = "aws_iam_policy_for_terraform_aws_lambda_role"
    path         = "/"
    description  = "AWS IAM Policy for managing aws lambda role"
    policy       = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
    role        = aws_iam_role.lambda_role.name
    policy_arn  = aws_iam_policy.iam_policy_for_lamda.arn
}

data "archive_file" "zip_the_python_code" {
  type = "zip"
  source_dir = "${path.module}/Python/"
  output_path = "${path.module}/Python/Lambda.zip"
}

resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/Python/Lambda.zip"
  function_name = "Nilz-Lambda-Function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda.lambda_handler"
  runtime       = "python3.9"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}


resource "aws_lambda_function_event_invoke_config" "lambda-sns" {
  function_name = aws_lambda_function.terraform_lambda_func.function_name

  destination_config {
    on_success {
      destination = "arn:aws:sns:us-east-2:547354164162:ECR_Push"
    }
  }
}
