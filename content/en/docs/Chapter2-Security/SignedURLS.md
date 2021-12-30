
---
title: "Signed URLs"
linkTitle: "Signed URLs"
weight: 4 
date: 2021-12-27
description: >
  Share Files Securely
---
<span class=opex-sec>OpEx</span>
<span class=sec-on>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

If all objects by default are private in a bucket you are going to need a mechanisim to share files to others at some point or another. Only the object owner has permission to access these objects. However, the object owner can optionally share objects with others by creating a presigned URL and setting an expiration time on how long that key is valid for.

One way to generate signed URL's is to run a script like the one below. Create a new file called signedurl.py and with your favourite editor add the following content:

```python
#!/usr/bin/env python3

import boto3, argparse

parser = argparse.ArgumentParser()
parser.add_argument('-b','--bucket', help='Name of your S3 Bucket', required=True)
parser.add_argument('-o','--object', help='Name of the object + prefix in your bucket', required=True)
parser.add_argument('-t','--time', type=int, help='Expirery in seconds Default = 60', default=60)
args =  vars(parser.parse_args())


def get_signed_url(time, bucket, obj):
    s3 = boto3.client('s3')

    url = s3.generate_presigned_url('get_object', Params = { 'Bucket': bucket, 'Key': obj }, ExpiresIn = time)
    return url

try:
    url = get_signed_url(args['time'],args['bucket'], args['object'])
    print(url)
except:
    print('Something odd happened')
```

You'll need to set the permisions on the script so you can execute the file like so:

```bash
chmod +x signedurl.py
```
To execute the following code you need to supply __-b__ which is the bucket name, __-o__ which is the object and __-t__ which is time in seconds. The example below grants access for 500 secons to a bucket named s3redirect and file called index.html
```bash
./signedurl.py -b s3redirect -o index.html -t 500
```
which would return you an answe like below:

```bash
https://s3redirect.s3.amazonaws.com/index.html?AWSAccessKeyId=AKIAVFTCNZXUBOD4ZTX6&Signature=gptFG4W2hCoRCWmd%2FloDtvqUonc%3D&Expires=1640724520
```

You can of course can do this by using the CLI directly with the following commands:

```bash
aws s3 presign s3://sqcows-bucket/<file_to_share>
aws s3 presign s3://sqcows-bucket/<file_to_share> --expires-in 300 #5mins
```

### Technical considerations
Whilst it is an easy way to share files to people who normally have ano access this could become a cumbersome process. It would make more sense to review the users access rights and grant them proper access to the files they need. This would also prevent the signed URL being used by others.

### Business considerations
The signed URL can be used by anyone who recieves the link. This opens up substantial risks for a business in the case of a signed url being used for PII data and then that URL being leaked or eroniously sent to the wrong reciepiant on email.
