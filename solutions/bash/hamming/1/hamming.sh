#!/usr/bin/env bash

usage_error () {
    echo "Usage: $(basename "$0") <string1> <string2>"
}

partial_error () {
    echo "--partial \"strands must be of equal length\""
}

main () {
    if [[ $# -ne 2 ]] 
        then usage_error; exit 1;
    elif [[ ${#1} -ne ${#2} ]]
        then partial_error; exit 1;
    else
        differences=0
        for (( i=0; i<${#1}; i++ ));
        do
            [[ ${1:$i:1} != "${2:$i:1}" ]] && differences=$(("$differences"+1))
        done
    fi

    echo "$differences"
    exit 0
}

# call main with all of the positional arguments
main "$@"
