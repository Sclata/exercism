#!/usr/bin/env bash

main () {

    local lower="abcdefghijklmnopqrstuvwxyz"
    local upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local rot=$(("$2"%26))
    local t_lower="${lower:$rot}${lower:0:$rot}"
    local t_upper="${upper:$rot}${upper:0:$rot}"
    
    echo "$1" | tr "$lower" "$t_lower" | tr "$upper" "$t_upper"
}

# call main with all of the positional arguments
main "$@"
