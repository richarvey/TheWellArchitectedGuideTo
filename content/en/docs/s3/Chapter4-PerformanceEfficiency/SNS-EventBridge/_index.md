---
title: "SNS and EventBridge"
date: 2022-01-01
weight: 1 
description: >
  SNS and EventBridge Triggers.
---
<span class=opex-off>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-sec>Rel</span>
<span class=perf-on>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

Enabling notifications is a bucket-level operation. You store notification configuration information in the notification subresource that's associated with a bucket. After you create or change the bucket notification configuration, it usually takes about five minutes for the changes to take effect. When the notification is first enabled, an s3:TestEvent occurs. Amazon S3 stores the notification configuration as XML in the notification subresource that's associated with a bucket. 

### Technical Considerations

Using SNS or eventbridge can give you great flexibility to have actions performed when a file is upload/deleted/updated in S3. During this guide you'll also see you can additionally use SQS or trigger Lambda directly and you may wonder why not use these approaches instead, and you'd be right, It's more efficient to go direct to Lambda, however, SNS can deliver to multiple subscribers (lambda, email, etc) So it gives you a few more options. Eventbridge is also an enhancement over direct to Lambda as it allows you to filter which messages will actually triger Lambda running and potentially save you 1000's of unneeded invocations.

### Business Considerations

Using cheaper storage such as S3 has a real potential to lower your bill, but you'll probably want to do something with that data. This chapter shows that S3 can be a power hub allowing your data to be automatically processed on update or other operations. This way of working can help your business transform to a micro-services style of working, which will help you gain speed in rolling out new features and updates without affecting the entire business, thus you can innovate faster.
