#!/usr/bin/env bash

_add () {
    IFS="/" read -r -a rat_one <<< "$1"
    IFS="/" read -r -a rat_two <<< "$2"

    numerator=$((rat_one[0] * rat_two[1] + rat_two[0] * rat_one[1]))
    denominator=$((rat_two[1] * rat_one[1]))
    _reduce "$numerator/$denominator"
}

_subtract () {
    IFS="/" read -r -a rat_one <<< "$1"
    IFS="/" read -r -a rat_two <<< "$2"

    numerator=$((rat_one[0] * rat_two[1] - rat_two[0] * rat_one[1]))
    denominator=$((rat_two[1] * rat_one[1]))
    _reduce "$numerator/$denominator"
}

_multiply () {
    IFS="/" read -r -a rat_one <<< "$1"
    IFS="/" read -r -a rat_two <<< "$2"

    numerator=$((rat_one[0] * rat_two[0]))
    denominator=$((rat_two[1] * rat_one[1]))
    _reduce "$numerator/$denominator"
}

_divide () {
    IFS="/" read -r -a rat_one <<< "$1"
    IFS="/" read -r -a rat_two <<< "$2"

    numerator=$((rat_one[0] * rat_two[1]))
    denominator=$((rat_two[0] * rat_one[1]))
    _reduce "$numerator/$denominator"
}

_absolute () {
    _reduce "${1//-/}"
}

_raise_to_one () {
    IFS="/" read -r -a rat_one <<< "$1"

    if (($2 < 0)); then 
        numerator=$((rat_one[1] ** (-1*"$2")))
        denominator=$((rat_one[0] ** (-1*"$2")))
    else
        numerator=$((rat_one[0] ** "$2"))
        denominator=$((rat_one[1] ** "$2"))
    fi
    _reduce "$numerator/$denominator"
}

_raise_to_two () {
    printf "%0.6f" "$(bc -l <<< "e(l($1)*($2))")" | sed -E 's/(\.[0-9])0+$/\1/'
}

_reduce () {
    IFS="/" read -r -a rat_one <<< "$1"

    denom=$(gcd "${rat_one[0]}" "${rat_one[1]}")
    result="$((rat_one[0]/denom))/$((rat_one[1]/denom))"

    [[ $result =~ .*\-.* ]] &&
        echo "-${result//-/}" ||
        echo "$result"
}

gcd () (
    ! (( $1 % $2 )) && 
        echo "$2" || 
        gcd "$2" $(( $1 % $2 ))
)

main () {
    case $1 in
        +) _add "$2" "$3";;
        -) _subtract "$2" "$3";;
        \*) _multiply "$2" "$3";;
        /) _divide "$2" "$3";;
        abs) _absolute "$2";;
        pow) _raise_to_one "$2" "$3";;
        rpow) _raise_to_two "$2" "$3";;
        reduce) _reduce "$2";;
        *) true;;
    esac
}

# call main with all of the positional arguments
main "$@"
