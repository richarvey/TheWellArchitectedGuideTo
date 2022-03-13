---
title: "Access Points"
linkTitle: "Access Points"
weight: 7 
date: 2021-12-27
description: >
  Using access points to protect and control your data
---
## How do S3 Access Points Work?

Access points are configured by policy to grant access to either specific users or applications. An example would be allowing groups of users (even from other accounts) access to your data lake.

Each access point is configured to connect to a single S3 bucket. The bucket then contains a network origin control (the source of where you'd like apps or users to connect from) and a Block Public Access Policy. You could, of course, use the CIDR block of your VPC as the access point or get more granular and only allow certain subnets or single IP's. You can even use this to grant certain origins access to objects with a certain prefix or specific tags.

![Access Points Diagram](../accesspoints.png "Access Points source AWS")

You can access the data in a shared bucket by either ARN directly or via its Alias when the operation requires a full bucket name.

## When to use S3 Access Points
S3 Access Points simplify how you manage data access for your application set to your shared data sets on S3. You no longer have to manage a single, complex bucket policy with hundreds of different permission rules that need to be written, read, tracked, and audited. With S3 Access Points, you can now create application-specific access points permitting access to shared data sets with policies tailored to the specific application.

- Large shared data sets: Using Access Points, you can decompose one large bucket policy into separate, discrete access point policies for each application that needs to access the shared data set. This makes it simpler to focus on building the right access policy for an application, while not having to worry about disrupting what any other application is doing within the shared data set.
- Copy data securely: Copy data securely at high speeds between same-region Access Points using the S3 Copy API using AWS internal networks and VPCs.
Restrict access to VPC: An S3 Access Point can limit all S3 storage access to happen from a Virtual Private Cloud (VPC). You can also create a Service Control Policy (SCP) and require that all access points be restricted to a Virtual Private Cloud (VPC), firewalling your data to within your private networks.
- Test new access policies: Using access points you can easily test new access control policies before migrating applications to the access point, or copying the policy to an existing access point.
- Limit access to specific account IDs: With S3 Access Points you can specify VPC Endpoint policies that permit access only to access points (and thus buckets) owned by specific account IDs. This simplifies the creation of access policies that permit access to buckets within the same account, while rejecting any other S3 access via the VPC Endpoint.
- Provide a unique name: S3 Access points allow you to specify any name that is unique within the account and region. For example, you can now have a “test” access point in every account and region.

Whether creating an access point for data ingestion, transformation, restricted read access, or unrestricted access, using S3 Access Points simplifies the work of creating, sharing, and maintaining access to data in your shared S3 buckets.