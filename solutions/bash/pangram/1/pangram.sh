#!/usr/bin/env bash

main () {
    alpha=$( echo "$1" | tr -cd '[:alpha:]' | tr '[:upper:]' '[:lower:]' )
    
    declare -A bet; 

    for (( i=0; i<${#alpha}; i++ ));
    do
        bet[${alpha:$i:1}]=1
        if [[ $i -gt 24 && ${#bet[@]} -eq 26 ]]
            then  { echo "true"; exit 0; }
        fi
    done

    echo "false"; exit 0;
}

# call main with all of the positional arguments
main "$@"
