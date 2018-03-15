---
title: "SQL Server Database Experimentation Assistant (DEA)"
date: 
tag: ["sql-server","sql-performance"]
typora-root-url: ..\assets\img
typora-copy-images-to: ..\assets\img
published: false
---

# SQL Server Database Experimentation Assistant (DEA)



Added the DRCReplay.exe and the controller services by pulling up the feature setup and adding existing features to existing SQL instance installed.

![1516994454775](/1516994454775.png)

Pointed the controller directory to a new directory I created 

```powershell
[io.directory]::CreateDirectory('X:\Microsoft SQL Server\DReplayClient\WorkingDir')
[io.directory]::CreateDirectory('X:\Microsoft SQL Server\DReplayClient\ResultDir')
```





### Initializing Test

Started with backup of the database before executing the activity I wanted to trace. 

```powershell
dbatools\backup-dbadatabase -sqlinstance localhost -database $Dbname -CopyOnly -CompressBackup
```

Initialized application application activity, and then recorded in DEA. The result was now in the capture section.

![1516995207757](/1516995207757.png)

Restoring after trace was recorded in DEA was simple with the following command from Dbatools

```powershell
restore-dbadatabase -SqlInstance localhost -Path "<BackupFilePath>" -DatabaseName SMALL -WithReplace
```

After this restore, initiating the replay was achieved by going to the replay tab.

![1516995297608](/1516995297608.png)

