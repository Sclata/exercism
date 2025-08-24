#!/usr/bin/env bash

main () {
    A=$(echo "${1:1:-1}" | tr -d '[:space:]')
    B=$(echo "${2:1:-1}" | tr -d '[:space:]')

    if [ "$A" = "$B" ]
        then echo "equal"
    elif [[ "$A," == *"$B,"* || $B == '' ]]
        then echo "superlist"
    elif [[ "$B," == *"$A,"* || $A == '' ]]
        then echo "sublist"
    else
        echo "unequal"
    fi
}

# call main with all of the positional arguments
main "$@"
