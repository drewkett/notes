# Utilities

## Multi Platform

### watchexec

Useful utility for watching for changes on the file system and then running a
command after such as a build tool

[GitHub Link](https://github.com/watchexec/watchexec)

## Windows

### handle

`handle` is a part of SysInternals. It lists out all of the open file handles
used by the system by default

`handle`

You can put a file prefix to see only handles in that folder

`handle C:\blah\blah`

It can close a handle with. This is useful if a file is locked and can't be
deleted

`handle -c HANDLEID -f PROCESSID`
