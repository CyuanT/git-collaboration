import json

def lambda_handler(event, context):
    incoming_msg = "Good Morning, Afternoon & Evening from  Azmi, Shafiq, and Tan Yuan"
    return {
        'statusCode': 200,
        'body': json.dumps(incoming_msg)
    }
