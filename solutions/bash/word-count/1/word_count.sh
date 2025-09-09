#!/usr/bin/env bash

main () {
    echo "${1,,}" | 
    grep -oE "[0-9a-zA-Z]+('[0-9a-zA-Z]+)?" | 
    sort | 
    uniq -c |
    awk '{printf("%s: %s\n",$2,$1)}'
}

# call main with all of the positional arguments
main "$@"
