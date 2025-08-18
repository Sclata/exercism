#!/usr/bin/env bash

main () {
    len=${#1}
    res_sum=0
    for (( i=0; i<len; i++ ))
    do
        res_sum=$((res_sum + "${1:$i:1}" ** "$len"))
    done
    
    [ "$res_sum" == "$1" ] && echo "true" || echo "false"
}

main "$@"