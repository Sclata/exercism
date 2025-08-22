#!/usr/bin/env bash

# Looks for anything not in the DNA nucleotide set.
# Usage: is_valid_sequence <sequence>.
is_valid_sequence () {
    [[ $1 =~ ^[GCTA]+$ ]] && return 0 || return 1
}

valid_number_args () {
    [[ $# -lt 2 ]] && return 0 || return 1
}

main () {
    declare -A nucleotide_map;

    local RNA=""

    nucleotide_map["G"]="C"
    nucleotide_map["C"]="G"
    nucleotide_map["T"]="A"
    nucleotide_map["A"]="U"

    if valid_number_args "$@"
        then if [[ $# -eq 0 ]]
            then return 0;
        elif is_valid_sequence "$1"
            then for (( i=0; i<${#1}; i++ )); do
                RNA+=${nucleotide_map[${1:i:1}]}
            done
        else
            echo "Invalid nucleotide detected."; return 1;
        fi
    else
        echo "Usage: rna_transcription.sh <DNA_STRAND_STR>"; return 1;
    fi

    echo "$RNA"
    return 0;
}

# call main with all of the positional arguments
main "$@"
