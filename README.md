# Table of Contents
- [Engineering](#engineering)
  - [CFD](#cfd)
- [Programming](#programming)
  - [Languages](#languages)
    - [Rust](./rust.md)
  - [Libraries](#libraries)
    - [Job Queues](#job-queues)
- [Sys Admin](#sys-admin)
  - [BTRFS](#btrfs)
  - [Swap](#swap)
- [Software](#software)
  - [Multi-Platform](#multi-platform)
  - [Backup](#backup)
  - [Windows](#windows)
  - [tmux](#tmux)

---

# Engineering
## CFD
- [FUN3D](https://fun3d.larc.nasa.gov/)
  - Unstructured Mesh CFD Solver
- [Wiliam Toet expains...CFD Post Processing](https://www.racetechmag.com/2019/02/willem-toet-explains-cfd-post-processing/)
  - Interesting artical on Post Processing with nice images

### Validation Cases
- [CFD-online](https://www.cfd-online.com/Links/refs.html#validation)
- [Drag Prediction Workshop](https://aiaa-dpw.larc.nasa.gov/)
  
# Programming
## Languages
- [Rust](./rust.md)

## Libraries
### Job Queues

- [RQ](https://github.com/rq/rq)
  - Python
  - redis
- [huey](https://github.com/coleifer/huey)
  - Python
  - redis, sqlite, in-memory
- [Simple postgres based one](jobqueue.py) ([Source](https://news.ycombinator.com/item?id=21942527))
  - Python
  - Postgres

# Sys Admin
## BTRFS
### COW (Copy On Write)
Make sure to disable COW for virtual machine images. `chattr +C {file}/{dir}` to disable. Disabling doesn't work for existing files. Run `lsattr {file}/{dir}` and look for `C` to confirm that its been disabled. To enable on an existing file, either create a new empty file, enable it and then copy the data over it, or enable it on a folder and make a copy of the file.

My understanding is that even with COW disabled, snapshots still function by temporarily enabling COW. I'm not sure what the implications are for VM types files and potential fragmentation. 

### incrbtrfs
[Github](https://github.com/drewkett/incrbtrfs)

My go program for creating regular snapshots of the filesystem and syncing them to another computer running btrfs

## Swap
If performance is the goal, over provision memory and disable swap. For vm host, be sure to disable in both host and guest. Next best option is to attach a small ssd for swap.

See swap partitions in use
```
cat /proc/swaps
```

Swap can be disabled on a running linux system with 
```
swapoff -a
```
This can take a long time if the swap is heavily used as it needs to move everything in swap back to RAM.

To disable permanently, comment out any `swap` partitions in `/etc/fstab`. (Not sure if there is another way swap can be set up)

# Software
## Multi-Platform
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Better version of grep

## Backup
- Open Source
  - [borg](https://www.borgbackup.org/)
    - Encrypted
    - Incremental
    - Compressed
  - [borgmatic](https://www.borgbackup.org/)
    - Python library to help automate borg backups
  - [incrbtrfs](#incrbtrfs)
- Commercial
  - [https://www.barracuda.com/products/backup](https://www.barracuda.com/products/backup)
    - Rack mounted appliance
      - Backs up Windows/Linux machines
        - Works ok. Intermittent failures that seem to resolve on next backup
        - Had issues where the dns got out of wack and caused a lot of issues.
        - Interface is clunky
        - On appliance deduplication/compression isn't impressive. Supposedly its due to it automatically turning it off when cpu is under load. Maybe a bigger appliance would not exhibit issues, but performance is tied to disk size I believe.
    - Cloud backup can back up cloud data (eg. O365)
      - Includes data in sharepoint, teams, emails, calendars
      - Seems to work. Backs up nightly. Intermittent failures, that may just be from attempting to back up files that have already been removed or something. Subsequent backups for some user seem to go ok, so haven't delved into it.
    - They also offer email security, which has been working well. 

## Windows
- [Everything](https://www.voidtools.com/) - File Finder
  - Reads NTFS index and indexes entire disk. Much faster but requires admin
- [WizTree](https://antibody-software.com/web/software/software/wiztree-finds-the-files-and-folders-using-the-most-disk-space-on-your-hard-drive/) - Disk Usage
  - Reads NTFS index. Much faster but requires admin
- [Dependency Walker](http://dependencywalker.com/)
  - Look up DLL's used by program to track down execution errors due to missing library

## tmux
I primarily use it to maintain long running processes on remote servers where I don't want the process to die if ssh connection dies. 

Default keyboard shortcut for most things is ctrl-b + ____

To split the terminal `ctrl-b + "` (Horizontal) or `ctrl-b + %` (Vertical). `ctrl-b + {Arrow Keys}` to switch between terminals

To exit a tmux session without closing the underlying process `ctrl-b + d`

To reattach to a previous tmux session
```
tmux a
```

