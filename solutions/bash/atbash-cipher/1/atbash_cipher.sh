#!/usr/bin/env bash

main () {

    [[ $# -ne 2 ]] && { echo "Usage: [encode|decode] <str>"; exit 1; }

    local result
    
    result=$(
        tr -cd '[:digit:][:alpha:]' <<< "${2,,}" |
        tr "abcdefghijklmnopqrstuvwxyz" "zyxwvutsrqponmlkjihgfedcba"
    )

    case $1 in
        "encode") 
            for ((i=0;i<$((${#result}-5)); i+=5)); do 
                echo -n "${result:$i:5} "; 
            done
            [[ $((${#result}%5)) -eq 0 ]] &&
                echo "${result:$((${#result}-5)):5}" ||
                echo "${result:$((${#result}-(${#result}%5))):$((${#result}%5))}";;
        "decode") 
            echo "$result";;
        *) 
            echo "Usage: [encode|decode] <str>"; exit 1;;
    esac

    exit 0
}

# call main with all of the positional arguments
main "$@"
