
---
title: "Tags"
linkTitle: "Tags"
weight: 2 
date: 2021-12-27
description: >
  Tagging everything!
---
<span class=opex-on>OpEx</span>
<span class=sec-sec>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-sec>Cost</span>
<span class=sus-off>Sus</span>

Why are tags important you may ask? Well, tags can help in a few ways such as cost allocation, defining the sensitivity of the data, what environment the data is for, and even access control. Each resource (a bucket in our case) can have up to 10 user-defined tags and these are broadly split into these areas, Technical, Automation, Business, and Security. Here are the strictions you should consider when making tags:

|Restriction | Description |
|------------|-------------|
|Maximum number of tags per resource | 50 |
|Maximum key length | 128 Unicode characters in UTF-8 |
|Maximum value length | 256 Unicode characters in UTF-8 |
|Prefix restriction | Do not use the aws: prefix in your tag names or values because it is reserved for AWS use. You can't edit or delete tag names or values with this prefix. Tags with this prefix do not count against your tags per resource limit. |
|Character restrictions | Tags may only contain Unicode letters, digits, whitespace, or these symbols: _ . : / = + - @ |

The table below shows the tags I recommend to customers, but of course, you can add more or leave some out.

| Technical Tags | Automation Tags | Business Tags | Security Tags |
|----------------|-----------------|---------------|---------------|
|Name: the application name| Created by: name the deployment system, CF, TF, or even by hand | Project: which project is the resource aligned too | Confidentiality: Mark if the data contains sensitive data such as personal information |
| Role: the application role/tier | Do Not Delete: true or false (allow the automation to check and bail out preventing data loss) | Owner: which team owns the data | Compliance: Does this data need to be handled in a certain way, such as HIPPA |
|Environment: dev/stage/prod etc| Date and Time: release date and time| Cost Centre: who should be billed for the usage| |
|Cluster: if the resource is used in a particular cluster tag it| | Customer: Add this if you charge your customer for usage| |
|Version: stick to semver or git release if possible| | | |

Lets take a look at how this would look in terraform, the code can be found in the folder 4.0/001. It consists of five files:
#### main.tf
As the tiles suggest this is where we define the main stuff, as in what want to do. In this example, its create an S3 bucket and set versioning and tags on that bucket.
#### providers.tf
This is where we tell terraform to connect to and in our case it’s AWS. We could also add some extra information to make sure the terraform state is stored remotely but that’s beyond the scope of this book.
#### variables.tf
Anything we might want to change the value of in any of the other files should be stored as a variable in this file. You’ll see them referenced in the other files like so: ${var.project}
In this case this populates the project tag in the main.tf file.
#### versions.tf
We use this file to define the minimum version of the providers and modules we are using.
#### outputs.tf
The outputs file is a place where we can ask for information back from terraform, for instance, when a bucket is created.

To run this example make sure you are in the correct folder and run:
  ```bash
  terraform init
  terraform plan
  terraform apply
  ```
Remember to answer yes when prompted on the apply. Once run you’ll see a new bucket in your AWS console called sqcows-demo-bucket-<then a random name>

If you go and inspect that bucket you’ll see versioning enabled and you can also inspect all the tags. The choice of tags that you require is up to you, however, one great way to find things that are not tagged in the correct way is to use AWS Config and use the required-tags rule to enforce all buckets be built with tags.

To clean up after this example just run the following command:
  ```bash
  terraform destroy
  ```
Also type yes when prompted and it will clean up the deployment for you.

### Technical considerations: 
Which tags are useful tou your teams, having a owner and sensitivity level on data can help you prioritise work quickly in a crisis. You may also consider versioning is not required becuase you choose to repliate data to another region.

### Business considerations: 
What tags are important to the business, will they help you pin downthe costs per clickof operations for example? You should also be involved in setting the number of versions to keep. This could change from project to project but allows your business to know the risk and impact







