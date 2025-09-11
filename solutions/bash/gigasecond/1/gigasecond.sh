#!/usr/bin/env bash

# 1 gigasecond = 1_000_000_000 seconds

main () {
    local FRMT cal_date
    FRMT='%Y-%m-%dT%H:%M:%S'
    cal_date=$(($(date -u --date="$1" +"%s")+1000000000))
    
    date -u --date="@$cal_date" +"$FRMT"
}

# call main with all of the positional arguments
main "$@"
