---
title: "Same Region Replication"
date: 2022-01-01
weight: 2 
description: >
  How S3 stores and replicates your data
---
<span class=opex-sec>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-on>Rel</span>
<span class=perf-sec>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

Amazon S3 now supports automatic and asynchronous replication of newly uploaded S3 objects to a destination bucket in the same AWS Region. Amazon S3 Same-Region Replication (SRR) adds a new replication option to Amazon S3, building on S3 Cross-Region Replication (CRR) which replicates data across different AWS Regions. 

Data stored in any Amazon S3 storage class, except for S3 One Zone-IA, is always stored across a minimum of three Availability Zones, each separated by miles within an AWS Region. SRR makes another copy of S3 objects within the same AWS Region, with the same redundancy as the destination storage class. This allows you to automatically aggregate logs from different S3 buckets for in-region processing, or configure live replication between test and development environments. SRR helps you address data sovereignty and compliance requirements by keeping a copy of your objects in the same AWS Region as the original.

When an S3 object is replicated using SRR, the metadata, Access Control Lists (ACL), and object tags associated with the object are also part of the replication. Once SRR is configured on a source bucket, any changes to the object, metadata, ACLs, or object tags trigger a new replication to the destination bucket.

In this example we are going to create a AWS bucket which will be a source and a destination bucket which is where we will replicate the too, the code can be found in the chapter3/001 folder. The example create both buckets and the replication policy,

```
resource "aws_iam_policy" "replication" {
  name        = var.iam_role_name
  description = "Replication Policy"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObjectVersionForReplication",
                "s3:GetObjectVersionAcl"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.source.id}/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetReplicationConfiguration"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.source.id}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ReplicateObject",
                "s3:ReplicateDelete",
                "s3:ReplicateTags",
                "s3:GetObjectVersionTagging"
            ],
            "Resource": "arn:aws:s3:::${aws_s3_bucket.destination.id}/*"
        }
    ]
}
EOF
}
```

This policy allows for replication to occur and in order for it to work we must attach it to a role:

```
resource "aws_iam_role" "replication" {
  name = var.iam_role_name
  tags = local.global_tags

  assume_role_policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Principal":{
            "Service":"s3.amazonaws.com"
         },
         "Action":"sts:AssumeRole"
      }
   ]
}
EOF

}
```

Finally we create a resource so we can use the ARN's in creating our source bucket. You'll see in the code that we have created a rule that copies everything in /copy_me to the destination bucket:

```
replication_configuration {
    role = aws_iam_role.replication.arn
    rules {
      id     = "destination"
      prefix = "DIRECTORY_NAME/"
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.destination.arn
        storage_class = "STANDARD_IA"
      }
    }
  }
```

Once you've run terraform on this you simply need to drop a file in the copy_me folder and on the source bucket and then go have a look in the destination bucket.
