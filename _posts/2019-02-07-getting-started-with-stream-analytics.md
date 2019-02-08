---
title: Getting Started with Stream Analytics
last_modified_at: '2019-02-07 19:53:28'
date: '2019-02-07 19:53:00'
excerpt: >-
  If you are a newbie to the world of streaming analytics and need to get moving
  on parsing some Application Insights this is for you.
tags:
  - sql-server
  - development
  - tech
toc: true
typora-root-url: ..\assets\img
typora-copy-images-to: ..\assets\img
---
# The Scenario
Application insights is integrated into your application and is sending the results to Azure. In my case, it was blob storage. This can compromise your entire insights history. 

# The process
1. Install Visual Studio Azure Plugin
2. Initialize a new Stream Analytics project in Visual Studio
3. Import some test data
4. (Optional) If using SQL Server as storage for stream analytics then design the schema.
5. Write your stream analytics sql, aka asql.
6. Debug and confirm you are happy with this. 
7. Submit job to Azure (stream from now, or stream and backfill)
8. Configure Grafana or PowerBI to connect to your data and make management happy with pretty graphs.

## Install Visual Studio Azure Plugin
I don't think this would have been a feasible learning process without having run this through VS. Learning the ropes through the web interface can be helpful, but if you are exploring the data parsing you need a way to debug and test the results without waiting minutes to simply have a job start. In addition, you need a way to see the parsed results from test data to ensure you are happy with the results. 

## New Stream Analytics Project
## Setup test data
Grab some blob exports from your Azure storage and sample a few of the earliest and the latest of your json, placing into a single json file. Put this in your solution folder called inputs through Windows Explorer. After you've done this, right click on the input file contained in your project and select `Add Local Input`. This local input is what you'll use to debug and test without having to wait for the cloud job. You'll be able to preview the content in Visual Studio just like when you run SQL Queries and review the results in the grid. 

## Design SQL Schema
## Stream Analytics Query
## Debugging
## Submit job to Azure

## Backfilling Historical Data
When you start the job, the default start job date can be changed. Use custom date and then provide it the oldest data of your data. For me this correctly initialized the historical import, resulting in a long running job that populated all the historical data from 2017 and on.

## Configure Grafana or PowerBI
Initially I started with Power BI. However, I found out that Grafana 5.1 > has data source plugins for Azure and Application insights, along with dashboard to get you started. I've written on Grafana and InfluxDB in the past and am huge fan of Grafana. I'd highly suggest you explore that, as it's free, while publishing to a workspace with PowerBI can require a subscription, that might not be included in your current MSDN or Office 365 membership. YMMV. 

