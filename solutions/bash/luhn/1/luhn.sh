#!/usr/bin/env bash

main () {

    local digs sum=0
    grep -q "[^0-9 ]" <<< "$1" && { echo "false"; exit 0; }
    
    digs=$(tr -cd '[:digit:]' <<< "$1")
    [[ ${#digs} -lt 2 ]] && {
        echo "false"; exit 0; 
    }

    for ((i=(${#digs}-1),j=1; i>=0; i--,j++)); do
        
        if [[ $((j%2)) -eq 0 ]]; then 
            [[ $((2 * ${digs:$i:1})) -gt 9 ]] &&
                ((sum+=(2 * ${digs:$i:1} - 9))) ||
                ((sum+=(2 * ${digs:$i:1})))
        else
            ((sum+=${digs:$i:1}))
        fi
    done

    [[ $((sum%10)) -eq 0 ]] && echo "true" || echo "false"
}

# call main with all of the positional arguments
main "$@"
