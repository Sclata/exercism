#!/usr/bin/env bash

check_for_error () {
    if [[ $# -ne 2 ]]
        then echo "Usage: series.sh <series> <seq_ln>"; exit 1;
    elif [[ ${#1} -eq 0 ]]
        then echo "series cannot be empty"; exit 1;
    elif [[ $2 -gt ${#1} ]]
        then echo "slice length cannot be greater than series length"; exit 1;
    elif [[ $2 -eq 0 ]]
        then echo "slice length cannot be zero"; exit 1;
    elif [[ $2 -lt 0 ]]
        then echo "slice length cannot be negative"; exit 1;
    else
        return 0;
    fi
}       

main () {
    result=""
    if check_for_error "$@"
        then for (( i=0; i<=(${#1}-$2); i++ )); do
            result+=" ${1:$i:$2}"
        done
    fi

    echo "$result" | xargs;
    exit 0;
}

# call main with all of the positional arguments
main "$@"
