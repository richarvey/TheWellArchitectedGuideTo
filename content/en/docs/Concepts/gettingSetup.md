---
title: "Getting Setup"
linkTitle: "Getting Setup"
weight: 4
description: >
  Getting your environment ready for working with this book
---

I recommend that unless you have everything ready to go on your local machine that you use the AWS cloud console shell to run the examples in this book. It comes pre-configured with you IAM keys for access to your account and already has the aws CLI and python installed. Be warned python defaults to version 2.7.18 at the time of writing however version 3.7 is installed and that's what we will use.

To open the cloud shell simply click on the shell icon in the top right hand corner once you log into your AWS account:

![Launch the Web Shell](../topright.png "Launch the webshell")

You should tehn be prompted with the following screen after 30 seconds whilst it spins up:

![The Web Shell](../shell.png "The AWS web shell")

I now recommend you run some updates to get us all on the same track:
  ```bash
  yum update
  yum upgrade
  ```

Finally in the setup section lets install terraform. Terraform is a Infrastructure as code tool produced by hashicorp and is an alternative to Amazon's own CloudFormation. I’m including both in this book as which one you prefer is down to your preference.

Let us install unzip first so you can extract the terraform file:
  ```bash
  sudo yum install unzip
  ```

Find the latest release version of terraform from here: https://github.com/hashicorp/terraform/releases in my case its 1.1.2
  ```bash
  export release=<VERSION>
  ```
This sets the variable $release for the following commands
  ```bash
  sudo wget https://releases.hashicorp.com/terraform/${release}/terraform_${release}_linux_amd64.zip
  ```
You should see the output of wget downloading the file here. Now lets unzip the file and put it somewhere useful.
  ```bash
   unzip terraform_${release}_linux_amd64.zip
   sudo unzip terraform_${release}_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   terraform version
   ```

The final command should return the current version of terraform, in my case, it’s 1.1.2


