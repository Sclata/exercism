#!/usr/bin/env bash

main () {
    local bnry
    declare -a handshake
    declare -a rev_handshake
    
    bnry=$(echo "obase=2; $1" | bc)
    
    for (( i=-1; i>=-${#bnry}; i-- )); do
        bit_val=${bnry:$i:1}
        case "$i $bit_val" in
            "-1 1") handshake+=("wink");;
            "-2 1") handshake+=("double blink");;
            "-3 1") handshake+=("close your eyes");;
            "-4 1") handshake+=("jump");;
            "-5 1") for (( j=${#handshake[@]}-1; j>=0; j-- )); do
                        rev_handshake+=("${handshake[$j]}")
                    done;
                
        esac
    done

    [[ ${#bnry} -eq 5 ]] && 
        echo "$(IFS=, ; echo "${rev_handshake[*]}")" ||
        echo "$(IFS=, ; echo "${handshake[*]}")"
}

# call main with all of the positional arguments
main "$@"
