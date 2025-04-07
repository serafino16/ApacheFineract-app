import json

def lambda_handler(event, context):
    for record in event['Records']:
        
        message_body = json.loads(record['body'])
        
        
        account_id = message_body.get('account_id')
        balance = message_body.get('balance')
        
        
        print(f"Account balance alert. Account ID: {account_id}, Balance: {balance}")
        
    return {
        'statusCode': 200,
        'body': json.dumps('Balance threshold alert processed successfully')
    }
