#!/usr/bin/env bash

main () {
    declare -i a=0
    declare -A positions=()

    [[ "$*" == "" ]] && { echo ""; exit 0; }

    # Accumulate counts in flower & adjacent squares
    for arg in "$@"; do
        for ((i=0; i<${#arg}; i++)); do
            [[ ${arg:$i:1} == "*" ]] && {
                for ((r=$((a-1)); r<=$((a+1)); r++)); do
                    for ((c=$((i-1)); c<=$((i+1)); c++)); do
                        positions["${r},${c}"]=$(("${positions["${r},${c}"]:-0}"+1))
                    done
                done
            }
        done
        ((a++))
    done
    
    a=0

    # Print the rows with numbers
    for arg in "$@"; do
        for ((i=0; i<${#arg}; i++)); do
            [[ ${arg:$i:1} != "*" ]] && {
                echo -n "${positions["${a},${i}"]:-" "}";
                continue;
            }
            echo -n "*"
        done
        echo ""
        ((a++))
    done

    exit 0
}

# call main with all of the positional arguments
main "$@"
