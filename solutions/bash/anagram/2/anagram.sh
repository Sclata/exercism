#!/usr/bin/env bash

main () {
    echo "${1,,?}"
}

# call main with all of the positional arguments
main "$@"
