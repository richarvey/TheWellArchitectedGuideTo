---
title: "Versioning"
date: 2021-12-30
weight: 1 
description: >
  Keep multiple versions of your objects
---
<span class=opex-off>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-on>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-sec>Cost</span>
<span class=sus-off>Sus</span>

S3 allows you to keep multiple copies/variants of an object. This is really useful if you are updating a file and writing over the top but may need to revert to an older version for DR or other events where you may wish to restore a preserved object.

To enable versioning on S3 you do this at the bucket level and in terraform its super simple:

```terraform
    versioning = {
      enabled = true
    }
```

Versioning even saves you from accidental deletion. If you delete an object when versioning is enabled, S3 flags the object with a delete marker instead of removing it permanently. By default, S3 Versioning is disabled on buckets, and you must explicitly enable it.

Unless you are using SDK's you are best using the AWS console, if you dive into the S3 console open a bucketed and look at an object thats recently been updated, you'll see the tags and how to restore to a previous version.

![Versioning in the S3 console](../versioning.png "Versioning in the S3 console")

### Technical considerations
Versioning is a great get out of jail free card should something (or someone) go wrong, it lets you got a stable earlier version. There is however a consideration on how long you keep the versions for and you'll need to discus this with the business.

### Business considerations
If you keep multiple versions you end up with higher storage costs, so you'll need to agree with the technical team if it's needed or backups from another system would be better suited.
