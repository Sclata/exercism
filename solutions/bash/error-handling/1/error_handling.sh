#!/usr/bin/env bash

main () {
    if [[ $# -ne 1 ]]
        then echo "Usage: $(basename "$0") <person>"; exit 1;
    else
        echo "Hello, $1"; exit 0;
    fi
}

# call main with all of the positional arguments
main "$@"