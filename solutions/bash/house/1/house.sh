#!/usr/bin/env bash

declare -a subj
declare -a action

subj[0]="house that Jack built."
subj[1]="malt"
subj[2]="rat"
subj[3]="cat"
subj[4]="dog"
subj[5]="cow with the crumpled horn"
subj[6]="maiden all forlorn"
subj[7]="man all tattered and torn"
subj[8]="priest all shaven and shorn"
subj[9]="rooster that crowed in the morn"
subj[10]="farmer sowing his corn"
subj[11]="horse and the hound and the horn"

action[0]="lay in"
action[1]="ate"
action[2]="killed"
action[3]="worried"
action[4]="tossed"
action[5]="milked"
action[6]="kissed"
action[7]="married"
action[8]="woke"
action[9]="kept"
action[10]="belonged to"

canned_error() {
    echo "--partial \"invalid\""
}

# Using iteration...
main () {

    begin=$(($1-1))
    end=$(($2-1))

    [[ $begin -gt 11 || $begin -lt 0 ]] || [[ $end -gt 11 || $end -lt 0 ]] && { canned_error; exit 1; }

    outpt=""

    for (( i=begin; i<=end; i++ ));
    do
        outpt="$outpt\nThis is the ${subj[$i]}\n"
        for (( j=i-1; j>=0; j-- ));
        do
            outpt="${outpt}that ${action[$j]} the ${subj[$j]}\n"
        done
    done

    echo -e "$outpt" | sed '1d'
}

# Using recursion...
main_2 () {
    true
}

# call main with all of the positional arguments
main "$@"

