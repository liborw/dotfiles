#!/bin/bash

# Web change detection

INTERVAL=10
URL=$1
RUN="0"

while :
do
    wget $URL -O new.html &>/dev/null
    if [ -f old.html ]; then
        CHANGE=`diff new.html old.html | diffstat -q`
        if [ -z "$CHANGE" ]; then
            echo "No change detected"
        else
            echo "$CHANGE"
            rm -rf new.html old.html
            exit 0
        fi
    fi
    mv new.html old.html
    sleep $INTERVAL
done
