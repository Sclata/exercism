#!/usr/bin/env bash

is_prime () {
    sqrt=$(bc <<< "sqrt($1)+1")
    for ((i=2; i<sqrt; i++)); do
        if [[ $(($1%i)) -eq 0 ]]; then
            return 1
        fi
    done
    return 0
}

main () {
    local quotient="$1" i=2

    while [[ quotient -gt 1 ]]; do
        if [[ $((quotient%i)) -eq 0 ]]; then
            quotient=$((quotient/i))
            if (is_prime $i); then
                [[ quotient -ne 1 ]] && echo -n "$i " || echo -n "$i"
            fi
        else
            ((i++))
        fi
    done
}

# call main with all of the positional arguments
main "$@"
