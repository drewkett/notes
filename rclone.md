# rclone

## Notes on Sharepoint Sync

Sharepoint/Onedrive modify some files on upload so it complains about sizes
changing and checksum being wrong. Create a file with the following content and
pass it using `--exclude-from` to rclone. This will first skip all these files
(you may need to also make capital letter versions of the extensions)

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

Then do a second run with `--include-from` using that file as well as
`--ignore-size --ignore-checksum` That should copy the remaining files

## Errors

If there are errors and it retries, it will walk the entire tree again, so be
sure to fix up any errors that are correctable so that it doesn't keep retrying.
I guess you could turn retries off

### Throttle limits

If you hit throttle limits `--tpslimit` can be used to limit the transaction
speed. `--tpslimit 10` seemed to work with sharepoint to avoid hitting limits
without too much of a speed penalty. Since its probably a combination of number
of transactions and bandwidth, it may not be possible to optimize to a single
limit value

With a lot of files, this can really slow down a second check where not much has
changed. Run with `-vv` to see rate limit messages

### Set up Azure app

Settting up an azure app gives you a app id that can be added to rclone which
will raise the throttling limits imposed by microsoft. Follow the instructions
at the link below

[Source](https://rclone.org/onedrive/)

### Get DriveID for sharepoint

Go to
[Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer/preview)

Make the following query with BASEURL and SITENAME set (Make sure to signin).
The id number should be the driveid
https://graph.microsoft.com/beta/sites/BASEURL.sharepoint.com:/sites/SITENAME:/drive?$select=id

### --backup-dir

Use `--backup-dir` since theres some permissions thing with sharepoint that gets
resolved with this. This is a directory that will get created at destination

I believe the error it avoids is `nameAlreadyExists`
