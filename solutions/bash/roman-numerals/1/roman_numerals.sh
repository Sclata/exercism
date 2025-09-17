#!/usr/bin/env bash

main () {

    set -f

    declare -A numerals=(
        ["1000"]="M"
        ["900"]="CM"
        ["500"]="D"
        ["400"]="CD"
        ["100"]="C"
        ["90"]="XC"
        ["50"]="L"
        ["40"]="XL"
        ["10"]="X"
        ["9"]="IX"
        ["5"]="V"
        ["4"]="IV"
        ["1"]="I"
    )

    result=""
    leftover=$1

    sorted_nums=($(for k in "${!numerals[@]}"; do echo "$k"; done | sort -rn))

    while [[ $leftover -gt 0 ]]; do
        for val in "${sorted_nums[@]}"; do
            while [[ $leftover -ge $val ]]; do
                result="$result${numerals[$val]}"
                ((leftover-=val))
            done
        done
    done
    
    echo "$result"
}

# call main with all of the positional arguments
main "$@"
