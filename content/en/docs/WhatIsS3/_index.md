
---
title: "What is S3?"
linkTitle: "What is S3?"
weight: 6
date: 2021-12-18
description: >
  What can you do with S3?
---

Amazon S3 is a Simple Storage Service, it’s an object-store. An object store is different from traditional file systems as in it is a flat structure. This is the strangest bit to wrap your head around because when you see files on an object store you often see them in a way that represents folders, don’t be fooled it’s all flat (unlike the earth). We call the files we place in the store objects and they are comprised of the data and the metadata, the store itself we call a bucket. You access S3 in a multitude of ways, there’s an API with SDK’s for many languages (python,go,nodeJS,Java,.net, plus many more), there’s an SFTP service you can run, console access or you can use 3rd party applications like cyberduck, you can even mount it as a file system with a set of tools we’ll talk about later. When using S3 it used to be the case that there was eventual consistency, this came from the fact that when you made an API request to upload a file it took time for all the other endpoints to acknowledge the file in the store, so if you tried a read after write API call it could sometimes fail. You’ve probably read this on the internet a few times. However the goodnews is that it is no longer true. S3 supports strong consistency and you can do read’s immediately after a write these days.

We are going to learn in this book how we can use S3 to:

- Secure S3
- Automate creation and lifecycle policies
- Store files (large and small)
- Host simple web sites
- Trigger actions in lambda,SNS and EventBridge

To understand how an object store differs to file storage lets look at how each work.
