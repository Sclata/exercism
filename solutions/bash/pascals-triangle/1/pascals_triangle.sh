#!/usr/bin/env bash

main () {
    [[ $# -ne 1 ]] && {
        echo "USAGE: $0 <whole_num>"
        exit 1
    }

    if [[ $1 -eq 0 ]]; then { echo ""; exit 0; }; fi
    if [[ $1 -eq 1 ]]; then { echo "1"; exit 0; }; fi

    declare -a current_row=(1) previous_row=()
    local -i row=0 padding=0 line_length=$((2*$1-1))

    while [[ $row -lt $1 ]]; do
        # Set padding for print format and then print current row.
        padding=$((((line_length-1)/2)-row))
        if [[ $padding -eq 0 ]]; then 
            echo "${current_row[*]}" 
        else 
            printf "%${padding}s%s\n" " " "${current_row[*]}" 
        fi

        # Set current row as previous and then build new current row.
        previous_row=("${current_row[@]}")
        current_row=(1)
        for ((i=0;i<${#previous_row[@]};i++)); do
            current_row+=($(("${previous_row[$((i))]:-0}" + "${previous_row[$((i+1))]:-0}")))
        done
        ((row++))
    done
}

# call main with all of the positional arguments
main "$@"
