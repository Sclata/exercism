#!/usr/bin/env bash

function sum_of_squares() {
    echo $(($1*($1+1)*(2*$1+1)/6))
}

function square_of_sum() {
    echo $((($1*($1+1)/2)**2))
}

main () {
    case "$1" in
        "difference") echo $(($(square_of_sum "$2") - $(sum_of_squares "$2")));;
        "sum_of_squares") sum_of_squares "$2";;
        "square_of_sum") square_of_sum "$2";;
    esac
}

# call main with all of the positional arguments
main "$@"

