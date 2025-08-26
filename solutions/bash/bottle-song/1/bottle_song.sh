#!/usr/bin/env bash

declare -a numbers=("No" "One" "Two" "Three" "Four" "Five" "Six" "Seven" "Eight" "Nine" "Ten")

valid_input () {
    if [[ $# -ne 2 ]] 
        then echo "2 arguments expected"; exit 1
    elif ! [[ "$1" =~ ^[0-9]*$ && "$2" =~ ^[0-9]*$ ]]
        then echo "arguments must be numeric"; exit 1
    elif [[ "$2" -gt "$1" ]]
        then echo "cannot generate more verses than bottles"; exit 1
    fi

    return 0
}

write_stanza () {
    local sub1 sub2
    [[ $1 -eq 1 ]] && sub1="bottle" || sub1="bottles"
    [[ $1 -eq 2 ]] && sub2="bottle" || sub2="bottles"
    
    echo "${numbers[$1]} green $sub1 hanging on the wall,"
    echo "${numbers[$1]} green $sub1 hanging on the wall,"
    echo "And if one green bottle should accidentally fall,"
    echo "There'll be ${numbers[(($1-1))],,} green $sub2 hanging on the wall."
}

main () {
    if valid_input "$@"
        then
            local loops=$2-1
            local stanza=$1-1
            local readout="$(write_stanza "$1")"
            while [[ "$loops" -gt 0 ]]
            do
                readout=$readout"\\n\\n$(write_stanza "$stanza")"
                loops=$loops-1
                stanza=$stanza-1
            done
    fi

    echo -e "$readout"
}

# call main with all of the positional arguments
main "$@"
