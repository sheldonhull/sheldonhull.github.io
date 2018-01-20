---
layout: post
title: InfluxDB - Comparing Load Tests
date: 2017-08-05
tags: ["influxdb","performance-tuning","metrics","powershell","json","cool-tools","development","powershell","sql-server","tech"]
---

### InfluxDb & Grafana Series

*   [Running InfluxDb As A Service in Windows](https://www.sheldonhull.com/blog/running-influxdb-as-a-service-in-windows?rq=influx)
*   **_[Setting Up InfluxDb, Chronograf, and Grafana for the SqlServer Dev](https://www.sheldonhull.com/blog/setting-up-influxdb-chronograf-and-grafana-for-the-sqlserver-dev?rq=influx)_**
*   [InfluxDB And Annotations](https://www.sheldonhull.com/blog/influxdb-an-annotations)

* * *

Working with InfluxDB and Grafana for visualition is fantastic. However, trying to compare two separate time series against each other for the purpose of load testing is not what Grafana was designed for. Pulling the data from Influx and working with it through Excel, PowerBi, or T-SQL allows you to take the time series stored data and then begin to summarize on a high level what variances are noted. 
