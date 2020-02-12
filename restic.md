# Restic

## Windows VSS

[https://forum.restic.net/t/windows-vss-support/1940/6](Forum Post)

You might try DiskShadow to create another drive letter, which is actually a shadow copy - then back that up instead.

Here’s my DiskShadow file:

    #backup.dsh

    #Make shadows persistent
    SET CONTEXT PERSISTENT
    SET VERBOSE ON

    #Cab location for process
    SET METADATA C:\Users\akrabu\backup.cab

    BEGIN BACKUP

    #Alias volume with alias
    ADD VOLUME C: ALIAS CVOL

    #Create Snapshot
    CREATE

    #Expose the volume and run command file then unexpose
    EXPOSE %CVOL% X:
    EXEC C:\Users\akrabu\.restic\backup.bat
    UNEXPOSE X:

    END BACKUP

    #Delete the shadow copy
    DELETE SHADOWS SET %VSS_SHADOW_SET%

So that basically creates a shadow copy at X:\ then runs the backup script then “unexposes” (deletes) the shadow copy. You would call it by running:

    diskshadow.exe -s backup.dsh

Then just make sure your backup script references X:\ (or whatever letter you choose in the .dsh file) instead of C:\

Another example:
https://ss64.com/nt/diskshadow.html 20

Only hitch I’ve ran into is sometimes DiskShadow won’t unexpose the X:\ and then subsequent backups fail until you notice there’s an X:\ hanging around and manually remove it (and the only way I know to remove it is to delete ALL shadow copies (diskshadow delete shadows all), which sucks if you actually need other shadow copies to, say, restore a file).

That said, if your VSS is screwed up for whatever reason, diskshadow delete shadows all is a handy command to reset things back to scratch. Unlike other tools, it really will delete them all - not just the ones it has made itself. Just a pro-tip!