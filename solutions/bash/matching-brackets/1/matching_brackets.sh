#!/usr/bin/env bash

main () {
    local brack_str bracket closing_stack
    
    brack_str=$(tr -cd '([{}]))' <<< "$1")
    closing_stack=""

    for ((i=0; i<${#brack_str}; i++)); do
        bracket=${brack_str:i:1}
        case $bracket in
            "(") closing_stack="$closing_stack)";;
            "[") closing_stack="$closing_stack]";;
            "{") closing_stack="$closing_stack}";;
            *) if [[ $bracket == "${closing_stack: -1}" ]]; then
                    closing_stack=${closing_stack:0:((${#closing_stack}-1))}
                else
                    echo "false"
                    exit 0
                fi
        esac
    done

    [[ ${#closing_stack} -eq 0 ]] && echo "true" || echo "false"
    exit 0
}

# call main with all of the positional arguments
main "$@"
