# Table of Contents
- [Engineering](#engineering)
  - [CFD](#cfd)
- [Programming](#programming)
  - [Rust](#rust)
  - [Job Queues](#job-queues)
- [Sys Admin](#sys-admin)
  - [Swap](#swap)
- [Software](#software)
  - [Multi-Platform](#multi-platform)
  - [Backup](#backup)
  - [Windows](#windows)

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
## Rust
### Parsing Libraries
- [nom](https://github.com/Geal/nom)
- [nom-packrat](https://github.com/dalance/nom-packrat)
  - Speeds up nom at the expense of memory usage
- [combine](https://github.com/Marwes/combine) 
  > "An implementation of parser combinators for Rust, inspired by the Haskell library Parsec"

### Miscellaneous
Get version number in code from cargo.toml
```
let version = env!("CARGO_PKG_VERSION");
```

## Job Queues

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
## Swap
If performance is the goal, over provision memory and disable swap. For vm host, be sure to disable in both host and guest. Next best option is to attach a small ssd for swap.

Swap can be disabled on a running linux system with 
```
swapoff -a
```
This can take a long time if the swap is heavily used as it needs to move everything in swap back to RAM.

To disable permanently, check `/etc/fstab` for swap partitions. (Not sure if there is another way swap can be set up)

# Software
## Multi-Platform
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Better version of grep

## Backup
- [borg](https://www.borgbackup.org/)

## Windows
- [Everything](https://www.voidtools.com/) - File Finder
  - Reads NTFS index and indexes entire disk. Much faster but requires admin
- [WizTree](https://antibody-software.com/web/software/software/wiztree-finds-the-files-and-folders-using-the-most-disk-space-on-your-hard-drive/) - Disk Usage
  - Reads NTFS index. Much faster but requires admin
- [Dependency Walker](http://dependencywalker.com/)
  - Look up DLL's used by program to track down execution errors due to missing library
