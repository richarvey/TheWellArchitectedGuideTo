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

## There's a module for that
(https://github.com/asicsdigital/terraform-aws-s3-cross-account-replication)[https://github.com/asicsdigital/terraform-aws-s3-cross-account-replication]

Instead of reinventing the wheel it sometimes makes sense to use prebuilt modules that will get you up and running more quickly. This module helps you simply configure replication across regions and would be my recommended choice for the job in hand. It's supper simple and requires the following terraform variables:

### Required
- source_bucket_name - Name for the source bucket (which will be created by this module)
- source_region - Region for source bucket
- dest_bucket_name - Name for the destination bucket (optionally created by this module)
- dest_region - Region for the destination bucket
- replication_name - Short name for this replication (used in IAM roles and source bucket configuration)
- aws.source - AWS provider alias for source account
- aws.dest - AWS provider alias for destination account

### Optional
- create_dest_bucket - Boolean for whether this module should create the destination bucket
- replicate_prefix - Prefix to replicate, default "" for all objects. Note if specifying, must end in a /

### Usage

```hcl
provider "aws" {
  alias   = "source"
  profile = "source-account-aws-profile"
  region  = "us-west-1"
}

provider "aws" {
  alias   = "dest"
  profile = "dest-account-aws-profile"
  region  = "us-east-1"
}

module "s3-cross-account-replication" {
  source             = "github.com/asicsdigital/terraform-aws-s3-cross-account-replication?ref=v1.0.0"
  source_bucket_name = "source-bucket"
  source_region      = "us-west-1"
  dest_bucket_name   = "dest-bucket"
  dest_region        = "us-east-1"
  replication_name   = "my-replication-name"

  providers {
    "aws.source" = "aws.source"
    "aws.dest"   = "aws.dest"
  }
}

output "dest_account_id" {
  value = "${module.s3-cross-account-replication.dest_account_id}"
}
```

## Amazon Replication Time Control

Amazon S3 replication time control helps you meet compliance "or business requirements" for data replication and provides visibility into Amazon S3 replication activity. Replication time control replicates most objects "that you upload" to Amazon S3 in seconds, and 99.99 percent of those objects within 15 minutes. S3 Replication Time Control, by default, includes S3 replication metrics and S3 event notifications, with which you can monitor the total number of S3 API operations that are pending replication, the total size of objects pending replication, and the maximum replication time.

### Business considerations
Consider your users, if you have large data assets (video or audio, etc) then you'll want this to be closer to the end user so they get a good experience. Even when using cloudfront, it can take time to come from eu-west-1 to ap-southeast-2 for example. So for smooth a smooth user experience consider this option. You may also have a regualtory reason to make sure backups exist 100's of miles from the origin.
