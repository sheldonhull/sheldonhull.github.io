---


title:  "Update SSMS With PS1"
date: 2017-07-03
tags: ["sql-server","sql-management","setup","automation","powershell","cool-tools","powershell","tech"]
---

With how many updates are coming out I threw together a script to parse the latest version from the webpage, and then provide a silent update and install if the installed version is out of date with the available version. To adapt for future changes, the script is easy to update. Right now it's coded to check for version 17 (SSMS 2017). I personally use Ketarin, which I wrote about before if you want a more robust solution here: [Automating SSMS 2016 Updates & Install](https://www.sheldonhull.com/blog/automating-ssms-2016-updates-install)

The bat file is a simple way for someone to execute as admin.

Hope this saves you some time. I found it helpful to keep a bunch of developers up to date with minimal effort on their part, since SSMS doesn't have auto updating capability, and thus seems to never get touched by many devs. :-) Better yet adapt to drop the SSMS Installer into a shared drive and have it check that version, so you just download from a central location.

{% raw %}
 <script src="https://gist.github.com/sheldonhull/8f2bbd2455fe2f2ba8d41af33525464e.js"></script>
{% endraw %}
