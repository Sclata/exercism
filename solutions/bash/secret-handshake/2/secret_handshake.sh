#!/usr/bin/env bash

main () {
    declare -a actions;
    declare -a handshake;

    actions=("wink" "double blink" "close your eyes" "jump")
    
    for (( i=0; i<${#actions[@]}; i++ )); do
        if (( 1 << i & $1 ))
            then (( 1 << 4 & $1 )) && 
                handshake=("${actions[$i]}" "${handshake[@]}") || 
                handshake+=("${actions[$i]}")
        fi
    done

    echo "$(IFS=, ; echo "${handshake[*]}")"
}

# call main with all of the positional arguments
main "$@"
