#!/usr/bin/env bash

main () {
    local char count

    if [[ "$1" == "encode" ]]; then
        char=${2:0:1}; count=1
        for ((i=1; i<${#2}; i++)); do
            if [[ ${2:$i:1} == "$char" ]]; then ((count+=1))
            elif ((count==1)); then { echo -n "$char"; char=${2:$i:1}; }
            else { echo -n "${count}${char}"; char=${2:$i:1}; count=1; }
            fi
        done
        (( count == 1 )) && echo -n "$char" || echo -n "${count}${char}"
    elif [[ $1 == "decode" ]]; then
        count=""
        for ((i=0; i<${#2}; i++)); do
            if [[ ${2:$i:1} =~ [0-9] ]]; then count="${count}${2:$i:1}"
            elif [[ $count == "" ]]; then echo -n "${2:$i:1}"
            else { printf "${2:$i:1}%.0s" $(seq 1 "$count"); count=""; }
            fi
        done
    fi
    exit 0
}

# call main with all of the positional arguments
main "$@"
