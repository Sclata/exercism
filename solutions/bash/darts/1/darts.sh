#!/usr/bin/env bash

valid_input() {
    if [[ $# -ne 2 ]] || ! [[ $1 =~ ^[+-]?([0-9]*[.])?[0-9]+ ]] || ! [[ $2 =~ ^[+-]?([0-9]*[.])?[0-9]+ ]]
        then printf "Usage: darts.sh d1 d2" && exit 1;
    fi
    return 0
}

calc_rad() {
    echo "sqrt(($1 ^ 2) + ($2 ^ 2))" | bc -l
}

main () {
    if valid_input "$@"
        then
            dist=$(calc_rad "$1" "$2")
            if (( $(echo "$dist <= 1" | bc) ))
                then echo "10"
            elif (( $(echo "$dist <= 5" | bc) ))
                then echo "5"
            elif (( $(echo "$dist <= 10" | bc) ))
                then echo "1"
            else
                echo "0"
            fi
    fi

    exit 0;
}

# call main with all of the positional arguments
main "$@"
