#!/usr/bin/env bash

main () {
    declare -A orbitals=(
        ["Mercury"]=0.2408467
        ["Venus"]=0.61519726
        ["Earth"]=1.0
        ["Mars"]=1.8808158
        ["Jupiter"]=11.862615
        ["Saturn"]=29.447498
        ["Uranus"]=84.016846
        ["Neptune"]=164.79132
    )

    [[ $# -ne 2 ]] && {
        echo "Usage: $0 <planet> <seconds>";
        exit 1;
    }

    [[ -z ${orbitals["$1"]} ]] && {
        echo "Error: $1 not a planet";
        exit 1;
    }

    # 60 sec/min * 60 min/hr * 24 hr/day * 365.25 day/Earth_yr
    val="$(printf %.2f "$(bc -l <<< "scale=3; ($2 / (60 * 60 * 24 * 365.25 * ${orbitals[$1]}))")")"
    [[ "$val" =~ ^\..* ]] && echo "0${val}" || echo "${val}"
}

# call main with all of the positional arguments
main "$@"
