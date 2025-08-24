#!/usr/bin/env bash

main () {
    echo " $1" | 
        tr -s "-" " " | 
        tr -s "[:lower:]" "[:upper:]" |
        tr -d "[:punct:]" |
        grep -o " [A-Z]" |
        tr -d " \n"
}

# call main with all of the positional arguments
main "$@"
