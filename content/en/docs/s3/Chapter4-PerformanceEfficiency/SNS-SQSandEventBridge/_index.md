---
title: "SNS, SQS and EventBridge"
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

Enabling notifications is a bucket-level operation. You store notification configuration information in the notification subresource that's associated with a bucket. After you create or change the bucket notification configuration, it usually takes about five minutes for the changes to take effect. When the notification is first enabled, an s3:TestEvent occurs. Amazon S3 stores the notification configuration as XML in the notification subresource that's associated with a bucket. 

## Configuring event notifications programmatically
By default, notifications aren't enabled for any type of event. Therefore, the notification subresource initially stores an empty configuration.

```
<NotificationConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/"> 
</NotificationConfiguration>
```

To enable notifications for events of specific types, you replace the XML with the appropriate configuration that identifies the event types you want Amazon S3 to publish and the destination where you want the events published. For each destination, you add a corresponding XML configuration.

### To publish event messages to an SQS queue
To set an SQS queue as the notification destination for one or more event types, add the QueueConfiguration.
```
<NotificationConfiguration>
  <QueueConfiguration>
    <Id>optional-id-string</Id>
    <Queue>sqs-queue-arn</Queue>
    <Event>event-type</Event>
    <Event>event-type</Event>
     ...
  </QueueConfiguration>
   ...
</NotificationConfiguration>
```

### To publish event messages to an SNS topic
To set an SNS topic as the notification destination for specific event types, add the TopicConfiguration.
```
<NotificationConfiguration>
  <TopicConfiguration>
     <Id>optional-id-string</Id>
     <Topic>sns-topic-arn</Topic>
     <Event>event-type</Event>
     <Event>event-type</Event>
      ...
  </TopicConfiguration>
   ...
</NotificationConfiguration>
```

### To invoke the AWS Lambda function and provide an event message as an argument
To set a Lambda function as the notification destination for specific event types, add the CloudFunctionConfiguration.
```
<NotificationConfiguration>
  <CloudFunctionConfiguration>   
     <Id>optional-id-string</Id>   
     <CloudFunction>cloud-function-arn</CloudFunction>        
     <Event>event-type</Event>      
     <Event>event-type</Event>      
      ...  
  </CloudFunctionConfiguration>
   ...
</NotificationConfiguration>
```
### To remove all notifications configured on a bucket
To remove all notifications configured on a bucket, save an empty <NotificationConfiguration/> element in the notification subresource.

When Amazon S3 detects an event of the specific type, it publishes a message with the event information. For more information, see Event message structure.
