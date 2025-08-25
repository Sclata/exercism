#!/usr/bin/env bash

main () {
    local base base_comp base_norm comp comp_norm result

    base="$1"
    base_comp=$( echo "$base" | tr "[:upper:]" "[:lower:]")
    base_norm=$( echo "$base_comp" | grep -o . | sort | tr -d "\n" )
    result=""

    IFS=" " read -ra anagrams <<< "$2";

    for (( i=0; i<${#anagrams}; i++ )); do
        comp=$( echo "${anagrams[$i]}" | tr "[:upper:]" "[:lower:]" )

        if [[ $base_comp == "$comp" ]]
            then true
        else
            comp_norm=$( echo "$comp" | grep -o . | sort | tr -d "\n" )
            [[ $base_norm == "$comp_norm" ]] && result+=" ${anagrams[$i]}"
        fi
    done

    echo "$result" | xargs
}

# call main with all of the positional arguments
main "$@"
