#!/usr/bin/env bash

# In viewing the bats file, input is expected in two forms:

# (1) allergies.sh [SCORE] allergic_to [ALLERGEN]
# (2) allergies.sh [SCORE] list

# In case 1, either produce output "true" or "false" if the supplied allergen
# is determined to be a contributing factor to the score provided.

# In case 2, produce a string with the concatenated items, separated by a space,
# of all allergens in the provided list that contribute to the score provided.

main () {
    allergens=("eggs" "peanuts" "shellfish" "strawberries" "tomatoes" "chocolate" "pollen" "cats")
    result=""
    score=$1
    while [ "$score" -gt 0 ] 
    do
        select=$(echo "res=l($score)/l(2);scale=0;res/1" | bc -l)

        if [[ "$select" -gt ${#allergens[@]}-1 ]]
            then true
        else 
            result="${allergens[$select]} $result"
        fi

        score=$(echo "$score - 2 ^ $select" | bc -l)
    done

    if [ "$2" = "list" ]
        then echo "$result" | xargs
    elif [[ "$result" == *"$3"* ]]
        then echo "true"
    else
        echo "false"
    fi
}


main "$@"