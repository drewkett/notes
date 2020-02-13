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

## Throttle limits

If you hit throttle limits `--tpslimit` can be used to limit the transaction
speed. `--tpslimit 10` seemed to work with sharepoint to avoid hitting limits
without too much of a speed penalty. Since its probably a combination of number
of transactions and bandwidth, it may not be possible to optimize to a single
limit value
