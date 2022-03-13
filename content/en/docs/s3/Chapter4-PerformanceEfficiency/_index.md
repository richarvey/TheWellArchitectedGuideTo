
---
title: "Performance Efficiency"
linkTitle: "Performancy Efficiency"
weight: 10 
date: 2021-12-27
description: >
  Right size your resources and streamline you monitoring to deliver performant workloads
---
Performance covers a lot of ground and you really need to balance business and technical requirements here also. What’s an acceptable load time for your customers? If you get that wrong, customers can become frustrated and you’ll lose business. We could of course build something super responsive but waste resources and money, so there is a fine line to tread.

When we think about S3 and performance we no longer have to consider things like randomizing prefixes to spread the data out in order to avoid hot spots in data. Amazon listened to it's customer and handled this for us. However there are things we can do still for performance, these can be from using batch to process lots of data using S3-Select to minimise the data you pullfrom s3 and that helps with cost also. But the easiest way to keep an eye on things is to use the S3 dashboard something that I geek out about on a regular basis because it has pretty graphs :) We'll look at some of the operations in this chapter and I'll show you how to keep an eye on systems and keep objects flying in and out of your buckets. 
