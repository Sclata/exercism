#!/usr/bin/env bash

main () {

    [[ $# -ne 2 ]] && { echo "Usage: [encode|decode] <str>"; exit 1; }

    local result
    
    result=$(
        tr -cd '[:digit:][:alpha:]' <<< "${2,,}" |
        tr "abcdefghijklmnopqrstuvwxyz" "zyxwvutsrqponmlkjihgfedcba"
    )

    [[ "$1" == "encode" ]] && result=$(fold -w5 <<< "$result")
    echo $result

    exit 0
}

# call main with all of the positional arguments
main "$@"
