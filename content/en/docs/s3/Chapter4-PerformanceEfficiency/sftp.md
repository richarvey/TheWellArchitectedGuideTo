---
title: "SFTP Service"
date: 2021-12-30
weight: 200
description: >
  Allowing access to legacy applications 
---
<span class=opex-off>OpEx</span>
<span class=sec-sec>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-on>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

If you have applications or customers who need to transfer data in or out via SFTP, AWS Transfer for SFTP will help you. It allows clients to use the tools they are used to, but allows you take advantage of cheaper storage systems like S3! You can use the console to enable it but I've included source code to get this setup via terraform for you.

![AWS Transfer for SFTP](../sftp0.png "AWS Transfer for SFTP")

The code builds on our simple bucket example but adds in the transfer family:

```terraform
resource "aws_transfer_server" "example" {
  security_policy_name = "TransferSecurityPolicy-2020-06"
  tags = {
      Name = local.bucket_name
      Project = "${var.project}"
      Environment = "${var.env}"
      Owner = "${var.owner}"
      CostCenter = "${var.cost}"
      Confidentiality = "${var.conf}"
  }
}
```

You can now take advantage of S3s scale and features such as versioning and intelligent tiering but access in a traditional way. The Final thing you'll need to do is add a user with a SSH key via the console. If you don't have a SSH already just run:

```bash
ssh-keygen
```

Now head to the AWS transfer pages in the Web Console for AWS. Here you will be able to add a user and your public key.

![Adding a user](../sftp1.png "Adding a user")

You can now connect either by the sftp command,

```bash
sftp localfile remote_file_directory/.
```

Or use a visual tool. You'll need the provate key to connect.
