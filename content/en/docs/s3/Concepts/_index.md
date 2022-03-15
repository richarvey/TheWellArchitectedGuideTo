---
title: "Concepts"
linkTitle: "Concepts"
weight: 4
description: >
  What you need to know! 
---
Whilst reading the sections you'll be presented with the Well Architected Bar, this is to tell you which parts of the Well-Architected Framework is applicaple to the content you are about to read. The example below indicates that __Security__ is the main focus of the content but the content is also applicable to __Operational Excellence__ as a secondary catergory.

<span class=opex-sec>OpEx</span>
<span class=sec-on>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>
<br/>

This book includes code samples and command line (CLI) instructions to run as you go through it. The code blocks will be Terraform or Python code, the code blocks will always be tagged with the correct language like so:

```python
import boto3, botocore
import base64, os, json, requests
from aws_lambda_powertools import Tracer
from aws_lambda_powertools.logging.logger import set_package_logger

set_package_logger()

# POWERTOOLS_SERVICE_NAME defined
tracer = Tracer(service="s3r")

def check_safeurl(url):
    ''' check url to make sure its not on a blocked list'''
    if os.environ['SafeBrowsing'] == 'true':
……
``` 

Command Line instructions will be indented on their own line, for example

  ```aws s3 ls```

Should you need to change a variable in the code or CLI instruction it will be highlighted in __bold__ and __<>__ for example __<AWS_REGION>__

