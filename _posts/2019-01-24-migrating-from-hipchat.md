---
title: Migrating From Hipchat
last_modified_at: '2019-02-05 03:55:00'
date: '2019-02-05 01:09:43'
excerpt: >-
  Migrating from hipchat to slack can be a little painful if you have some  
  issues similar to mine to cleanup. Maybe this will help save you some time.
tags:
  - tech
  - powershell
  - development
toc: true
typora-root-url: ..\assets\img
typora-copy-images-to: ..\assets\img
---
# Problems

## Problem: You want to do an initial import of Hipchat content and then update with deltas. 
Don't even consider it. The slack import can't add delta content for private messages and private rooms. This means you'd get a lot of duplicate rooms being created. It's better to do the migration import in one batch rather than try to incrementally pull in content. Don't go down this route, as I didn't discover this till later in the process resulting in a time-crunch.

## Problem: You have hipchat users that have email address that have been migrated to a new domain since they were created.
You've migrated to a new domain, but your Hipchat accounts all have the previous email which you've setup as email aliases. You can't easily change in Hipchat due to the fact it's set a profile level, "synced" to the Atlassian account. I had no luck in working on changing this so I instead leveraged the Slack API to bulk update during migration (after all the accounts were created). I mapped the active directory user to the current user by parsing out the email aliases and reversing this. I also created an alternative approach for those that had no matching email alias, and iffy full name matching to use fuzzy matching based soley on last name in the email address. 

# Improving Your Migration Experience

## Rename Your Hipchat Rooms Prior to Migration (optional)
The Slack Migration tool is pretty good, but the auto renaming had some rename behavior that didn't align in a clean manner with what my naming convention was going to be. This means to simplify your migration, it's better to rename your Hipchat rooms prior to migration so all your rooms now create slack channels that don't have to be renamed again. Also, if you pull in a delta of content for public rooms, it can automatically match and incrementally add content (this doesn't work for private content).

## Getting Started with Hipchat CLI
It's painful. Hipchat's going into the great beyond so don't expect support for it. 

> warning "Important"
> API Key for personal won't access full list of rooms in the action `getRoomList` in the CLI. Instead, you'll need to obtain the room list using Add-On token which I found too complex for my one time migration. Instead, you can copy the raw html of the table list, and use a regex script to parse out the room name and number list and use this. You can still perform room rename, just not `sendmessage` action on the rooms using the API token.

1. Install integration from marketplace to the entire account
2. Download the CLI for running locally
3. Create API Key. **Important**. This is a 40 character *personal* key, not the key you create as an admin in the administrators section. You need to go to your personal profile, and then create a key while selecting all permissions in the list to ensure full admin privileges.
4. To get the raw HTML easily, simply try this Chrome extension for selecting the table and copying the raw html of the table. [CopyTables](http://bit.ly/2S1XwRn)
5. Open the room listing in Hipchat. Using the extension select `Rows` as your selection criteria and then select `Next Table`. Copy the Raw html to an empty doc. Go to the next page (I had 3 pages to go through) and copy each full table contents to append to the raw html in your doc.
6. Once you have obtained all the html rows, then run the following script to parse out the html content into a `[pscustomobject[]]` collection to work with in your script.

## Using CLI

To get started, cache your credentials using the fantastic BetterCredentials module. To install you'll need to run `Install-Module BetterCredentials -Scope CurrentUser -AllowClobber -Force`

Then set your cached credentials so we don't need to hard code them into scripts. This will cache it in your Windows Credential manager.

```powershell
$cred = @{
    credential   = ([pscredential]::new('myHipchatEmail' , ("APITokenHere" | ConvertTo-SecureString -AsPlainText -Force) ) )
    type         = 'generic'
    Persistence  = 'localcomputer'
    Target       = 'hipchatapi'
    description  = 'BetterCredentials cached credential for hipchat api'
}
BetterCredentials\Set-Credential @cred
```

