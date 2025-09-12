#!/usr/bin/env bash

main () {
    declare -A students=(
        ["Alice"]=0
        ["Bob"]=2
        ["Charlie"]=4
        ["David"]=6
        ["Eve"]=8
        ["Fred"]=10
        ["Ginny"]=12
        ["Harriet"]=14
        ["Ileana"]=16
        ["Joseph"]=18
        ["Kincaid"]=20
        ["Larry"]=22
    )

    declare -A plants=(
        ["C"]="clover"
        ["G"]="grass"
        ["R"]="radishes"
        ["V"]="violets"
    )

    local student=${students[$2]}
    declare -a pots=()
    while IFS=$'\n' read -r row; do
        pots+=("${plants[${row:student:1}]}")
        pots+=("${plants[${row:((student+1)):1}]}")
    done <<< "$1"

    echo "${pots[@]}"
}

# call main with all of the positional arguments
main "$@"
