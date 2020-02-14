# KVM

## libvirt

### Installing ubuntu from command line

virt-install --name=ubuntu --memory=4096 --vcpus=2
--disk=/var/lib/libvirt/images/test.qcow2 --graphics=none
--console=pty,target_type=serial --location
[http://us.archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/](http://us.archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/)
--extra-args 'console=ttyS0' --os-type=linux --network bridge=br0

Need to set up bridge before. May need to setup deisk

if characters are messed up run inside tmux

## QCOW vs Raw

### Links

This is a bunch of links discussing tradeoffs with using QCOW vs Raw images

[https://askubuntu.com/questions/1074415/virtual-machine-best-practices-and-raw-vs-qcow2](https://askubuntu.com/questions/1074415/virtual-machine-best-practices-and-raw-vs-qcow2)

[https://heiko-sieger.info/tuning-vm-disk-performance/](https://heiko-sieger.info/tuning-vm-disk-performance/)

[https://serverfault.com/questions/677639/which-is-better-image-format-raw-or-qcow2-to-use-as-a-baseimage-for-other-vms](https://serverfault.com/questions/677639/which-is-better-image-format-raw-or-qcow2-to-use-as-a-baseimage-for-other-vms)

[https://serverfault.com/questions/407842/incredibly-low-kvm-disk-performance-qcow2-disk-files-virtio](https://serverfault.com/questions/407842/incredibly-low-kvm-disk-performance-qcow2-disk-files-virtio)

[https://serverfault.com/questions/277294/what-kvm-disk-type-to-use](https://serverfault.com/questions/277294/what-kvm-disk-type-to-use)

[https://doc.ispsystem.com/index.php/Comparison_of_local_storage_performance](https://doc.ispsystem.com/index.php/Comparison_of_local_storage_performance)

## Disk Migration

[https://kashyapc.wordpress.com/2014/07/06/live-disk-migration-with-libvirt-blockcopy/](https://kashyapc.wordpress.com/2014/07/06/live-disk-migration-with-libvirt-blockcopy/)

This method is needed for raw images

- dumpxml to backup config
- undefine vm to make it transient (the vm will still run but will disappe

This failed for me. Another page indicated that it might work with cache=none.
My guess is its related to using raw images

There is an updated method for this when using qcow2 images

## VM Config Files

1. XML files in /var/run/libvirt/qemu are the current in memory ones – same
   thing dumpxml would show.
2. XML files in /etc/libvirt/qemu are the real config files.
   - these files can only be edited properly by virsh edit or by having the VM
     machine off and editing the files manually.

Any changes from command line not executed with “--persistent” will only remain
in the memory side and will appear in the /var/run/libvirt/qemu xml files. This
appears to survive a reboot of the VM but will not survive a shutdown and
restart. What threw me for a bit of a loop was that the host was saving and
pausing VM state and on reboot simply resumed them which made it appear to have
kept the changes.

## Snapshots

Snapshots are generally not advised in production systems as they add a layer of
indirection. Exceptions to this are temporary

### qemu agent

Needed to run snapshots with —quiesce option which helps get consistent disk
image

Needs setup in xml file
[https://wiki.libvirt.org/page/Qemu_guest_agent](https://wiki.libvirt.org/page/Qemu_guest_agent)

# General

It can be useful to write zeros to the empty space in a virtual disk image

- If you're disk image is a dynamically sized image such as QCOW, writing zeros
  from the empty space should deallocate disk space from the disk image or free
  it up for other uses

## Windows

On windows, this can be accomplished with `sdelete` which is a sysinternals
utility

[Download](https://docs.microsoft.com/en-us/sysinternals/downloads/sdelete)

```
sdelete -z c:
```

## Linux

On linux, there is a utilty called zerofree that is should be available in any
package manager. Alternatively you can just start writing zeros to a file with
`dd` until the disk fills up and then delete the file. Though you want to be
careful doing that on an active system since it may cause other issues, so
probably best to not do it for the entire disk size
