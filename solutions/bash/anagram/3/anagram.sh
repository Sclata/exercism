#!/usr/bin/env bash

normalize () {
    echo "${1,,}" | grep -o . | sort | tr -d "\n"
}

main () {
    base_norm=$(normalize "$1")
    result=""
    for anagram in $2; do
        if [[ "${1,,}" != "${anagram,,}" && $base_norm == $(normalize "$anagram") ]]
            then result=$result" $anagram"
        fi
    done

    echo $result
}

# call main with all of the positional arguments
main "$@"
