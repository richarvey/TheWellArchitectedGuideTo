---
title: "Tiering"
date: 2021-12-18
weight: 1 
description: >
  Understanding different tier cost and performance
---
<span class=opex-off>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-on>Cost</span>
<span class=sus-sec>Sus</span>

Let’s have a talk about the different storage tiers in S3. Amazon S3 offers a plethora of storage classes that you can choose from to best suit your needs around data access, resiliency, and cost requirements. Each storage class has it’s merrits and in this section we’ll look at which ones will be best for you. If you don’t know which class of storage is right for your workload, or you have a workload with unpredictable patterns of usage you can even use S3 Intelligent-Tiering which automaticcally moves your data to the right class based on usage patterns, which will lean to lower costs for storaging your data. The there is __S3 Standard)__ for frequently accessed data, the type of things you may access daily. This features 

- Low latency and high throughput performance
- Designed for durability of 99.999999999% of objects across multiple Availability Zones (within a region)
- Resilient against events that impact an entire Availability Zone
- Designed for 99.99% availability over a given year
- Backed with the Amazon S3 Service Level Agreement for availability
- Supports SSL for data in transit and encryption of data at rest
- S3 Lifecycle management for automatic migration of objects to other S3 Storage Classes

The trade off here is that it costs more to have all those feature than other tiers. Saying that the cost isn’t hugh for storage in S3 which is one of it’s main attractions at _$0.023_ per GB per month. 

__S3 Standard-Infrequent Access (S3 Standard-IA)__ at first glance looks almost identical to Standard S3. However it really is designed for files you don’t open often. The costs is approx _$0.0.134_ per GB per Month but if you switch this tier you may increate your API / object call pricing thus removing andy benefit.

- Same low latency and high throughput performance of S3 Standard
- Designed for durability of 99.999999999% of objects across multiple Availability Zones
- Resilient against events that impact an entire Availability Zone
- Data is resilient in the event of one entire Availability Zone destruction
- Designed for 99.9% availability over a given year
- Backed with the Amazon S3 Service Level Agreement for availability
- Supports SSL for data in transit and encryption of data at rest
- S3 Lifecycle management for automatic migration of objects to other S3 Storage Classes

__S3 One Zone-Infrequent Access (S3 One Zone-IA)__ for less frequently accessed data. For me this is where it gets interesting. If you have data thats not accessed on a regular basis and can be recreated easily S3 One-Zone-IA could be for you. As you may have guessed instead of your data being replicated in all AZ’s in a region this is going to live only in one. The Pay back for that is it’s even cheeper at _$0.01048_ per GB per Month. This risk to you though is that if an AZ has an issue you could loose the data. 

- Same low latency and high throughput performance of S3 Standard
- Designed for durability of 99.999999999% of objects in a single Availability Zone†
- Designed for 99.5% availability over a given year
- Backed with the Amazon S3 Service Level Agreement for availability
- Supports SSL for data in transit and encryption of data at rest
- S3 Lifecycle management for automatic migration of objects to other S3 Storage Classes

Now lets take a look at the __Glacier__ side of things. Glacier is cold storage designed for archiving data that you may never touch again or only in very certain situations. Think of a audit happening at work and they need records from 6 years ago. It would be expensive to store 6 years worth of data in standard S3 so this is where Glacier comes in.

Released in 2021 __S3 Glacier Instant Retrieval__ is for archive data that needs immediate access. With Glacier you normally have a time delay to get the data back you are archiving, anywhere between 1-12 hours but Instant retrieval does what it says on the tin and you can __instantly get your databack__. As long as this is the sort of data you only access once a quarter it could be a good place for you to store data that fits this requirement. With a cost _$0.005_ per GB per hour for data you may need to access its a good place to store it.

- Data retrieval in milliseconds with the same performance as S3 Standard
- Designed for durability of 99.999999999% of objects across multiple Availability Zones
- Data is resilient in the event of the destruction of one entire Availability Zone
- Designed for 99.9% data availability in a given year
- 128 KB minimum object size
- Backed with the Amazon S3 Service Level Agreement for availability
- S3 PUT API for direct uploads to S3 Glacier Instant Retrieval, and S3 Lifecycle management for automatic migration of objects

S3 Glacier Flexible Retrieval (formerly S3 Glacier) for rarely accessed long-term data that does not require immediate access is yet another tier of storage, With a slightly lower cost of _$0.00408_ per GB per Month. It doesn’t sound like a big reduction but when you are storing petabytes of data it can really add up quickly. The downside is that you need to put in a request for this data to be retrieved and it can take __1-12 hours__ to do so.

- Designed for durability of 99.999999999% of objects across multiple Availability Zones
- Data is resilient in the event of one entire Availability Zone destruction
- Supports SSL for data in transit and encryption of data at rest
- Ideal for backup and disaster recovery use cases when large sets of data occasionally need to be retrieved in minutes, without concern for costs
- Configurable retrieval times, from minutes to hours, with free bulk retrievals
- S3 PUT API for direct uploads to S3 Glacier Flexible Retrieval, and S3 Lifecycle management for automatic migration of objects

Finally __Amazon S3 Glacier Deep Archive (S3 Glacier Deep Archive)__ for long-term archive and digital preservation with retrieval in hours at the lowest cost storage in AWS’s object storage tiers at _$0.0018_ per GB per Month, the downside is it takes __12 hours__ to restore your objects back into S3.

- Designed for durability of 99.999999999% of objects across multiple Availability Zones
- Lowest cost storage class designed for long-term retention of data that will be retained for 7-10 years
- Ideal alternative to magnetic tape libraries
- Retrieval time within 12 hours
- S3 PUT API for direct uploads to S3 Glacier Deep Archive, and S3 Lifecycle management for automatic migration of objects

There is technically another class of S3 storage that lives on AWS Outposts, which are appliances that you can store in your own DC but this book isn’t going to cover that but can get more information here: https://aws.amazon.com/outposts/
