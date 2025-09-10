#!/usr/bin/env bash

main () {
    [[ $# -ne 3 ]] && {
        echo "Usage: <base_from> <dig_str> <base_to>"
        exit 1;
    }

    local base_from=$1 base_to=$3 base10=0 pow=0 new_bits=()
    IFS=" ", read -r -a bits <<< "$2"

    [[ $base_from -lt 2 || $base_to -lt 2 ]] && {
        echo "invalid base: base must be greater than 1"
        exit 1;
    }

    for ((i=${#bits[@]}-1; i>=0; i--)); do
        bval="${bits[i]}"
        [[ $bval -lt 0 || $bval -ge $base_from ]] && {
            echo "invalid bit value: must be between 0 and base-1"
            exit 1;
        }
        ((base10+=(bval*(base_from**(${#bits[@]}-1-i)))))
    done

    [[ $base10 -eq 0 ]] && { echo 0; exit 0; }
    
    pow=0
    while [[ $((base_to**pow)) -le $base10 ]]; do ((pow++)); done
    ((pow--))

    bval=$((base_to-1))
    while [[ $pow -ge 0 ]]; do
        if [[ $((bval*(base_to**pow))) -le $base10 ]]; then
            ((base10-=(bval*(base_to**pow))))
            new_bits+=("$bval")
            ((pow--))
            bval=$((base_to-1))
        elif [[ $bval -eq 0 ]]; then
            new_bits+=(0)
        else
            ((bval--))
        fi
    done

    echo "${new_bits[@]}"
    exit 0
}

# call main with all of the positional arguments
main "$@"
