#!/usr/bin/env bash

valid_input () {
    if [[ $# -ne 1 || $1 -lt 1 ]]
        then echo "Error: Only positive numbers are allowed" && exit 1
    fi
    return 0
}

calc_next_number () {
    [[ $(($1%2)) -eq 0 ]] && echo $(($1 / 2)) || echo $(($1 * 3 + 1)) 
}

main () {
    if valid_input "$@"
        then
            count=0
            local val=$1
            while [[ $val -gt 1 ]]
            do
                val=$(calc_next_number "$val")
                count=$((count+1))
            done
            echo "$count"
    fi
    exit 0
}

# call main with all of the positional arguments
main "$@"
