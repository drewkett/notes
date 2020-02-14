# Rescue Data from Failing Disk (ddrescue)

If a disk is failing the first step is to try to get a full copy of as much of
the data as possible

[Ddrescue - ForensicsWiki](https://www.forensicswiki.org/wiki/Ddrescue)

The commands below should be run one after the other with the same image and log
file. ddrescue is smart enough to use the log file to try to recover parts of
the disk it wasn't able to/

### **Kernel 2.6.3+ & ddrescue 1.4+**

`ddrescue --direct` will open the input with the `O_DIRECT` option for uncached
reads. 'raw devices' are not needed on newer kernels. For older kernels see
below.

First you copy as much data as possible, without retrying or splitting sectors:

    ddrescue --no-split /dev/hda1 imagefile logfile
    # --no-split got changed to --no-scrape at some point
    # ddrescue --no-scrape /dev/hda1 imagefile logfile

Now let it retry previous errors 3 times, using uncached reads:

    ddrescue --direct --max-retries=3 /dev/hda1 imagefile logfile

If that fails you can try again but retrimmed, so it tries to reread full
sectors:

    ddrescue --direct --retrim  --max-retries=3 /dev/hda1 imagefile logfile

# Speed things up

To speed things up (from
[https://unix.stackexchange.com/questions/366901/faster-disk-recovery-ddrescue-running-slow](https://unix.stackexchange.com/questions/366901/faster-disk-recovery-ddrescue-running-slow)**)**

     --min-read-rate=10M

If you specify it on your command line with a decent size like `10M`, with any
luck, areas that are still able to read but extremely slow will be skipped
first, and continue with other areas the drive is still able to read
performantly.

Depending on how much is missing in the end, you can still follow it up with a
slow pass afterwards.

It's also possible to run `ddrescue` in `--reverse` mode or force it to start at
a specific offset with `--input-position=X` so if `ddrescue` doesn't skip into a
faster region by itself you can force it to do that manually.

# Erase disk (zero out)

    ddrescue /dev/zero /dev/sdX zero.log -f -n
