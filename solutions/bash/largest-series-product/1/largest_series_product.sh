#!/usr/bin/env bash

# Checks for following errors:
# 1) Span exceeding string length
# 2) Non-numeric character in string
# 3) Negative Span

# Parameters:
# 1) String
# 2) Span

# Determines the largest product of each series of
# a certain span length in the input string.

main () {
    num_str="$1"
    span_len="$2"

    declare best_prod=0

    if [[ $span_len -gt ${#num_str} ]]
        then echo "span must not exceed string length"; exit 1;
    elif ! [[ $num_str =~ ^[0-9]+$ ]]
        then echo "input must only contain digits"; exit 1;
    elif [[ $span_len -lt 0 ]]
        then echo "span must not be negative"; exit 1;
    fi

    for (( i=0; i<=$((${#num_str}-span_len)); i++ ))
    do
        next_prod=1
        for (( j=0; j<span_len; j++ ))
        do
            next_prod=$((next_prod*"${num_str:i+j:1}"))
        done

        if [[ $next_prod -gt $best_prod ]]
            then best_prod=$next_prod
        fi
    done

    echo "$best_prod"
    exit 0
}
# call main with all of the positional arguments
main "$@"
