#!/usr/bin/env bash

main () {
    alpha=$( echo "$1" | tr -cd '[:alpha:]' | tr '[:upper:]' '[:lower:]' | fold -w 1 | sort | uniq | wc -l )

    [[ $alpha -eq 26 ]] && echo "true" || echo "false"
}

# call main with all of the positional arguments
main "$@"
