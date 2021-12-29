---
title: "MFA Delete"
linkTitle: "MFA Delete"
weight: 8 
date: 2021-12-27
description: >
  Prevent accidental deletion of objects
---
<span class=opex-sec>OpEx</span>
<span class=sec-on>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

It is possible to prevent accidental deletion of objects in S3. However at the time of writing this doesn't work through the mfa_delete terraform provider, so we are going to make the call direct to the API.

Once enabled users are rewquired to enter a MFA code when they try and delete objects, this can provide extra time to think before doing something that can break things.

```bash
aws --profile <my_profile> s3api put-bucket-versioning --bucket <bucket-name> --versioning configuration 'MFADelete=Enabled,Status=Enabled' --mfa 'arn:aws:iam::<account-id>:mfa/root-account-mfa-device <mfacode>
```
