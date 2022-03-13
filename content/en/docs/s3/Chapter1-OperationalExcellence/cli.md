
---
title: "The AWS Command Line"
linkTitle: "The AWS Command Line"
weight: 1
date: 2021-12-30
description: >
  Useful AWS CLI commands
---
<span class=opex-on>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

Let's start off by getting familiar with the AWS CLI. If you are using the AWS Web Terminal as suggested in getting started this will be super simple. 
Manipulating large numbers of files is much simpler via the CLI compared to using the console interface, the '''sync''' command is one example of this allowing you to easily copy a large
number of files to or from an S3 bucket.

Below are a few commands that are super useful:

#### s3 make bucket
Quickly create a bucket from the command line. If you don't specify --region the CLI will default to your default.
```bash
aws s3 mb s3://sqcows-bucket --region eu-west-1
```

#### s3 remove bucket
Use with care!!! The --force command is useful when you have a none empty bucket.
```bash
aws s3 rb s3://sqcows-bucket
aws s3 rb s3://sqcows-bucket --force # Delete a none empty bucket
```

#### s3 ls commands
Just like the *nix equivalant there is a recursive option which is useful when you start racking up lots of objects and prefixes.
```bash
aws s3 ls
aws s3 ls s3://sqcows-bucket
aws s3 ls s3://sqcows-bucket --recursive
aws s3 ls s3://sqcows-bucket --recursive  --human-readable --summarize
```

#### s3 cp commands
```bash
aws s3 cp getdata.php s3://sqcows-bucket
aws s3 cp /local/dir/data s3://sqcows-bucket --recursive
aws s3 cp s3://sqcows-bucket/getdata.php /local/dir/data
aws s3 cp s3://sqcows-bucket/ /local/dir/data --recursive
aws s3 cp s3://sqcows-bucket/init.xml s3://backup-bucket
aws s3 cp s3://sqcows-bucket s3://backup-bucket --recursive
```

#### s3 mv commands
```bash
aws s3 mv source.json s3://sqcows-bucket
aws s3 mv s3://sqcows-bucket/getdata.php /home/project
aws s3 mv s3://sqcows-bucket/source.json s3://backup-bucket
aws s3 mv /local/dir/data s3://sqcows-bucket/data --recursive
aws s3 mv s3://sqcows-bucket s3://backup-bucket --recursive
```

#### s3 rm commands
```bash
aws s3 rm s3://sqcows-bucket/<file_to_delete>
aws s3 rm s3://sqcows-bucket --recursive #delete all the files in the bucket!!!!
```

#### s3 sync commands
I tend to use these over the cp commands as it works really well and feels more like rsync.
```bash
aws s3 sync backup s3://sqcows-bucket
aws s3 sync s3://sqcows-bucket/backup /tmp/backup
aws s3 sync s3://sqcows-bucket s3://backup-bucket
```
