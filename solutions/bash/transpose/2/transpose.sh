#!/usr/bin/env bash

main () {
    declare -a out=()
    local -i max_len=0 row=0 min_len
    while IFS=$'\n' read -r line; do
        (( ${#line} > max_len )) && max_len=${#line}
        [[ ${#line} -lt $min_len || -z ${min_len+x} ]] && min_len=${#line}
        for ((i=0; i<${#line}; i++)); do
            if (( i >= min_len )); then
                for ((j=min_len; j<=i; j++)); do
                    ((${#out[j]} < row)) && 
                        out[j]=$(printf "${out[j]}%*s" "$((row-${#out[j]}))" '')
                done
            fi
            out[i]+="${line:$i:1}"
        done
        ((row+=1))
    done
    
    for l in "${out[@]}"; do echo "$l"; done
}

# call main with all of the positional arguments
main "$@"
