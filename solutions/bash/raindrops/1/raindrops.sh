#!/usr/bin/env bash

main () {
    num="$1"
    drops=""

    [[ $((num % 3)) -eq 0 ]] && drops="${drops}Pling"
    [[ $((num % 5)) -eq 0 ]] && drops="${drops}Plang"
    [[ $((num % 7)) -eq 0 ]] && drops="${drops}Plong"

    [[ ${#drops} -gt 0 ]] && echo "$drops" || echo "$num"
    exit 0;
}

# call main with all of the positional arguments
main "$@"
