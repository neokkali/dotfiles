#!/bin/bash

count=$(cliphist list | wc -l)

if [ "$count" -gt 0 ]; then
    echo "{\"text\":\"📋 $count\", \"tooltip\":\"Clipboard contains $count items\"}"
else
    echo "{\"text\":\"📋\", \"tooltip\":\"Clipboard is empty\"}"
fi
