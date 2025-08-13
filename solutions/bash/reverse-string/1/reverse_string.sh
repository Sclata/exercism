#!/usr/bin/env bash

main () {
    echo "$@" | rev
}

main "$@"