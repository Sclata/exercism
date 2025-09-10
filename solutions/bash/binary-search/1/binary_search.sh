#!/usr/bin/env bash

main () {
    local search_val=$1 inpt=() ref=0 arg_lngth mid_indx
    shift

    while true; do
        inpt=("$@")
        arg_lngth="${#inpt[@]}"
        mid_indx=$((arg_lngth/2))
        
        if [[ ${inpt[$mid_indx]} -eq $search_val ]]; then
            echo "$((ref+mid_indx))"
            break
        elif [[ $arg_lngth -lt 2 ]]; then
            echo "-1"
            break
        elif [[ ${inpt[$mid_indx]} -gt $search_val ]]; then
            set -- "${inpt[@]:0:$mid_indx}"
        else
            ((ref+=mid_indx))
            set -- "${inpt[@]:$mid_indx:$arg_lngth}"
        fi 
    done

    exit 0
}

# call main with all of the positional arguments
main "$@"
