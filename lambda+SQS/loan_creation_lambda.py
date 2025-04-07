import json

def lambda_handler(event, context):
    for record in event['Records']:
        
        message_body = json.loads(record['body'])
        
        
        loan_id = message_body.get('loan_id')
        loan_amount = message_body.get('loan_amount')
        
        
        print(f"New loan created. ID: {loan_id}, Amount: {loan_amount}")
        
    return {
        'statusCode': 200,
        'body': json.dumps('Loan creation event processed successfully')
    }
