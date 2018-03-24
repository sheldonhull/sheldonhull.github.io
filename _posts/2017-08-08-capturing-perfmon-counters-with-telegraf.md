---
title:  "Capturing Perfmon Counters With Telegraf"
date: 2017-08-08
tags: ["sql-server","monitoring","grafana","influxdb","cool-tools","powershell"]
---

## Other Posts in Series

*   [Running InfluxDb As A Service in Windows](running-influxdb-as-a-service-in-windows.md)
*   [Setting Up InfluxDb, Chronograf, and Grafana for the SqlServer Dev](setting-up-influxdb-chronograf-and-grafana-for-the-sqlserver-dev.md)
*   [InfluxDB And Annotations](influx-db-and-annotations.md)
*   **_[Capturing Perfmon Counters With Telegraf](Capturing-Perfmon-Counters-With-Telegraf.md)_**

## Setting up Telegraf to Capture Metrics

I had a lot of issues with getting the GO enviroment setup in windows, this time and previous times. For using telegraf, I'd honestly recommend just leveraging the compiled binary provided.

Once downloaded, generate a new config file by running the first command and then the next to install as service. (I tried doing through NSSM originally and it failed to work with telegraf fyi)

{% raw %}
 <script src="https://gist.github.com/sheldonhull/583210cfb588d1958b5c2ba67515ec29.js"></script>
{% endraw %}


Once this service was setup and credentials entered, it's ready to run as a service in the background, sending whatever you've configured to the destination of choice.

In my test in Amazon Web Services, using EC2 with Windows Server 2016, I had no issues once EC2 issues were resolved to allow the services to start sending their metrics and show me the load being experienced across all in Grafana.
