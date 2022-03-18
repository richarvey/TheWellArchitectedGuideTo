---
title: "Enabling Event Bridge"
date: 2022-01-01
weight: 1 
description: >
  SNS, SQS and EventBridge Triggers.
---
<span class=opex-off>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-sec>Rel</span>
<span class=perf-on>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

You can enable Amazon EventBridge using the S3 console, AWS Command Line Interface (AWS CLI), or Amazon S3 REST API.

## Using the S3 console
To enable EventBridge event delivery in the S3 console.

- Sign in to the AWS Management Console and open the Amazon S3 console at https://console.aws.amazon.com/s3/.
- In the Buckets list, choose the name of the bucket that you want to enable events for.
- Choose Properties.
- Navigate to the Event Notifications section and find the Amazon EventBridge subsection. Choose Edit.
- Under Send notifications to Amazon EventBridge for all events in this bucket choose On.

__Note__
After you enable EventBridge, it takes around five minutes for the changes to take effect.

## Using the AWS CLI
The following example creates a bucket notification configuration for bucket DOC-EXAMPLE-BUCKET1 with Amazon EventBridge enabled.

```
aws s3api put-bucket-notification-configuration --bucket DOC-EXAMPLE-BUCKET1 --notification-configuration '{ "EventBridgeConfiguration": {} }'
```

## Using the REST API
You can programmatically enable Amazon EventBridge on a bucket by calling the Amazon S3 REST API. For more information see, see PutBucketNotificationConfiguration in the Amazon Simple Storage Service API Reference.

The following example shows the XML used to create a bucket notification configuration with Amazon EventBridge enabled.

```
<NotificationConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <EventBridgeConfiguration>
  </EventBridgeConfiguration>
</NotificationConfiguration>
```

## Creating EventBridge rules

Once enabled you can create Amazon EventBridge rules for certain tasks. For example, you can send email notifications when an object is created. 
