#!/usr/bin/env bash

is_valid_isbn () {
    grep -qE "^[0-9]{9}[0-9X]$" <<< "$1"
}

main () {
    local isbn="${1//\-/}" sum_val=0
    if is_valid_isbn "$isbn"; then
        for i in {9..1}; do
            ((sum_val+=((i+1)*${isbn:$((9-i)):1})))
        done
        [[ ${isbn:9:1} = "X" ]] && ((sum_val+=10)) || ((sum_val+=${isbn:9:1}))
        [[ $((sum_val%11)) -eq 0 ]] && echo "true" || echo "false"
    else
        echo "false"
    fi
}

# call main with all of the positional arguments
main "$@"
