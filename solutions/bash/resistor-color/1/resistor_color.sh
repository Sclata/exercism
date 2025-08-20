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
    [[ $# -gt 2 || $# -lt 1 || ! $1 =~ ^(code|colors)$ ]] && { echo "Usage: [colors | code] <color>"; exit 1; }
    if [[ $1 == "code" ]]
        then [[ ${color_map["$2"]} == "" ]] && echo "Color not found." || echo "${color_map["$2"]}"
    else
        for color in "${!color_map[@]}"; do
            echo "$color ${color_map[$color]}"
        done | sort -k 2 -n | while read -r color; do
            echo "$color" | cut -d' ' -f1
        done
    fi
}

# call main with all of the positional arguments
main "$@"
