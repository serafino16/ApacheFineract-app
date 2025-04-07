import json

def lambda_handler(event, context):
    for record in event['Records']:
        
        message_body = json.loads(record['body'])
        
        
        repayment_id = message_body.get('repayment_id')
        repayment_amount = message_body.get('repayment_amount')
        
        
        print(f"Loan repayment processed. ID: {repayment_id}, Amount: {repayment_amount}")
        
    return {
        'statusCode': 200,
        'body': json.dumps('Loan repayment event processed successfully')
    }
