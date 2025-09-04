#!/usr/bin/env bash

main () {
    if (grep -q "[^ACGT]" <<< "$1"); then
        echo "Invalid nucleotide in strand"
        exit 1
    fi

    local A C G T

    A=0
    C=0
    G=0
    T=0

    for ((i=0; i<${#1}; i++)); do
        case ${1:i:1} in
            'A') (( A+=1 ));;
            'C') (( C+=1 ));;
            'G') (( G+=1 ));;
            'T') (( T+=1 ));;
        esac
    done

    printf "A: %s\nC: %s\nG: %s\nT: %s" "$A" "$C" "$G" "$T"
}

# call main with all of the positional arguments
main "$@"
