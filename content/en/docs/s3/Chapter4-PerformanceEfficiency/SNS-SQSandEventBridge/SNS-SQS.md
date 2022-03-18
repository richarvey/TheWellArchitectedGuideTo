---
title: "Walkthrough SNS/SQS"
date: 2022-01-01
weight: 1 
description: >
  Configuring a bucket for notifications (SNS topic or SQS queue).
---
<span class=opex-off>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-sec>Rel</span>
<span class=perf-on>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

You can receive Amazon S3 notifications using Amazon Simple Notification Service (Amazon SNS) or Amazon Simple Queue Service (Amazon SQS). In this walkthrough, you add a notification configuration to your bucket using an Amazon SNS topic and an Amazon SQS queue.

## Topics

### Walkthrough summary
- Step 1: Create an Amazon SQS queue
- Step 2: Create an Amazon SNS topic
- Step 3: Add a notification configuration to your bucket
- Step 4: Test the setup

### Walkthrough summary
This walkthrough helps you do the following:

- Publish events of the ```s3:ObjectCreated:*``` type to an Amazon SQS queue.
- Publish events of the ```s3:ReducedRedundancyLostObject``` type to an Amazon SNS topic.

You can do all these steps using the console, without writing any code. In addition, code examples using AWS SDKs for Java and .NET are also provided to help you add notification configurations programmatically.

The procedure includes the following steps:

- Create an Amazon SQS queue.

Using the Amazon SQS console, create an SQS queue. You can access any messages Amazon S3 sends to the queue programmatically. But, for this walkthrough, you verify notification messages in the console.

You attach an access policy to the queue to grant Amazon S3 permission to post messages.

- Create an Amazon SNS topic.

Using the Amazon SNS console, create an SNS topic and subscribe to the topic. That way, any events posted to it are delivered to you. You specify email as the communications protocol. After you create a topic, Amazon SNS sends an email. You use the link in the email to confirm the topic subscription.

You attach an access policy to the topic to grant Amazon S3 permission to post messages.

Add notification configuration to a bucket.

#### Step 1: Create an Amazon SQS queue
Follow the steps to create and subscribe to an Amazon Simple Queue Service (Amazon SQS) queue.

- Using the Amazon SQS console, create a queue. For instructions, see Getting Started with Amazon SQS in the Amazon Simple Queue Service Developer Guide.
- Replace the access policy that's attached to the queue with the following policy.
 - In the Amazon SQS console, in the Queues list, choose the queue name.
 - On the Access policy tab, choose Edit.
 - Replace the access policy that's attached to the queue. In it, provide your Amazon SQS ARN, source bucket name, and bucket owner account ID.
```
{
    "Version": "2012-10-17",
    "Id": "example-ID",
    "Statement": [
        {
            "Sid": "example-statement-ID",
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.amazonaws.com"
            },
            "Action": [
                "SQS:SendMessage"
            ],
            "Resource": "SQS-queue-ARN",
            "Condition": {
                "ArnLike": {
                    "aws:SourceArn": "arn:aws:s3:*:*:awsexamplebucket1"
                },
                "StringEquals": {
                    "aws:SourceAccount": "bucket-owner-account-id"
                }
            }
        }
    ]
}
```
 - Choose Save.
- (Optional) If the Amazon SQS queue or the Amazon SNS topic is server-side encryption enabled with AWS Key Management Service (AWS KMS), add the following policy to the associated symmetric customer managed key.

You must add the policy to a customer managed key because you cannot modify the AWS managed key for Amazon SQS or Amazon SNS.
```
{
    "Version": "2012-10-17",
    "Id": "example-ID",
    "Statement": [
        {
            "Sid": "example-statement-ID",
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.amazonaws.com"
            },
            "Action": [
                "kms:GenerateDataKey",
                "kms:Decrypt"
            ],
            "Resource": "*"
        }
    ]
}
```
- For more information about using SSE for Amazon SQS and Amazon SNS with AWS KMS, see the following:
 - Key management in the Amazon Simple Notification Service Developer Guide.
 - Key management in the Amazon Simple Queue Service Developer Guide.

- Note the queue ARN.

The SQS queue that you created is another resource in your AWS account. It has a unique Amazon Resource Name (ARN). You need this ARN in the next step. The ARN is of the following format:

```
arn:aws:sqs:aws-region:account-id:queue-name
```

#### Step 2: Create an Amazon SNS topic
Follow the steps to create and subscribe to an Amazon SNS topic.
- Using Amazon SNS console, create a topic. For instructions, see Creating an Amazon SNS topic in the Amazon Simple Notification Service Developer Guide.
- Subscribe to the topic. For this exercise, use email as the communications protocol. For instructions, see Subscribing to an Amazon SNS topic in the Amazon Simple Notification Service Developer Guide.
You get an email requesting you to confirm your subscription to the topic. Confirm the subscription.
- Replace the access policy attached to the topic with the following policy. In it, provide your SNS topic ARN, bucket name, and bucket owner's account ID.

```
{
    "Version": "2012-10-17",
    "Id": "example-ID",
    "Statement": [
        {
            "Sid": "Example SNS topic policy",
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.amazonaws.com"
            },
            "Action": [
                "SNS:Publish"
            ],
            "Resource": "SNS-topic-ARN",
            "Condition": {
                "ArnLike": {
                    "aws:SourceArn": "arn:aws:s3:*:*:bucket-name"
                },
                "StringEquals": {
                    "aws:SourceAccount": "bucket-owner-account-id"
                }
            }
        }
    ]
}  
```                
- Note the topic ARN.

The SNS topic you created is another resource in your AWS account, and it has a unique ARN. You will need this ARN in the next step. The ARN will be of the following format:
```
arn:aws:sns:aws-region:account-id:topic-name
```

#### Step 3: Add a notification configuration to your bucket
You can enable bucket notifications either by using the Amazon S3 console or programmatically by using AWS SDKs. 

#### Option A: Enable notifications on a bucket using the console
Using the Amazon S3 console, add a notification configuration requesting Amazon S3 to do the following:

- Publish events of the All object create events type to your Amazon SQS queue.
- Publish events of the Object in RRS lost type to your Amazon SNS topic.

After you save the notification configuration, Amazon S3 posts a test message, which you get via email.
For instructions, see Enabling and configuring event notifications using the Amazon S3 console Enabling Amazon EventBridge.

#### Step 4: Test the setup
Now, you can test the setup by uploading an object to your bucket and verifying the event notification in the Amazon SQS console. For instructions, see Receiving a Message in the Amazon Simple Queue Service Developer Guide "Getting Started" section.
