#!/usr/bin/env bash

main () {
    case "$1" in
        privateKey) shift; shuf -i 2-"$(($1-1))" -n 1;;
        publicKey | secret) shift; bc <<< "($2 ^ $3) % $1";;
        *) echo "SOME USAGE ERROR MESSAGE"; exit 1;;
    esac

    exit 0
}

# call main with all of the positional arguments
main "$@"
