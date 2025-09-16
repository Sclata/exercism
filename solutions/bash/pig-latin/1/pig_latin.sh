#!/usr/bin/env bash

main () {
    shopt -s extglob
    declare -a response=()

    for arg in "$@"; do
        if grep -qE "^[aeiou].*|^xr.*|^yt.*" <<< "$arg"; then
            response+=("${arg}ay")
        elif grep -qE "^[^aeiou]*qu.*" <<< "$arg"; then
            response+=("${arg##*([^aeiou])qu}$(grep -oE "^[^aeiou]*qu" <<< "$arg")ay")
        elif grep -qE "^[^aeiou]+y.*" <<< "$arg"; then
            response+=("${arg##+([^aeiouy])}$(grep -oE "^[^aeiou]+y" <<< "$arg" | tr -d "y")ay")
        else
            response+=("${arg##+([^aeiou])}$(grep -oE "^[^aeiou]+" <<< "$arg")ay")
        fi
    done

    echo "${response[*]}"
}

# call main with all of the positional arguments
main "$@"
