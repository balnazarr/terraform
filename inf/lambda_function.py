import json
import boto3
import urllib

print("loading function")

s3 = boto3.client('s3')

def lambda_handler(event, context):
    src_bucket = event['Records'][0]['s3']['bucket']['name']
    dest_bucket = 'danny-target-825'
    
    key = urllib.unquote_plus(event['Records'][0]['s3']['object']['key'])
    src = {'Bucket':src_bucket, 'Key':key}

    try:
        print("waiting for the file persist in the source bucket")
        waiter = s3.get_waiter('object_exists')
        waiter.wait(Bucket=src_bucket, Key=key)

        print("Copy object from source to dest s3")
        s3.copy_object(Bucket=dest_bucket, Key=key, CopySource=src)
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Please make sure they exist')
        raise e
