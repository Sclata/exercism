#!/usr/bin/env bash

main () {

    [[ $# -ne 2 ]] && { echo "Usage: [encode|decode] <str>"; exit 1; }

    local result
    
    result=$(
        tr -cd '[:digit:][:alpha:]' <<< "${2,,}" |
        tr "abcdefghijklmnopqrstuvwxyz" "zyxwvutsrqponmlkjihgfedcba"
    )

    case $1 in
        "encode") 
            fold -w5 <<< "$result";;
        "decode") 
            echo "$result";;
        *) 
            echo "Usage: [encode|decode] <str>"; exit 1;;
    esac

    exit 0
}

# call main with all of the positional arguments
main "$@"
