---


title:  "Setting Up InfluxDb, Chronograf, and Grafana for the SqlServer Dev"
date: 2017-05-17
tags: ["sql-server","business-intelligence","performance-tuning","sql-server","tech","powershell","development","cool-tools"]
---

### InfluxDb & Grafana Series

*   [Running InfluxDb As A Service in Windows](https://www.sheldonhull.com/blog/running-influxdb-as-a-service-in-windows?rq=influx)
*   **_ [Setting Up InfluxDb, Chronograf, and Grafana for the SqlServer Dev
](https://www.sheldonhull.com/blog/setting-up-influxdb-chronograf-and-grafana-for-the-sqlserver-dev?rq=influx) _**
*   [InfluxDB And Annotations](https://www.sheldonhull.com/blog/influxdb-an-annotations)
*   [Capturing Perfmon Counters With Telegraf](https://www.sheldonhull.com/blog/Capturing-Perfmon-Counters-With-Telegraf)

* * *

There are some beautiful ways to visualize time series data with the tools I'm going to go over. This post is purely focused on the initial setup and saving you some time there. In a future post, I'll show how some of these tools can help you visualize your server performance in a powerful way, including taking metrics from multiple types of servers that be working with SQL Server, and combining the metrics when appropriate to give a full picture of performance.

![A beautiful way to visualize performance across a variety of machines](/assets/img/grafana_visualization.pnggrafana_visualization?format=original) A beautiful way to visualize performance across a variety of machines

It's pretty epic to combine information across a variety of sources and be able to relate the metrics to the "big picture" that individual machine monitoring might fail to shed light on.

# Downloading

I started by running this quick powershell script to download the stable toolkit.
{% raw %}
 <script src="https://gist.github.com/sheldonhull/5fa33704e2599e3ddb46a8299ad3bafe.js"></script>
{% endraw %}


Once extracted, I moved the influx extracted subfolder into the InfluxDB folder to keep it clean. Now all the binaries rested in `C:\Influx\InfluxDB` folder with no nesting folders.

I referenced the documentation for getting started with InfluxDB located [here][0] (note that this is for version 0.9 so the url will get updated later on their site.

# Setup Local InfluxDb

Started up the local influxdb binary.
{% raw %}
 <script src="https://gist.github.com/sheldonhull/6f4e11d60244af00edac438cb9ae6ea5.js"></script>
{% endraw %}


Initializing the new database was simple as documented:

    create database statty
<figure>
  > <span>&#147;</span>Warning: InfluxDB is case sensitive. Make sure to check your case if something isn't working, such as use "DatabaseName" instead of user "databasename"<span>&#148;</span>

</figure>

Also, if you get an error with access to the file, try running as admin.

![](/assets/img/Influx+Command+Line+Error+on+writing+history+file.pngInflux+Command+Line+Error+on+writing+history+file?format=original)

# More Enviromental Variable Fun

A simple fix to errors related to paths and the HOME variable these tools often need, per a Github issue, was to ensure the current path was available as a variable. I did this quickly with a simple batch file to launch the consoles as well as one option, as well as updated the Start-Process script to include a statement to set the env variable for the processes being started. This eliminated the issue. For more details see [github issues](http://bit.ly/2nJib1P)

```batch
SET HOME=%~dp0
start influxd.exe
start influx.exe
```
An additional snippet for launching the console version via a bat file:

```batch
set HOME=C:\influx
cmd /k influx.exe -host "MyInfluxDbHost" -database "statty" -precision "s" -format column
```

# Quick Start for Telegraf

Once you have this running you can take the telegraf binaries and run them on any other server to start capturing some default preset metrics. I launched with the following script and placed this in `C:\Influx` directory to make it easy to access for future runs.

{% raw %}
 <script src="https://gist.github.com/sheldonhull/1a9641ce607569dde912f996137debae.js"></script>
{% endraw %}


Edit the conf file to add some tags, change default sampling interval and more. I'll post another article about setting up telegraf to run as a service in the future so search for more info [POSTS ON TELEGRAF](https://www.sheldonhull.com/search?q=telegraf)

You can also apply the same bat file in the startup directory such as:

```batch
@REM alternative is using variable
@REM set TELEGRAF_CONFIG_PATH=C:\telegraf\telegraf.conf

start %~dp0telegraf.exe -config %~dp0telegraf.conf
```

# Run Chronograf

One these metrics began to run, I ran Chronograf. This is Influx's alternative to Grafana, another more mature product.

{% raw %}
 <script src="https://gist.github.com/sheldonhull/958094675f6ab53897616755dd130144.js"></script>
{% endraw %}


![](/assets/img/Initial+Screen+After+Opening+Localhost+when+running+the+Chronograf.exe)

Upon loading and opening up the instance monitor, I found immediately that I was able to get some metrics from the defaults.

![](/assets/img/Defaults+-+Nice+Start.pngDefaults+-+Nice+Start?format=original)

# Get Grafana

My preferred visualization tool, this was far more robust and well documented than Chronograf which has promise, but is a relatively new project.

When starting Grafana, you can run the following script. It creates a copy of the default ini to copy for the user to edit if not already there.

{% raw %}
 <script src="https://gist.github.com/sheldonhull/3cff34cf9029bd99cd1e888e755c307c.js"></script>
{% endraw %}


Once you open the localhost page, if you don't see datasources in the left hand drop down, create an organization and ensure you are an admin, you'll then see the option to add datasources. I simple pointed the page to InfluxDB console running on the server I had setup previously.

# summary

This is just a quick guide on getting started as I found a lot of little bumps in the road since the projects are written in `GO` and not an easily run .NET project. Getting through this will hopefully give you a way to get started. I'll blog a bit more soon on visualization of the metrics captured, some custom annotations to help make metrics come alive with real-time event notifications (like "load test started" and "build ended" etc). It's a really promising solution for those who want some really nice flexibility in using perfmon and related metrics to visualize Windows and SQL Server performance.