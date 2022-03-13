
---
title: "Reliability"
linkTitle: "Reliability"
weight: 9 
date: 2021-12-27
description: >
  Distributed system design, recovery planning, and adapting to changing requirements
---
This pillar focuses on the business and technical aspects of your workload and data. What sort of recovery time is acceptable to the business if there is a failure? How long do you keep backups for? Do you need to go global or is a single AZ the right choice for you and the business? We’ll also cover changes and incident response and recovery as well as change management.

#### Reliability in AWS regions/zones/s3

Letis first talk about how AWS is built. There are regions such as eu-west-1 and us-west-2. These are geographic locations for the clusters of data centres AWS opperate. They are also largely separated in most cases protecting them from a single region failure, it's not 100% fault tollerent but outages that affect all regions at once are a rare occassion because of region isolation. Within a region you have zones, for example _eu-west-1a_, _eu-west-1b_ and _eu-west-1c_. These zones are huge, and not just a single data centre, they are clusters of datacentres that are hyper local to each other, however, each zone may be miles apart from another.

This gives you a massive amount of reliability if you run in all the zones in a region when coming to storage or compute. In Amazon S3 Standard your data is replicated in all three zones within a region and you are protected from a single zone failure. In fact untill you move into S3 One Zone Infrequent Access (S3 OneZone-IA) you are protected against failure. If you compare this to you datacentres you effectively have DR from the start with having to do anything!!!!

Some companies may want to go further though and this is where a skilled Solutions Architect will talk to the business and see if they want to go beyond the high avaliability in a region and set up replication to another region. The trade off here is cost and it will double your data store costs plus network transfer fees. 
