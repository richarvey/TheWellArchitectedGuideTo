
---
title: "Bucket Policies"
linkTitle: "Bucket Policies"
weight: 1 
date: 2021-12-27
description: >
  Set out what you can and can't do within a bucket
---
<span class=opex-off>OpEx</span>
<span class=sec-on>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

Bucket Policies are applied by the account owner to the bucket. Only the account owner can do this. It uses the JSON format and has a limit of 20k in size. This policy is then used to grant access to your resources. Lets have a chat about some of the terminology used for Bucket Policies first by having a look at the following elements and what they mean and refer too:

Resources: These can be buckets, objects, access points, and jobs for which you can allow or deny permissions. You refer to them by Amazon Resource Name (ARN).

Actions: Each resource type supports fined grained control actions so you can give a user the least privilege they need. In the case of S3 it could like the following example:
  ```json
  "s3:CreateBucket", 
  "s3:ListAllMyBuckets", 
  "s3:GetBucketLocation" 
  ```
Effect: An effect is applied to the user request as an action and are in the form of Allow and Deny. If you don’r explicitly grant an Allow the default action is deny.

Principal: The account or user who is allowed access to the actions and resources in the statement. In a bucket policy its the root user of the account.

Condition: Conditions apply to policies that are being acted on and can be use to further limit or increase the scope in that particular action. An example would be:
    ```json
      "Condition": {
        "StringEquals": {
          "s3:x-amz-grant-full-control": "id=AccountA-CanonicalUserID"
        }
     ```
There’s a great example for this in the form of you may wish to enable MultiFactorAuth when someone tries to delete an object. In the terms of a bucket policy you’d need something like the following policy:

  ```json
  {
    "Id": "Policy1640609878106",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1640609875204",
        "Action": [
          "s3:DeleteBucket",
          "s3:DeleteBucketPolicy",
          "s3:DeleteObject",
          "s3:DeleteObjectTagging",
          "s3:DeleteObjectVersion",
          "s3:DeleteObjectVersionTagging"
        ],
        "Effect": "Allow",
        "Resource": "*",
        "Condition": {
          "ArnEquals": {
            "aws:MultiFactorAuthAge": "true"
          }
        },
        "Principal": "*"
      }
    ]
  }
  ```

Let’s take this example (chapter3/002) forward, by showing you how to add a policy. In this case, we are going to create an IAM role and then allow anyone with that role attached or anyone who can assume that role to List the S3 bucket contents. The code below enables this:

```json
resource "aws_iam_role" "this" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.this.arn]
    }

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${local.bucket_name}",
    ]
  }
}
```
Finally, let’s make sure we attach the policy to the bucket. If you check the terraform you’ll see two additional lines adding in the policy to the s3 bucket creation:
  ```json 
  attach_policy = true
  policy        = data.aws_iam_policy_document.bucket_policy.json
  ```
To run this example (chapter3/002) make sure you are in the correct folder and run:
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
You need to consider permissions very seriously and work on the principle of least privilege, start with a minimum set of permissions and grant additional permissions as necessary. Doing so is more secure than starting with permissions that are too lenient and then trying to tighten them later. You can even use the IAM Access Analyzer to monitor this.

### Business Considerations:
Business leaders need to help identify whom within the company should and shouldn’t hace access, they should also be considered in what data should be made public.

