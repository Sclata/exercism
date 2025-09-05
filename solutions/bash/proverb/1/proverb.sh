#!/usr/bin/env bash

main () {
    local last_verse args

    args=$#
    [[ $args -gt 0 ]] && last_verse="And all for the want of a $1." || last_verse=""

    for ((i=2; i<=args; i++)); do
        echo "For want of a $1 the $2 was lost."
        shift
    done

    echo "$last_verse"
}

# call main with all of the positional arguments
main "$@"
