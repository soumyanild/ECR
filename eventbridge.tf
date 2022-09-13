resource "aws_cloudwatch_event_rule" "ECR_Push" {
  name        = "capture-aws-sign-in"
  description = "Capture each AWS Console Sign In"

  event_pattern = <<PATTERN
  {
  "source": ["aws.ecr"],
  "detail-type": ["ECR Image Action"],
  "detail": {
  "action-type": ["PUSH"],
  "result": ["SUCCESS"],
  "repository-name": ["docker-jenkins"]
    }
  }
PATTERN
}

resource "aws_cloudwatch_event_target" "Lambda_for_ECR" {
  rule      = "${aws_cloudwatch_event_rule.ECR_Push.name}"
  target_id = "Lambda"
  arn       = "${aws_lambda_function.terraform_lambda_func.arn}"
}