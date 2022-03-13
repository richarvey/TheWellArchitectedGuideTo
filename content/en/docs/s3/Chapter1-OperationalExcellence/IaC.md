
---
title: "Infrastructure as Code"
linkTitle: "Infrastructure as Code"
weight: 2
date: 2021-12-27
description: >
  Automate all the things
---
<span class=opex-on>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-off>Cost</span>
<span class=sus-off>Sus</span>

The command line is great, but let's face it we are going to want to use the API more in our automation. When it comes to Infrastructure as code there as a few options and all have their own merrits. Personally I tend to use terraform but there are other options like Amazons own Cloudformation or CDK.

<span> ![Terraform Logo](../terraform_Logo.png "Terraform logo") https://learn.hashicorp.com/terraform </span><br/>
<span> ![Cloud Formaion Logo](../cloudformation.png "Cloudformation") https://aws.amazon.com/cloudformation/ </span>

## Why should you use IaC?
Having your infrastruce (in this case your S3 buckets) as code it not only helps you build your workload out but also allows you to replicate your set up in other environments and even allows you recovery more quickly in the event of a disaster situation, by rebuiling your setup quickly and reliabily. By turning your infrasture into deployable code you remove human error and lesson the changes of something working in stage and then failing in production.

## Terraform
Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services. Terraform codifies cloud APIs into declarative configuration files.

Through out this book we'll be using terraform, however you may already be an expert in cloudformation, so if you do feel inclined you could rewrite the examples, and we are always happy to accept pull requests to the book.
