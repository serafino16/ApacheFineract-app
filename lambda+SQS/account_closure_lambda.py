import json

def lambda_handler(event, context):
    for record in event['Records']:
        
        message_body = json.loads(record['body'])
        
        
        account_id = message_body.get('account_id')
        closure_reason = message_body.get('closure_reason')
        
        
        print(f"Account closed. ID: {account_id}, Reason: {closure_reason}")
        
    return {
        'statusCode': 200,
        'body': json.dumps('Account closure event processed successfully')
    }
