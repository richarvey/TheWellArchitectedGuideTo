---
title: "Life Cycle Policies"
linkTitle: "Life Cycle Policies"
weight: 2 
date: 2021-12-28
description: >
  Save money on storage
---
<span class=opex-off>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-on>Cost</span>
<span class=sus-sec>Sus</span>

In order to maximise your savings when using object storage you have to use the right tier for that data. You will need to balance cost against speed, reliability and avaliability. AWS Glacier Deep Archive is the cheapest storage but is a 12 hour wait to get your data back going to be a anacceptable buisiness requirement.
When you decide the right balance in order to move the data between tiers you can imppliment Life Cycle policies. An S3 Lifecycle configuration is a set of rules that define actions that Amazon S3 applies to a group of objects. There are two types of actions:

__Transition actions__ – These actions define when objects transition to another storage class. For example, you might choose to transition objects to the S3 Standard-IA storage class 30 days after creating them, or archive objects to the S3 Glacier Flexible Retrieval storage class one year after creating them.

There are costs associated with lifecycle transition requests and moving between tiers, the costs are minimal and however the savings of using a cheaper storage should be greater.

__Expiration actions__ – These actions define when objects expire. Amazon S3 deletes expired objects on your behalf.

### Managing object lifecycle
Define S3 Lifecycle configuration rules for objects that have a well-defined lifecycle. For example:

- If you upload periodic logs to a bucket, your application might need them for a week or a month. After that, you might want to delete them.
- Some documents are frequently accessed for a limited period of time. After that, they are infrequently accessed. At some point, you might not need real-time access to them, but your organization or regulations might require you to archive them for a specific period. After that, you can delete them.
- You might upload some types of data to Amazon S3 primarily for archival purposes. For example, you might archive digital media, financial and healthcare records, raw genomics sequence data, long-term database backups, and data that must be retained for regulatory compliance.

With S3 Lifecycle configuration rules, you can tell Amazon S3 to transition objects to less-expensive storage classes, or archive or delete them.

### Using Terraform to manage your lifecycle
If we take a look at example code we have been working on we can add the required section in there. 

```json
  lifecycle_rule = [
    {
      id      = "log"
      enabled = true
      prefix  = "log/"

      tags = {
        rule      = "log"
        autoclean = "true"
      }

      transition = [
        {
          days          = 30
          storage_class = "ONEZONE_IA"
          }, {
          days          = 60
          storage_class = "GLACIER"
        }
      ]

      expiration = {
        days = 90
      }

      noncurrent_version_expiration = {
        days = 30
      }
    },
    {
      id                                     = "log1"
      enabled                                = true
      prefix                                 = "log1/"
      abort_incomplete_multipart_upload_days = 7

      noncurrent_version_transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "ONEZONE_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        },
      ]

      noncurrent_version_expiration = {
        days = 300
      }
    },
  ]
```
The rule above has multiple parts. Anything in the log prefix (folder) will move to One Zone IA, After 60 days the data will move to Glacier and after 90 days the data will be deleted. Theres also a second rule for the profix log1, it'll move data to Standard IA after 30 days and then into One Zone IA after 60 days, after 90 days they'll move to Glacier and then finially 300 days later the data will be deleted. You will have noticed that the first rule is applied in a different way to the other. The second rule is used to clean up none current versions of files. As files change you can end up with a big long list of old versions. So the second rule is very importnat.

### Technical considerations
Rememeber to clean up the versions, they're not visable but can add a sizable cost to the monthly bill if not managed. If you are underr GDPR you need to work out a way of expunging a persons data in these versions and backups also.

### Business considerations
The business should supply the information for retention policies. Theres often rule and regulation around how long you must store data for.
