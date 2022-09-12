resource "aws_sns_topic" "snstopic" {
    name = "ECR_Push"
}

resource "aws_sns_topic_subscription" "snstopicsubscription" {
    topic_arn = aws_sns_topic.snstopic.arn
    protocol  = "email"
    endpoint  = "soumyanild@gmail.com"
    endpoint_auto_confirms = true
}

