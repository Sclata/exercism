#!/usr/bin/env bash

main () {
    declare -A band_color=(
        ["black"]=0
        ["brown"]=1
        ["red"]=2
        ["orange"]=3
        ["yellow"]=4
        ["green"]=5
        ["blue"]=6
        ["violet"]=7
        ["grey"]=8
        ["white"]=9
    )

    [[ ! $# -gt 2 ]] && { echo "Usage: <color> <color> <color>"; exit 1; }
    
    local digit1=${band_color["$1"]}
    local digit2=${band_color["$2"]}
    local power=${band_color["$3"]}
    local trail_zeros

    [[ $digit2 -eq 0 && $digit1 -ne 0 ]] && trail_zeros=$((power+1)) || trail_zeros=$power

    [[ $digit1 = "" || $digit2 = "" || $power = "" ]] && { echo "Bad band color..."; exit 1; }

    local ohms

    # Divide by 1 to resolve leading zeros...
    ohms=$(bc <<< "(($digit1$digit2) / 1) * (10 ^ $power)")

    case $((trail_zeros/3)) in 
        0) echo "$((ohms/1)) ohms";;
        1) echo "$((ohms/1000)) kiloohms";;
        2) echo "$((ohms/1000000)) megaohms";;
        *) echo "$((ohms/1000000000)) gigaohms";;
    esac
    
    exit 0
}

# call main with all of the positional arguments
main "$@"
