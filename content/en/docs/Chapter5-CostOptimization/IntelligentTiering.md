---
title: "Intelligent Tiering"
date: 2022-01-06
weight: 2
description: >
  Using the best price storage with intelligent tiering
---
<span class=opex-sec>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-on>Cost</span>
<span class=sus-sec>Sus</span>

When I tell you intelligent tiering is going to automatically save you money you might seem a little skeptical, but it really can in the right hands. The thing is there is a catch, but it's not a big one. That is that aws charge you a small fee, but it really is small unless you have billions of objects in S3 as it's about $0.10 per million objects monitored a month.

S3 Intelligent-Tiering is the ideal storage class for data with unknown, changing, or unpredictable access patterns, independent of object size or retention period. You can use S3 Intelligent-Tiering as the default storage class for virtually any workload, especially data lakes, data analytics, new applications, and user-generated content. The only caviet is that it doesn't include objects under 128 KB, however they also don't count in the charges for automation. These small objects remain in the frequent access tier. 

#### How it works

Intelligent tiering is designed to optimise where you data is stored based on access patterns from daily use. It will then move lesser used objects onto cheaper tiers of S3 storage, when those patterns of access change it can also move the data back into the higher tiers. It's configured with three tiers, _frequent_ use, _infrequent_ use and a very low cost tier for data _rarely_ accessed. After 30 days of an not being access ed Intelligent tiering automatically moves the data to the lower cost storage S3 IA which should save you about 40% on your storage costs. After 90 days of no access Inteligent Tiering will move the data to Glacier Instant Access which brings your savings to 68% over standard storage costs. You can aditionally configure and opt in to Glacier Deep Archive which would boost your savings to 95%. 

