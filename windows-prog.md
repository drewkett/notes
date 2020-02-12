## Anonymous Pipes

Unnamed pipes. Must pass handle directly other process. For subprocess that seems straightforward. Not sure about to other process

> When a child process inherits a pipe handle, the system enables the process to access the pipe. However, the parent process must communicate the handle value to the child process. The parent process typically does this by redirecting the standard output handle to the child process, as shown in the following steps:
Call the GetStdHandle function to get the current standard output handle; save this handle so you can restore the original standard output handle after the child process has been created.
Call the SetStdHandle function to set the standard output handle to the write handle to the pipe. Now the parent process can create the child process.
Call the CloseHandle function to close the write handle to the pipe. After the child process inherits the write handle, the parent process no longer needs its copy.
Call SetStdHandle to restore the original standard output handle.
The child process uses the GetStdHandle function to get its standard output handle, which is now a handle to the write end of a pipe. The child process then uses the WriteFile function to send its output to the pipe. When the child has finished with the pipe, it should close the pipe handle by calling CloseHandle or by terminating, which automatically closes the handle.

## Duplicate Handle

Use duplicate handle to copy handle to another process. You pass it the destination process pid and it creates a duplicate handle

> Normally the target process closes a duplicated handle when that process is finished using the handle. To close a duplicated handle from the source process, call DuplicateHandle with the following parameters:

## Handle

> Windows uses the HANDLE type for handle numbers. Though HANDLE is typedef'd to void *, a HANDLE is really just a 32-bit index. (Windows does not use a HANDLE as a pointer into the process's address space.)

> On Windows, to send a handle to another process, the sender will generally call two system calls:
Firstly, the sender must call DuplicateHandle() to copy the handle to the destination process. This requires the sender to have a process handle for the destination process. DuplicateHandle() will return a handle number indexing into the destination process's handle table.
Secondly, the sender must communicate the handle number to the destination process, e.g. by sending a message containing the number via a pipe using WriteFile().

## Named Pipes

If you use the same pipe name, no need to transfer data to connect between processes

- Multithreaded
    - One thread per connection
- Single Pipe
    - Drop connection after every message
- Synchronous
- Async
    - Multiple handles for a single thread. And then WaitForMultipleObjects to determine which one
- IO Completion (Overlapping calls to the same socket)

## Sockets

Lower level abstraction compared to named pipes

## Mailslots

Sounds like useful for small messages. Particularly if sending to multiple apps?

## Windows RPC

Microsofts rpc. Seems like its best if used with C# and Visual Studio

## File Mapping

Basically shared memory. Would need separate sync. Useful for large amounts of data

# Windows Service

[Service Entry Point - Windows applications](https://docs.microsoft.com/en-us/windows/desktop/Services/service-entry-point)

The service calls a main function that you must tell it out about when registering the service when it starts. 

There is also a controller function which handles signals for starting and stopping the service I believe
