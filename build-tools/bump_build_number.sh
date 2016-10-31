#!/bin/sh

if [ $# -ne 1 ]; then
    echo usage: $0 plist-file
    exit 1
fi

plist="$1"
dir="$(dirname "$plist")"
prod="$(basename $dir)"

# Only increment the build number if source files have changed
if [ -n "$(find "$dir" \! -path "*xcuserdata*" \! -path "*.git" -newer "$plist")" ]; then
    buildnum=$(/usr/libexec/Plistbuddy -c "Print CFBundleVersion" "$plist")
    if [ -z "$buildnum" ]; then
        echo "No build number in $plist"
        exit 2
    fi
    buildnum=`printf "%d" $buildnum`
    buildnum=$(expr $buildnum + 1)
    buildnum=`printf "%d" $buildnum`
    /usr/libexec/Plistbuddy -c "Set CFBundleVersion $buildnum" "$plist"
    echo "Incremented $prod build number to $buildnum"
else
    echo "Not incrementing $prod build number as source files have not changed"
fi

