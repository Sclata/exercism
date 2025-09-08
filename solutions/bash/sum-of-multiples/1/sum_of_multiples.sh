#!/usr/bin/env bash

main () {
    declare -A multiples
    local sum=0

    local lvl=$1
    shift

    for i in "$@"; do
        [[ i -eq 0 ]] && continue || {
            iter=1
            while [[ $((iter*i)) -lt $lvl ]]; do
                multiples[$((iter*i))]=0
                (( iter++ ))
            done
        }
    done

    for val in "${!multiples[@]}"; do (( sum+=val )); done
    echo "$sum"
}

# call main with all of the positional arguments
main "$@"
