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

Amazon S3 now supports automatic and asynchronous replication of newly uploaded S3 objects to a destination bucket in the same AWS Region. Amazon S3 Same-Region Replication (SRR) adds a new replication option to Amazon S3, building on S3 Cross-Region Replication (CRR) which replicates data across different AWS Regions. Together, SRR and CRR form Amazon S3 Replication to deliver enterprise-class replication features such as cross-account replication for protection against accidental deletion and replication to any Amazon S3 storage class, including S3 Glacier and S3 Glacier Deep Archive to create backups and long-term archives. With SRR, new objects uploaded to an Amazon S3 bucket are configured for replication at the bucket, prefix, or object tag levels. Replicated objects can be owned by the same AWS account as the original copy or by different accounts, to protect from accidental deletion.

Data stored in any Amazon S3 storage class, except for S3 One Zone-IA, is always stored across a minimum of three Availability Zones, each separated by miles within an AWS Region. SRR makes another copy of S3 objects within the same AWS Region, with the same redundancy as the destination storage class. This allows you to automatically aggregate logs from different S3 buckets for in-region processing, or configure live replication between test and development environments. SRR helps you address data sovereignty and compliance requirements by keeping a copy of your objects in the same AWS Region as the original.

When an S3 object is replicated using SRR, the metadata, Access Control Lists (ACL), and object tags associated with the object are also part of the replication. Once SRR is configured on a source bucket, any changes to the object, metadata, ACLs, or object tags trigger a new replication to the destination bucket.
