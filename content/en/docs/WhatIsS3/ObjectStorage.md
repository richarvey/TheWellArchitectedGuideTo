---
title: "Object Storage"
date: 2021-12-18
weight: 6
description: >
  What is Object Storage? 
resources:
- src: "**.{png,jpg}"
  title: "Image #:counter"
  params:
    byline: "Diagram: Ric Harvey / CC-BY-SA"
---
Object storage on the other hand is a flat storage system of unstructured data. The files are stored in whole or part along with metadata and unique identifiers that are used to locate and identify the data you are accessing. The metadata tags have much more detail, such as location, owner, creation timestamp, file type, and many more. The data and the metadata are bundled together and placed into a flat storage pool for retrieval later. It is a low-cost approach to storage allowing systems to massively scale and even be dispersed globally. It typically has a slightly longer latency for retrieval than a file storage system and you generally access it via REST API calls rather than in a PSIX nature (but we’ll chat about this later. 
In our car park analogy this time we drive to the car park and hand the keys to a valet, who in turn gives us a ticket. The car is parked for us in a massive ground-level car park that stretched for miles and when we return the ticket the car is fetched from the right space.
S3 is an object so fits this description and it’s big, I’ll dive into more details in chapter 2.

![Flat structure of an Object store, data and metadata](../object-storage.png "Fig 2. Flat structure of an object store data and metadata")

The main differences between the two are summarized in this table below:

| WA Pillar            | File Storage                      | Object Storage |
|----------------------|-----------------------------------|----------------|
Operational Excellence | A limited number of metadata tags | Customizable metadata tags with no limits |
Reliability            | Typically on one physical site    | Can be scaled globally across multiple regions |
Reliability            | Scales to millions of files       | Scales infinitely beyond petabytes |
Performance Efficiency | Best performance with small files | Great for large files and high concurrency and throughput |
Cost Optimization      | SAN solutions can be expensive    | Cheaper and cloud providers only charge for what you use |


Object storage is very cost-efficient for many use cases. It also has several tiers of storage available to the end-user. These tiers have pros and cons and you can find out more in chapter 5.
