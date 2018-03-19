---


title:  "Running InfluxDB as a service in Windows"
date: 2017-05-24
tags: ["influxdb","powershell","configuration","tech","sql-server","powershell","development"]
---

### InfluxDb & Grafana Series

*   **_[Running InfluxDb As A Service in Windows](https://www.sheldonhull.com/blog/running-influxdb-as-a-service-in-windows?rq=influx)_**
*   [Setting Up InfluxDb, Chronograf, and Grafana for the SqlServer Dev
](https://www.sheldonhull.com/blog/setting-up-influxdb-chronograf-and-grafana-for-the-sqlserver-dev?rq=influx)
*   [InfluxDB And Annotations](https://www.sheldonhull.com/blog/influxdb-an-annotations)
*   [Capturing Perfmon Counters With Telegraf](https://www.sheldonhull.com/blog/Capturing-Perfmon-Counters-With-Telegraf)

* * *

As part of the process to setup some metrics collections for sql-server based on perfmon counters I've been utilizing InfluxDB. Part of getting started on this is ensuring InfluxDB runs as a service instead of requiring me to launch the exe manually. For more information on InfluxDb, see my other post: [Setting Up InfluxDb, Chronograf, and Grafana for the SqlServer Dev](https://www.sheldonhull.com/search?q=Setting%20Up%20InfluxDb)

This of course, did not go without it's share of investigation since I'm working with a compiled executable that was originally built in `GO`. I had issues registering InfluxDB as a service. This is typically due to enviromental/path variables. In my powershell launch of `InfluxD.exe` I typically used a script like the following:

{% raw %}
 <script src="https://gist.github.com/sheldonhull/6f4e11d60244af00edac438cb9ae6ea5.js"></script>
{% endraw %}


I investigated running as a service and found a great reminder on using NSSM for this: [Running Go executables ... as windows services ' Ricard Clau](http://bit.ly/2pDW65t) I went and downloaded NSSM again and first setup and register of the service went without a hitch, unlike my attempt at running `New-service -name 'InfluxDB' -BinaryPathName 'C:\Influx\influxdb\InfluxD.exe' -DisplayName 'InfluxDB' -StartupType Automatic -Credential (get-credential)`. I'm pretty sure the core issue was the `PATH` variables and other related enviromental paths were not setup with "working directory" being the InfluxDB which would be expected by it.

# [NSSM - Non-Sucking Service Manager](http://bit.ly/2pDTR25)

Using `nssm install` provided the GUI which I used in this case. Using the following command I was able to see the steps taken to install, which would allow reproducing the install from a .bat file very easily.

    set-location C:\tools
    .\nssm.exe dump InfluxDB

This resulted in the following output:

    C:\tools\nssm.exe install InfluxDB C:\Influx\influxdb\influxd.exe
    C:\tools\nssm.exe set InfluxDB AppDirectory C:\Influx\influxdb
    C:\tools\nssm.exe set InfluxDB AppExit Default Restart
    C:\tools\nssm.exe set InfluxDB AppEvents Start/Pre C:\Influx\influxdb\influx.exe
    C:\tools\nssm.exe set InfluxDB AppEvents Start/Post C:\Influx\influxdb\influx.exe
    C:\tools\nssm.exe set InfluxDB AppNoConsole 1
    C:\tools\nssm.exe set InfluxDB AppRestartDelay 60000
    C:\tools\nssm.exe set InfluxDB DisplayName InfluxDB
    C:\tools\nssm.exe set InfluxDB ObjectName SERVICENAME "PASSWORD"
    C:\tools\nssm.exe set InfluxDB Start SERVICE_AUTO_START
    C:\tools\nssm.exe set InfluxDB Type SERVICE_WIN32_OWN_PROCESS

Pretty awesome! It's a nice change to have something perfectly the first time with no issues.