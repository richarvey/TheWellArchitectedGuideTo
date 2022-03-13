---
title: "S3 Lens"
linkTitle: "S3 Lens"
weight: 4 
date: 2022-01-01
description: >
  Monitor and act on your usage
---
<span class=opex-sec>OpEx</span>
<span class=sec-off>Sec</span>
<span class=rel-off>Rel</span>
<span class=perf-off>Perf</span>
<span class=cost-on>Cost</span>
<span class=sus-sec>Sus</span>

Amazon S3 Storage Lens provides a single pane of glass approach to your object usage and activity across your entire Amazon S3 storage, either in a single account or across an organization.

You can collect activity metrics together and display them in a dashboard. You can even download the data in CSV or Parquet format.

### Configuration
Amazon S3 Storage Lens requires a configuration that contains the properties that are used to aggregate metrics on your behalf for a single dashboard or export. This includes all or partial sections of your organization account’s storage, including filtering by Region, bucket, and prefix-level (available only with advanced metrics) scope. It includes information about whether you chose free metrics or advanced metrics and recommendations. It also includes whether a metrics export is required, and information about where to place the metrics export if applicable.

### Default dashboard
The S3 Storage Lens default dashboard on the console is named default-account-dashboard. S3 preconfigures this dashboard to visualize the summarized insights and trends of your entire account’s aggregated storage usage and activity metrics, and updates them daily in the Amazon S3 console. You can't modify the configuration scope of the default dashboard, but you can upgrade the metrics selection from free metrics to the paid advanced metrics and recommendations. You can also configure the optional metrics export, or even disable the dashboard. However, you can't delete the default dashboard.

The screenshoot below shows a sample of the default dashboard and if you are a graph nerd like myself or good friend Kieren you are in for a treat:

![Example S3 Lens Default Dashboards](../s3lens.png "Example S3 Lens Default Dashboard")

