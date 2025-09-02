#!/usr/bin/env bash

main () {
    tmp=$(echo "obase=2; $1" | bc | sed 's/0//g')
    echo "${#tmp}"
}

# call main with all of the positional arguments
main "$@"
