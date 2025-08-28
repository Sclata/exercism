#!/usr/bin/env bash

die_roll () {
    shuf -i 1-6 -n 1
}

make_attr () {
    declare -a rolls
    local sum min num

    sum=0
    rolls=($(die_roll) $(die_roll) $(die_roll) $(die_roll))
    min=${rolls[0]}
    for (( i=1; i<4; i++ )); do
        num=${rolls[i]}
        if [[ $num -lt $min ]]
            then
                (( sum+=min ))
                min=$num
        else
            (( sum+=num ))
        fi
    done

    echo "$sum"
    return 0
}

calc_modifier () {
    local val

    [[ $1 -lt 10 ]] && val=$(($1-1)) || val=$1
    echo $(( (val-10)/2 ))
}

generate_character () {
    strength=$(make_attr)
    dexterity=$(make_attr)
    constitution=$(make_attr)
    intelligence=$(make_attr)
    wisdom=$(make_attr)
    charisma=$(make_attr)
    hitpoints=$(( $(calc_modifier "$constitution") + 10 ))
}

main () {
    if [ "$1" = "generate" ]
        then
            generate_character
            echo "strength $strength"
            echo "dexterity $dexterity"
            echo "constitution $constitution"
            echo "intelligence $intelligence"
            echo "wisdom $wisdom"
            echo "charisma $charisma"
            echo "hitpoints $hitpoints"
    elif [ "$1" = "modifier" ] && [[ $2 =~ ^[0-9]+ ]]
        then
            calc_modifier "$2"
    else
        echo "Usage: [generate | modifier n ]"
        exit 1
    fi

    exit 0
}

# call main with all of the positional arguments
main "$@"
