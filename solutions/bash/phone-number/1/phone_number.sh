#!/usr/bin/env bash

main () {
    nums=$(tr -cd '[:digit:]' <<< "$1")
    if (grep -qE "^1?[2-9][0-9]{2}[2-9][0-9]{6}$" <<< "$nums"); then
        echo "${nums: -10}"
        exit 0
    else
        echo "Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9"
        exit 1
    fi
}

# call main with all of the positional arguments
main "$@"
