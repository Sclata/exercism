#!/usr/bin/env bash

valid_arguments () {
    if [[ $1 =~ ^\-?[0-9]+$ ]] && [[ $2 =~ ^\-?[0-9]+$ ]]
        then if [[ $# -eq 2 ]]
            then return 0
        elif [[ $# -eq 4 ]] && [[ $3 =~ [\+\-] ]] && [[ $4 =~ ^[0-9]+$ ]]
            then return 0
        fi
    fi
    
    echo "invalid arguments"
    exit 1  
}

resolve_sign () {
    [[ $1 == "-" ]] && echo "-$2" || echo "$2"
}

main () {
    if valid_arguments "$@"
        then if [[ $# -eq 4 ]]
            then
                min_base=$(($2 + $(resolve_sign "$3" "$4")))
                min_hrs=$((min_base / 60))
                mins=$((min_base % 60))
            else
                min_hrs=$(($2 / 60))
                mins=$(($2 % 60)) 
        fi

        hrs=$((($1 + min_hrs) % 24))
        if [[ $mins -lt 0 ]]
            then 
                hrs=$((hrs-1))
                mins=$((mins+60))
        fi
        if [[ $hrs -lt 0 ]]
            then hrs=$((hrs+24))
        fi
        
        printf "%02d:%02d" "$hrs" "$mins"
    fi
}

# call main with all of the positional arguments
main "$@"
