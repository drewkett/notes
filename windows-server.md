## vssadmin
### Make shadow copy and mount. Incorporate with restic script
    vssadmin list shadows
    vssadmin create shadow /for=c:
    mklink /d C:\mountdir \\GLOBALROOT\?\Dev....