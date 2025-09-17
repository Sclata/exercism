#!/usr/bin/env bash

main () {
    local normalized word c r
    
    normalized=$(tr -cd '[:digit:][:alpha:]' <<< "${1,,}")
    c=$(bc <<< "sqrt(${#normalized})")

    if [[ $((c*c)) -ge ${#normalized} ]]; then r=$c
    elif [[ $((c*(c+1))) -ge ${#normalized} ]]; then r=$((c++))
    else r=$((++c))
    fi
    
    for ((col=0; col<c; col++)); do
        word=""
        for ((row=0; row<r; row++)); do
            [[ $((col+row*c)) -lt ${#normalized} ]] &&
                word="$word${normalized:$((col+row*c)):1}" ||
                word="$word "
        done
        echo "$word"
    done | tr "\n" " " | sed 's/.$//'
}

# call main with all of the positional arguments
main "$@"
