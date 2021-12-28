
---
title: "Enabling Encyption"
linkTitle: "Enabling Encyption"
weight: 3 
date: 2021-12-27
description: >
  Types of encryption at rest
---
<span class=opex-sec>OpEx</span>
<span class=sec-on>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-sec>Perf</span>
<span class=cost-sec>Cost</span>
<span class=sus-off>Sus</span>

Just as Werner Vogals (CRO of AWS) said, dance like no one is watching, encrypt data like everyone is! So in this light, there are a few options. You could programmatically encrypt your data before you upload but this is going to require using your resources and managing your own key rotation. You can of course rely on AWS to make this easier for you. In (chapter3/004) we use code that lets AWS generate a key and manage it entirely for you. This is the default SSE-S3 method and it’s best to enable it as a rule on the bucket, take note of the line:
  ```json
  server_side_encryption = "AES256"
  ```
This is the part that tells AWS to use default encryption. It’s the cheapest and easiest way to encrypt at rest. You’ll also see the code at the bottom that uploads our file. Note theres nothing special on that file to say “hey lets encrypt”, it’s automatically applied at the bucket level.

To run this example (chapter3/004) make sure you are in the correct folder and run:
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

There is another way however and this is to use AWS Key management service (KMS) this is also referred to as SSE-KMS. This allows you to manage keys on a more granular level and rotate keys when and if needed. We will first need to define a KMS key:
```json
resource "aws_kms_key" "objects" {
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7
}
```
The value deletion_window_in_days is how long the key is valid for. If you go over this time or delete the key you’ll lose access to that data also!!!! To use SSE-KMS slightly tweak the rule in the s3 bucket:
  ```json
  kms_master_key_id = aws_kms_key.objects.arn
  sse_algorithm     = "aws:kms"
  ```
Note that the object we upload has no changes because we are applying this at the bucket level.

To run this example (chapter3/005) make sure you are in the correct folder and run:
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

### Technical considerations
Remember if you use KMS, you must take responsibility for the management and access to that key. It’s also going to greatly increase the number of API calls to KMS and this is going to bump your costs up. Encryption also always has a cost in terms of accessing the data, there’s extra work to be done so expect that it’ll be slightly slower to retrieve an object.

### Business considerations
You need to be aware that SSE-KMS whilst being the form of encryption you have the most control over is going to increase your costs. However, it may be the more suitable encryption if the data has been classified as highly sensitive. You can use different encryption on different buckets, so classify your data accordingly and pick the right encryption for you, but please do encrypt!

