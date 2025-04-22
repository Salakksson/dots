#!/bin/sh

find "$@" -maxdepth 1 -type f,d \
 | while read -r filename; do
        pacman -Qo "$filename" > /dev/null 2>&1 
        not_owned=$?
        if [ $not_owned -eq 1 ]; then
                echo "$filename"
        fi
done
