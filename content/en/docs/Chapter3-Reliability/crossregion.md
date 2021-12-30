---
title: "Cross Region Replication"
date: 2021-12-30
weight: 2 
description: >
  Replicate data to another region for backup
---
<span class=opex-sec>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-on>Rel</span>
<span class=perf-sec>Perf</span>
<span class=cost-sec>Cost</span>
<span class=sus-off>Sus</span>

Amazon S3 cross region replication can be used for a few reasons. You may wish to have the data backed up 100's of miles away from your origin region for regulation reasons, you can also change acccount and ownership to prevent against accidental data loss. Another region maybe that you want to move data closer to the end user to reduce latancy. You can set cross region replication at a bucket level, a pre defined prefix or even on an object level with the correct tags.

In the code supplied with this chapter we'll replicate one region (eu-west-1) to another region (eu-central-1). Once you've run the terraform try dropping an object (a file) in the origin bucket and then using the cli or console check out the destination bucket. To run the code:

```bash
terraform init
terraform plan
terraform apply
```

You'll need to answer yes to the prompt in order to actually deploy the code. Now lets upload to your origin bucket (it'll have origin in the name):

```bash
aws s3 cp <FILE> s3://<ORIGIN_BUCKET>/.
```

Now lets see if its replicated over to the replica:

```bash
aws s3 ls s3://<REPLICA_BUCKET>
```

Don't forget to clean up after this test.

```bash
terraform destroy
```

Answer yes at the prompt.

#### Amazon Replication Time Control

Amazon S3 replication time control helps you meet compliance "or business requirements" for data replication and provides visibility into Amazon S3 replication activity. Replication time control replicates most objects "that you upload" to Amazon S3 in seconds, and 99.99 percent of those objects within 15 minutes. S3 Replication Time Control, by default, includes S3 replication metrics and S3 event notifications, with which you can monitor the total number of S3 API operations that are pending replication, the total size of objects pending replication, and the maximum replication time.


### Technical considerations
You can actually replicate from one source to multiple regions. However you are going to boost your cross region data costs doing this so make sure finance are aware.


### Business considerations
Consider your users, if you have large data assets (video or audio, etc) then you'll want this to be closer to the end user so they get a good experience. Even when using cloudfront, it can take time to come from eu-west-1 to ap-southeast-2 for example. So for smooth a smooth user experience consider this option. You may also have a regualtory reason to make sure backups exist 100's of miles from the origin.
