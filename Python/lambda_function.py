import boto3
def lambda_handler(event, context):
    # TODO implement
    
    client = boto3.client('sns')
    snsArn = 'arn:aws:sns:us-east-2:547354164162:ECR_Push'
    message = "New Image has been pushed to ECR"
    
    response = client.publish(
        TopicArn = snsArn,
        Message = message ,
        Subject='ECR'
    )