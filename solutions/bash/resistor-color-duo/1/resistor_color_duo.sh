#!/usr/bin/env bash

declare -A color_map

color_map["black"]=0
color_map["brown"]=1
color_map["red"]=2
color_map["orange"]=3
color_map["yellow"]=4
color_map["green"]=5
color_map["blue"]=6
color_map["violet"]=7
color_map["grey"]=8
color_map["white"]=9

main () {
    local val=""
    for param in "$@";
    do
        [[ ${color_map[$param]} == "" ]] && { echo "invalid color"; exit 1; } || val+=${color_map[$param]}
        [[ ${#val} -eq 2 ]] && break
    done

    echo "$val" | sed 's/^0//'
    exit 0;
}

# call main with all of the positional arguments
main "$@"
