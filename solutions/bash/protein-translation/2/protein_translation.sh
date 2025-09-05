#!/usr/bin/env bash

main () {
    declare -A codon_acid_map=(
        ["AUG"]="Methionine"
        ["UUU"]="Phenylalanine"
        ["UUC"]="Phenylalanine"
        ["UUA"]="Leucine"
        ["UUG"]="Leucine"
        ["UCU"]="Serine"
        ["UCC"]="Serine"
        ["UCA"]="Serine"
        ["UCG"]="Serine"
        ["UAU"]="Tyrosine"
        ["UAC"]="Tyrosine"
        ["UGU"]="Cysteine"
        ["UGC"]="Cysteine"
        ["UGG"]="Tryptophan"
        ["UAA"]="STOP"
        ["UAG"]="STOP"
        ["UGA"]="STOP"
    )

    local response="" amino=""

    for ((i=0; i<${#1}; i+=3)); do
        amino=${codon_acid_map[${1:$i:3}]}
        if [[ $amino = "" && $1 != "" ]]; then
            echo "Invalid codon"
            exit 1
        elif [[ $amino = "" || $amino = "STOP" ]]; then
            break
        else
            [[ $response = "" ]] && response="$amino" || response="$response $amino"
        fi
    done
    echo "$response"
    exit 0
}

# call main with all of the positional arguments
main "$@"
