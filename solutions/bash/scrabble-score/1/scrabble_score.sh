#!/usr/bin/env bash

declare -A letter_scores=(
    ["A"]=1 ["B"]=3 ["C"]=3 ["D"]=2 ["E"]=1 ["F"]=4 \
    ["G"]=2 ["H"]=4 ["I"]=1 ["J"]=8 ["K"]=5 ["L"]=1 \
    ["M"]=3 ["N"]=1 ["O"]=1 ["P"]=3 ["Q"]=10 ["R"]=1 \
    ["S"]=1 ["T"]=1 ["U"]=1 ["V"]=4 ["W"]=4 ["X"]=8 \
    ["Y"]=4 ["Z"]=10
)

is_alpha () {
    local normalized
    
    normalized=$( echo "$1" | tr -cd '[:alpha:]' )
    [[ ${#normalized} -eq ${#1} ]] && return 0 || return 1
}

arg_count_valid () {
    [[ $# -eq 1 ]] && return 0 || return 1
}

calc_score () {
    local score=0
    for (( i=0; i<${#1}; i++ )); do
        ((score+=${letter_scores[${1:$i:1}]}))
    done

    echo "$score"
    return 0
}

upper () {
    echo "$1" | tr '[:lower:]' '[:upper:]'
    return 0
}

main () {
    if arg_count_valid "$@" && is_alpha "$1" 
        then 
            calc_score "$(upper "$1")"
            return 0
    fi 

    return 1
}

# call main with all of the positional arguments
main "$@"
