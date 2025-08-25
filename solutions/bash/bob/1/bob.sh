#!/usr/bin/env bash

is_question () {
    [[ ${1: -1} == "?" ]] && return 0 || return 1
}

is_caps () {
    alpha=$( echo "$1" | tr -dc '[:alpha:]' )
    [[ $alpha != "" && $alpha == "${alpha^^}" ]] && return 0 || return 1
}

is_silent () {
    [[ $(echo "$1" | tr -d '[:space:]') == "" ]] && return 0 || return 1
}

main () {
    local inpt
    inpt=$( echo "$1" | sed 's/ *$//' )
    if is_question "$inpt" && is_caps "$inpt"
        then echo "Calm down, I know what I'm doing!"
    elif is_question "$inpt"
        then echo "Sure."
    elif is_caps "$inpt"
        then echo "Whoa, chill out!"
    elif is_silent "$inpt"
        then echo "Fine. Be that way!"
    else
        echo "Whatever."
    fi

    exit 0
}

# call main with all of the positional arguments
main "$@"
