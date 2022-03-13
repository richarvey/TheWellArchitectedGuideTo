---
title: "Cost Optimization"
linkTitle: "Cost Optimization"
weight: 11 
date: 2021-12-27
description: >
  The Cost Optimization pillar includes the ability to run systems to deliver business value at the lowest price point
---
The real art of any system is getting to grips with costs and maximizing the margins of your product. In terms of Amazon S3, this comes down to the storage medium you are using, you want to balance the best price with the performance and reliability pillars and it can be a tough line to walk.

If you are storing data on S3 rather than EBS (elastic block storage) volumes, EFS (elastic file storage), FSx for Luture or even running propriatory cloud storage systems in the cloud, you are already doing well with cost optimization. By the way, Those propriatory systems are just using the same fundermental building blocks you have like EBS and adding a few features, seldom will they save you money. So the real trick to saving money in S3 is down to the data, you'll need to identify hot data thats always accessed and make sure that data thats cold gets moved to a cheaper teir. Also this sounds simple, if you don't need the data and the business agree delete it! I've seen customers with 8 years worth of snapshots for EBS and 10 years worth of daily tgz files stored in an s3 bucketTo make matters worse there where several buckets identical which lead to approxomately 100TB of storage that was never accessed, or likely to be! If you are wondering what that cost it was ~$24500.00 a month!!!! Yeah I know!
