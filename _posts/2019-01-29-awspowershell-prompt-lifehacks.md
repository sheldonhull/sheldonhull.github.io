---
excerpt: >-
  A few tricks to improve your PowerShell prompt experience when working with
  Amazon Web Services (AWS) to ensure you have configured region and credential
  correctly
layout: post
title: AWSPowershell Prompt Lifehacks
toc: false
tags:
  - powershell
  - AWS
  - tech
last_modified_at: '2019-01-29 04:22:00'
date: Invalid date
---
Improving your PowerShell prompt can be a nice help when dealing with AWSPowershell development commands. It's often tricky to remember if you've correctly setup your credentials _and_ region correctly. I've often set my default credentials, yet forget to reset to a different region for my command, resulting in some wasted time troubleshooting. 

I've taken the following from various sources and modified together for my personalized prompt that provides me back the `ProfileName` I've initialized, along with the region I've configured.



![Prompt showing enhanced metadata](/assets/img/2019-01-29_16-12-26.png "Enhanced Prompt Showing Current Credentials and Region")
