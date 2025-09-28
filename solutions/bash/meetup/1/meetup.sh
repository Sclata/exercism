#!/usr/bin/env bash

declare -A dow=(
    [MONDAY]=1
    [TUESDAY]=2
    [WEDNESDAY]=3
    [THURSDAY]=4
    [FRIDAY]=5
    [SATURDAY]=6
    [SUNDAY]=7
)

main () {
    local yr mo wk dy dy_val ref_val dy_diff comp
    yr=$1; mo=$(printf "%02d" "$2"); wk=$3; dy=${4^^};

    dy_val=${dow[$dy]}
    ref_val=$(date -d "$yr-$mo-01" +"%u")
    ((dy_val >= ref_val)) && 
        dy_diff=$((dy_val-ref_val)) || 
        dy_diff=$((7+dy_val-ref_val))
    
    case $wk in
        first) true;;
        second) ((dy_diff+=7));;
        third) ((dy_diff+=14));;
        fourth) ((dy_diff+=21));;
        last) 
            comp=$(date -d "$yr-$mo-01 +$((dy_diff+28)) day" +"%m")
            [[ $comp == "$mo" ]] && ((dy_diff+=28)) || ((dy_diff+=21))
        ;;
        teenth) 
            comp=$(date -d "$yr-$mo-01 +$((dy_diff+7)) day" +"%d")
            [[ $comp =~ [1][3-9] ]] &&  ((dy_diff+=7)) || ((dy_diff+=14))
        ;;
        *) { echo "Invalid week value."; exit 1; };;
    esac

    date -d "$yr-$mo-01 +$dy_diff day" +"%Y-%m-%d"
}

# call main with all of the positional arguments
main "$@"
