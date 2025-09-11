#!/usr/bin/env bash

main () {
    local alpha="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    declare -a print_stack=()

    local substr=$(grep -o ".*${1}" <<< "$alpha")
    local -i line_lgth=$((2 * ${#substr} - 1))

    [[ $line_lgth -eq 1 ]] && { echo "$substr"; exit 0; }

    for ((i=0; i<"${#substr}"; i++)); do
        spc_out=$(("${#substr}"-1-i))
        spc_in=$((line_lgth-(2*spc_out)-2))
        letter="${substr:i:1}"
        if [[ $i -eq 0 ]]; then
            print_line=$(printf "%${spc_out}s%s%${spc_out}s\n" " " "$letter" " ")
            echo "$print_line"
            print_stack+=("$print_line")
        elif [[ $spc_out -eq 0 ]]; then
            printf "%s%${spc_in}s%s\n" "$letter" " " "$letter"
        else
            print_line=$(printf "%${spc_out}s%s%${spc_in}s%s%${spc_out}s\n" " " "$letter" " " "$letter" " ")
            echo "$print_line"
            print_stack+=("$print_line")
        fi
    done

    for ((i=$((${#print_stack[@]}-1)); i>=0; i--)); do
        echo "${print_stack[$i]}"
    done

    exit 0;
}

# call main with all of the positional arguments
main "$@"
