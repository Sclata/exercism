#!/usr/bin/env bash

# Errors that are checked:
# 1) No arguments
# 2) More than one argument
# 3) Float number argument
# 4) Alpha argument

# Error message: 'Usage: leap.sh <year>'

# Returns:
# 1) true -> if provided year is a leap year
# 2) false -> if provided year is not a leap year

main () {
    [[ $# -ne 1 || ! $1 =~ ^[0-9]+$ ]] && { echo "Usage: leap.sh <year>"; exit 1; }

    if [[ $(($1%400)) -eq 0 ]]
        then echo "true"
    elif [[ $(($1%4)) -eq 0 && $(($1%100)) -gt 0 ]]
        then echo "true"
    else
        echo "false"
    fi

    exit 0;
}

# call main with all of the positional arguments
main "$@"
