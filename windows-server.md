## vssadmin
### Make shadow copy and mount. Incorporate with restic script
    vssadmin list shadows
    vssadmin create shadow /for=c:
    mklink /d C:\mountdir \\GLOBALROOT\?\Dev....

## Windows Backup
an error with windows backup

fixed with

    wbadmin delete catalog

# Hyper V
## Move Error

General Access Denied Error

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/759fda87-73c8-407c-8273-bfc430f251e8/hyperv_error.jpg](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/759fda87-73c8-407c-8273-bfc430f251e8/hyperv_error.jpg)

Resolved by giving the source machine explicit permissions to the destination share folder

A similar error can occur when copying virtual images and the virtual machine doesn't have permissions to access the image

[https://redmondmag.com/articles/2017/08/02/hyper-v-virtual-hard-disk-permission-problems.aspx](https://redmondmag.com/articles/2017/08/02/hyper-v-virtual-hard-disk-permission-problems.aspx)

    Get-VM 'New Virtual Machine' | Select-Object VMID
    # Copy vmid to $VMID$ below
    icacls imagename.vhd /grant $VMID$

## Powershell Commands

### Optimize-VHD

[https://docs.microsoft.com/en-us/powershell/module/hyper-v/optimize-vhd?view=win10-ps](https://docs.microsoft.com/en-us/powershell/module/hyper-v/optimize-vhd?view=win10-ps)

Can be used to reduce the size of dynamic disk images so that they are the size of the used disk space. There are multiple options, and I haven't tried it so I don't know which works best

### Convert-VHD

[https://docs.microsoft.com/en-us/powershell/module/hyper-v/convert-vhd?view=win10-ps](https://docs.microsoft.com/en-us/powershell/module/hyper-v/convert-vhd?view=win10-ps)

Convert between dynamic and fixed size disks

### Get-VHD

Lists out info about the VHD`