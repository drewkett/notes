# rclone

## Notes on Sharepoint Sync

Sharepoint/Onedrive modify some files on upload so it complains about sizes
changing and checksum being wrong. Create a file with the following content and
pass it using `--exclude-from` to rclone. This will first skip all these files
(you may need to also make capital letter versions of the extensions)

```
*.ppt
*.pps
*.pptx
*.xls
*.xlsx
*.xlsm
*.xlsb
*.doc
*.docx
*.docm
*.dotx
*.dotm
*.htm
*.html
*.aspx
*.vsd
*.mht
*.msg
*.mpp
*.dwt
```

Then do a second run with `--include-from` using that file as well as
`--ignore-size --ignore-checksum` That should copy the remaining files

## Errors

If there are errors and it retries, it will walk the entire tree again, so be
sure to fix up any errors that are correctable so that it doesn't keep retrying.
I guess you could turn retries off

## Throttle limits

If you hit throttle limits `--tpslimit` can be used to limit the transaction
speed. `--tpslimit 10` seemed to work with sharepoint to avoid hitting limits
without too much of a speed penalty. Since its probably a combination of number
of transactions and bandwidth, it may not be possible to optimize to a single
limit value

With a lot of files, this can really slow down a second check where not much has
changed. Run with `-vv` to see rate limit messages

## Set up Azure app

Settting up an azure app gives you a app id that can be added to rclone which
will raise the throttling limits imposed by microsoft. Follow the instructions
at the link below

Getting your own Client ID and Key You can use your own Client ID if the default
(client_id left blank) one doesn’t work for you or you see lots of throttling.
The default Client ID and Key is shared by all rclone users when performing
requests.

If you are having problems with them (E.g., seeing a lot of throttling), you can
get your own Client ID and Key by following the steps below:

- Open
  https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade,
  then click New registration.
- Enter a name for your app, choose account type Any Azure AD directory -
  Multitenant, select Web in Redirect URI Enter http://localhost:53682/ and
  click Register. Copy and keep the Application (client) ID under the app name
  for later use.
- Under manage select Certificates & secrets, click New client secret. Copy and
  keep that secret for later use.
- Under manage select API permissions, click Add a permission and select
  Microsoft Graph then select delegated permissions.
- Search and select the follwing permssions: Files.Read, Files.ReadWrite,
  Files.Read.All, Files.ReadWrite.All, offline_access, User.Read. Once selected
  click Add permissions at the bottom.

[Source](https://rclone.org/onedrive/)

## Get DriveID for sharepoint

Go to
[Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer/preview)

Make the following query with BASEURL and SITENAME set (Make sure to signin).
The id number should be the driveid
https://graph.microsoft.com/beta/sites/BASEURL.sharepoint.com:/sites/SITENAME:/drive?$select=id

## Item not found

Replacing/deleting existing files on Sharepoint gets “item not found” It is a
known issue that Sharepoint (not OneDrive or OneDrive for Business) may return
“item not found” errors when users try to replace or delete uploaded files; this
seems to mainly affect Office files (.docx, .xlsx, etc.). As a workaround, you
may use the --backup-dir <BACKUP_DIR> command line argument so rclone moves the
files to be replaced/deleted into a given backup directory (instead of directly
replacing/deleting them). For example, to instruct rclone to move the files into
the directory rclone-backup-dir on backend mysharepoint, you may use:

```
--backup-dir mysharepoint:rclone-backup-dir
```
