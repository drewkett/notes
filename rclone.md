# rclone
## Notes on Sharepoint Sync

Sharepoint/Onedrive modify some files on upload so it complains about sizes changing and checksum being wrong. Create a file with the following content and pass it using `--exclude-from` to rclone. This will first skip all these files (you may need to also make capital letter versions of the extensions)

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
 
Then do a second run with `--include-from` using that file as well as `--ignore-size --ignore-checksum` That should copy the remaining files
