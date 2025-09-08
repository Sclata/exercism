#!/usr/bin/env bash

# Uses Newton's Method for approximating square roots.
# Does not handle any error checking.
# Assumes input will be a perfect square (per instructions).

main () {
    local guess=1 next_guess

    while true; do
        next_guess=$(((guess + ($1/guess))/2))
        [[ next_guess -eq guess ]] && break
        guess=$next_guess
    done
    echo "$next_guess"
}

# call main with all of the positional arguments
main "$@"
