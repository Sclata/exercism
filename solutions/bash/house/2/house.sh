#!/usr/bin/env bash

declare -a subj
declare -a action

subj=(
    "house that Jack built."
    "malt"
    "rat"
    "cat"
    "dog"
    "cow with the crumpled horn"
    "maiden all forlorn"
    "man all tattered and torn"
    "priest all shaven and shorn"
    "rooster that crowed in the morn"
    "farmer sowing his corn"
    "horse and the hound and the horn"
)

action=(
    "lay in"
    "ate"
    "killed"
    "worried"
    "tossed"
    "milked"
    "kissed"
    "married"
    "woke"
    "kept"
    "belonged to"
)

# Using iteration...
main () {

    local begin=$(($1-1))
    local end=$(($2-1))

    [[ $begin -gt 11 || $begin -lt 0 ]] || [[ $end -gt 11 || $end -lt 0 ]] && { echo "invalid"; exit 1; }

    local outpt=""

    for (( i=begin; i<=end; i++ ));
    do
        outpt+="\nThis is the ${subj[$i]}\n"
        for (( j=i-1; j>=0; j-- ));
        do
            outpt+="that ${action[$j]} the ${subj[$j]}\n"
        done
    done

    echo -e "$outpt" | sed '1d'
}

# call main with all of the positional arguments
main "$@"

