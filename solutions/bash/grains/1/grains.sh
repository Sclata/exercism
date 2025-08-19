#!/usr/bin/env bash

# Input can either be a number or the word 'total':
#       If number: return grains of rice on THAT square.
#       If 'total': return total grains on board.

# If the number is less than 1 or greater than 64, throw an error of form:
#       Error: invalid input

main () {
    if [[ $# -ne 1 ]]
        then echo "Error: invalid input"; exit 1;
    elif [[ $1 == "total" ]]
        then bc <<< "2 ^ 64 - 1"
    elif [[ $1 == +([0-9]) && $1 -gt 0 && $1 -lt 65 ]]
        then bc <<< "2 ^ ($1 - 1)"
    else
        echo "Error: invalid input"; exit 1;
    fi

    exit 0;
}

# call main with all of the positional arguments
main "$@"
