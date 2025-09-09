#!/usr/bin/env bash

main () {
    declare -a stanza=(
        "first;a Partridge in a Pear Tree."
        "second;two Turtle Doves"
        "third;three French Hens"
        "fourth;four Calling Birds"
        "fifth;five Gold Rings"
        "sixth;six Geese-a-Laying"
        "seventh;seven Swans-a-Swimming"
        "eighth;eight Maids-a-Milking"
        "ninth;nine Ladies Dancing"
        "tenth;ten Lords-a-Leaping"
        "eleventh;eleven Pipers Piping"
        "twelfth;twelve Drummers Drumming"
    )

    local start=$(($1-1)) stop=$(($2-1))

    for ((i=start; i<=stop; i++)); do
        j=$i
        IFS=";" read -r -a container <<< "${stanza[$j]}"
        echo -n "On the ${container[0]} day of Christmas my true love gave to me:"
        while [[ $j -ge 0 ]]; do
            IFS=";" read -r -a container <<< "${stanza[$j]}"
            if [[ i -eq 0 ]]; then echo -n " ${container[1]}";
            elif [[ j -eq 0 ]]; then echo -n " and ${container[1]}";
            else echo -n " ${container[1]},"
            fi
            ((j--))
        done
        echo ""
    done

    exit 0
}

# call main with all of the positional arguments
main "$@"
