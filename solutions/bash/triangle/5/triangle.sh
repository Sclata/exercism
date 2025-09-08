#!/usr/bin/env bash

main () {
    [[ $# -ne 4 ]] && {
        echo "Usage: $0 [scalene|equilateral|isosceles] <side1> <side2> <side3>";
        exit 1;
    }

    # Scaffold vars.
    local tri_class=$1 perimeter dist_side_lngths
    shift
    perimeter=$(bc -l <<< "$1 + $2 + $3")

    # Check failing conditions
    [[ $(bc -l <<< "$1 == 0 || $2 == 0 || $3 == 0 ") -eq 1 ||
        $(bc -l <<< "($1/$perimeter) > 0.5 || \
                    ($2/$perimeter) > 0.5 || \
                    ($3/$perimeter) > 0.5") -eq 1 ]] && 
    { echo "false"; exit 0; }

    # Get count of distinct side lengths for classification.
    dist_side_lngths="$(
        printf '%s\n' "$@" | 
        sort -n | 
        uniq | 
        wc -l)"

    case "$tri_class" in 
        equilateral) [[ $dist_side_lngths -eq 1 ]];;
        isosceles) [[ $dist_side_lngths -lt 3 ]];;
        scalene) [[ $dist_side_lngths -eq 3 ]];;
        *)
            echo "Error: $tri_class not valid triangle type"
            exit 1
        ;;
    esac && echo "true" || echo "false"

    exit 0
}

# call main with all of the positional arguments
main "$@"
