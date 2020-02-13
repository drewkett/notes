# MQL

MQL is the graph query language underlying Dassault Systemes 3DX

## Permissions

You need to authenticate in some way before you can view data

Use the following to get admin privileges

    set context user creator;

## sql

To view the underlying sql calls use

    trace type sql on;

It seems to be local to the mql session so shouldn't interfere with performance.
And to turn off tracing

    trace type sql off;

## TCL

And embedded tcl executable can be used from mql via

    tcl;

This starts an interactive tcl session. `mql` can be used as a command in this
mode and everything after is run as an mql command with the value returned to
tcl. Many of the mql commands have a `tcl` option that outputs any data in a
properly escaped tcl format that tcl can interprate as arrays. its a little bit
odd sometimes since sometimes the results are fairly nested which leads to a lot
of `lindex` calls to extract the values.

## Record Separators

For interacting with mql from another program, its useful to use unique
separators for fields and records. Any ascii character can be used such as the
record separator byte 31. This simplifies parsing since they shouldn't overlap
with any return data

## eventmonitor

An eventmonitor is a sort of like a queue where you can track all changes to
certain object types.

This would create an eventmonitor to track any changes to business objects

    add eventmonitor NAME event businessobject all;

To view the events

    list eventmonitor NAME select events dump;

This can be parsed by splitting by '\n' for records and '|' for individual
fields. The object id that was affected is field 4

The object can be viewed

    print bus ID;

This would create an eventmonitor to track any changes to relationships

    add eventmonitor NAME event relationship all;

The object id in this case would be a connection id

    print connection ID;

### Event Loss

I'm still not sure how to clear the event monitor in a way that you don't risk
events being added since the last time list was run.

## query

The performance of a query is very dependent on whether the query translates
directly to sql commands or if post processing has to be done by the MQL kernel
before returning data. Pay attention to
