---
title: "Execute code from S3"
linkTitle: "Execute code From S3"
weight: 3
date: 2022-01-01
description: 
    Execute code using S3 triggers
---
<span class=opex-off>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-sec>Rel</span>
<span class=perf-sec>Perf</span>
<span class=cost-sec>Cost</span>
<span class=sus-on>Sus</span>

One of the biggest announcements to ever come out of re:invent (the AWS annual event in Las Vegas) was the launch of Lambda. Lambda is effectively Functions as a service. You can write code and give it to AWS and they handle the runtime and scaling of the function. Lambda supports multiple languages, we will be using python in this example. Lambda supports multiple triggers. Triggers are what tells Lambda to run the code you've written. You could use SNS or Event bridge as mentioned in previous chapters, however, Lambda natively supports a direct trigger from S3 on completion of the upload of an object. This is my mind is the jewl that makes S3 so awesome.


## Create a Bucket

First, let's create a new bucket to test our trigger. From the command line run:

```bash
aws s3 mb s3://<MY_BUCKET_NAME>
```

![AWS Console showing s3 bucket](../s3bucket.png "AWS Console showing new s3 bucket")

If you want to check fromt he CLI run:

```bash
aws s3 ls
```

## Create the Lambda Function

We are going to use a blueprint from AWS for the demo to get going quickly, but you can always adapt this to your needs. Blueprints not only contain the code but also include the scafolding for setting up the trigger from the S3 bucket to the function. We are going to use a Python Blueprint from the create new function screen in the lambda console.


![Crreate a new function](../createFunction.png "Create a new function")

Now select _use a blueprint_ and select the __s3-get-object-python__ function. This is a python 3.7 example but the latest runtime of python you can create yourself currently goes up to 3.9. Now click configue:

![Configure the blueprint](../blueprintFunction.png "Configure the blueprint")

- Under Basic information, do the following:
- For Function name, enter __myExampleFunction__
- For Execution role, choose Create a new role from AWS policy templates.
- For Role name, enter __myExampleRole__
- Under S3 trigger, choose the __<S3 bucket>__ that you created with the aws cli.
  - The AWS console will automatically allow the function to access the S3 resource and most importantly allows S3 to tigger the function.
- Choose Create function.

Your screen should look like the following:

![Configuring the options for the function](../configureFunction.png "Configuring the options for the function")

### Review the code
When the Lambda is triggered it recieves an _event_. Our function inspects the event and extracts the bucket name and the key (the key is the file name). Using the bucket name and key the function then uses boto3 to get the object and then print out the object type in the log.
Your code should look like the following in your AWS console:

```python
import json
import urllib.parse
import boto3

print('Loading function')

s3 = boto3.client('s3')


def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    try:
        response = s3.get_object(Bucket=bucket, Key=key)
        print("CONTENT TYPE: " + response['ContentType'])
        return response['ContentType']
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
        raise e
              
```
## Test with the S3 trigger

Invoke your function when you upload a file to the Amazon S3 source bucket.

### To test the Lambda function using the S3 trigger

- On the Buckets page of the Amazon S3 console, choose the name of the source __<bucket name>__ that you created earlier.
- On the Upload page, upload a few .jpg or .png image files to the bucket.
- Open the Functions page of the Lambda console.
- Choose the name of your function (__myExampleFunction__).
- To verify that the function ran once for each file that you uploaded, choose the Monitor tab. This page shows graphs for the metrics that Lambda sends to CloudWatch. The count in the Invocations graph should match the number of files that you uploaded to the Amazon S3 bucket.

![Metrics of the function](../metrics-functions-list.png "Metrics of the function")

- You can also check out the logs in the CloudWatch Console or in the Lambda Console additionally and check out the log stream for you function name.

## Clean up your resources

To clean up all the resources you can follow the steps below. This will ensure your account is nice and tidy and avoid a really really tiny storage cost fee of your uploaded trigger. Because the function is serverless, unless you upload more files to that S3 bucket you won't be charged anything for it! This also means you are not wasting energy running a server waiting for something to happen.

__To delete the Lambda function__
- Open the Functions page of the Lambda console.
- Select the function that you created.
- Choose Actions, then choose Delete.
- Choose Delete.

__To delete the IAM policy__
- Open the Policies page of the AWS Identity and Access Management (IAM) console.
- Select the policy that Lambda created for you. The policy name begins with AWSLambdaS3ExecutionRole-.
- Choose Policy actions, Delete.
- Choose Delete.

__To delete the execution role__
- Open the Roles page of the IAM console.
- Select the execution role that you created.
- Choose Delete role.
- Choose Yes, delete.

__To delete the S3 bucket__
- Open the Amazon S3 console.
- Select the bucket you created.
- Choose Delete.
- Enter the name of the bucket in the text box.
- Choose Confirm.

## Choose ARM
As a side note the function we created above used a x86 (intel) processor and is the default for all functions on AWS. However AWS have developed their own silicon chip called the Graviton Processsor and in Lambda you can currently use the v2 of this chip. It's an ARM based processor and like it's mobile phone cousin chips it sips electricity. Because of this you'll use far less energy and it's cheaper too!
