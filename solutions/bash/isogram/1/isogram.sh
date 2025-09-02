#!/usr/bin/env bash

main () {
    if [ "$(tr -cd '[:alpha:]' <<< "$1" | grep -icE "([^-])(.*)(\1)")" -gt 0 ]
        then echo "false"
    else
        echo "true"
    fi
}

# call main with all of the positional arguments
main "$@"
