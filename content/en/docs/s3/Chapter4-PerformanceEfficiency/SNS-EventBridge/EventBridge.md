---
title: "Enabling EventBridge"
date: 2022-01-01
weight: 1 
description: >
  EventBridge Triggers.
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

![Enabling EventBridge](../eventbridge-s3-1.png)

- Under Send notifications to Amazon EventBridge for all events in this bucket choose On.

__Note__
After you enable EventBridge, it takes around five minutes for the changes to take effect.

## Using the AWS CLI
The following example creates a bucket notification configuration for bucket <BUCKET-NAME> with Amazon EventBridge enabled.

```
aws s3api put-bucket-notification-configuration --bucket <BUCKET-NAME> --notification-configuration '{ "EventBridgeConfiguration": {} }'
```

## Creating EventBridge rules

Once enabled you can create Amazon EventBridge rules for certain tasks. For example, you can send email notifications when an object is created. 
