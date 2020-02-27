#!/bin/bash
# This is a script to wrap another script in call to healthchecks.io and pass the response as data

hc_id="$1"
cmd="${@:2}"
tmpfile=$(mktemp /tmp/hc.XXXXXX)

(
curl -fsS --retry 3 https://hc-ping.com/$hc_id/start > /dev/null

$cmd &> $tmpfile

curl -fsS --retry 3 "https://hc-ping.com/$hc_id$([ $? -ne 0 ] && echo -n /fail)" --data "@$tmpfile" > /dev/null

)

rm "$tmpfile"
