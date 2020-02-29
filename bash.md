# Bash

## File Descriptors

File descriptors can be useful to use to use a temporary file to write data to
during the running of a script and then to read it out at the end of the script.
For example to send it to a monitoring service in one command. The file
descriptors let you use builtin linux capabilities to guarantee that the
tempfile is cleaned up.

This is done by opening a read and write file descriptor and then deleting the
file, which removes its reference on the filesystem but doesn't actually delete
it until the file descriptors close which happens at the close of the program

Example

    tmpfile=$(mktemp /tmp/hc.XXXXXX)
    exec 3> "$tmpfile"
    exec 4< "$tmpfile"
    rm -f "$tmpfile"

    (
        echo command1 >&3 2>&1
        echo command2 >&3 2>&1

        cat <&4 | curl -fsS --retry 3 "HEALTHCHECK_URL" --data-binary "@-" > /dev/null

    )
