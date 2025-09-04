#!/usr/bin/env bash

main () {

    [[ "$1" -lt 1 ]] && echo "Classification is only possible for natural numbers." && exit 1;

    loop_end=$(bc <<< "sqrt($1)")
    local fac_sum=0

    for ((i=1; i<=loop_end; i++)); do
        if [[ i -ne $1 && $(($1%i)) -eq 0 ]]; then
            if [[ i -eq $(($1/i)) ]]; then
                ((fac_sum += i))
            else
                ((fac_sum += (i + ($1/i))))
            fi
        fi
    done

    (( fac_sum -= $1 ))

    if [[ $fac_sum -lt $1 ]]; then
        echo "deficient"
    elif [[ $fac_sum -gt $1 ]]; then
        echo "abundant"
    else
        echo "perfect"
    fi

}

# call main with all of the positional arguments
main "$@"
