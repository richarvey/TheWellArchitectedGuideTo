
---
title: "Bucket Permissions"
linkTitle: "Bucket Permissions"
weight: 2 
date: 2021-12-27
description: >
  Define security at the bucket level
---
<span class=opex-sec>OpEx</span>
<span class=sec-on>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>


You can also set bucket-level permissions in S3, which can override object-level permissions that someone tries to set. This is a super quick thing to enable in terraform and if you create a bucket in the AWS console it’ll actually ve defaulted to these values. Once again these things will project you from accidentally exposing data. All these tags below are pretty self-explanatory and included in the example.
  ```json
  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  ```
With policies you can set at a bucket level are as follows READ, WRITE, READ_ACP, WRITE_ACP and FULL_CONTROL. These can also be applied at an individual object level with the exception of WRITE which isn’t applicable. Be particularly careful with the ACP rules as these can allow a user to set your access policy.

Take a look at the following to see how these permissions map to IAM permissions: https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#permissions

Even if you enable all available ACL options in the Amazon S3 console, the ACL alone won't allow everyone to download objects from your bucket. However, depending on which option you select, any user could perform these actions:

- If you select List objects for the Everyone group, then anyone can get a list of objects that are in the bucket.
- If you select Write objects, then anyone can upload, overwrite, or delete objects that are in the bucket.
- If you select Read bucket permissions, then anyone can view the bucket's ACL.
- If you select Write bucket permissions, then anyone can change the bucket's ACL. 

To prevent any accidental change to public access on a bucket's ACL, you can configure public access settings for the bucket. If you select Block new public ACLs and uploading public objects, then users can't add new public ACLs or upload public objects to the bucket. If you select Remove public access granted through public ACLs, then all existing or new public access granted by ACLs is respectively overridden or denied. The changes in our terraform set these permissions.

To run this example (chapter3/003) make sure you are in the correct folder and run:
  ```bash
  terraform init
  terraform plan
  terraform apply
  ```
You’ll need to type yes when prompted.

To cleanup run
  ```bash
  terraform destroy
  ```
And answer yes to the prompt.

### Technical considerations:
These policies can affect the way developers and applications can interact with the data stored in AWS. Some buckets are public for a reason, and having that knowledge and only allowing non-sensitive flagged objects in that bucket will help to keep you safe.

### Business considerations:
Help the devop’s teams identify data correctly. You may work with these files on a daily basis and are the best people to say this needs protecting at all costs or this data here is fine to be public. It’s a team effort to secure the data.

