#!/usr/bin/env bash
ones=("zero" "one" "two" "three" "four" "five"
"six" "seven" "eight" "nine")

teens=("ten" "eleven" "twelve" "thirteen" "fourteen" 
"fifteen" "sixteen" "seventeen" "eighteen" "nineteen")

tens=("twenty" "thirty" "forty" "fifty"
"sixty" "seventy" "eighty" "ninety")

parse_denom () {
    local result="" val
    val=$(grep -o "[^0].*" <<< "$1") # Remove leading zeros.
    
    if (( ${#val} == 0 )); then echo -n ""
    elif (( ${#val} == 1 )); then echo -n " ${ones[$val]}"
    elif (( ${#val} == 2 )); then
        if (( ${val:0:1} == 1 )); then echo -n " ${teens[${val:1:1}]}"
        else 
            echo -n " ${tens[$((${val:0:1}-2))]}"
            (( ${val:1:1} != 0 )) && echo -n "-${ones[${val:1:1}]}"
        fi
    else
        echo -n "${ones[${val:0:1}]} hundred$(parse_denom "${val:1}")"
    fi
    exit 0
}

main () {

    [[ ${#1} -gt 12 || ! $1 =~ ^[0-9]+$ ]] && { echo "input out of range"; exit 1; }
    
    local result="" num=$1 partial
    partial=$((${#1}%3))

    (( ${#num} >= 3 )) && h=${num: -3:3} || h=${num: -"$partial":"$partial"}
    (( ${#num} >= 7 )) && t=${num: -6:3} || t=${num: -"$((3+partial))":"$partial"}
    (( ${#num} >= 10 )) && m=${num: -9:3} || m=${num: -"$((6+partial))":"$partial"}
    (( ${#num} == 12 )) && b=${num: -12:3} || b=${num: -"$((9+partial))":"$partial"}

    h=$(parse_denom "$h")
    t=$(parse_denom "$t")
    m=$(parse_denom "$m")
    b=$(parse_denom "$b")

    [[ ! -z $b ]] && result="${b} billion"
    [[ ! -z $m ]] && result="${result} ${m} million"
    [[ ! -z $t ]] && result="${result} ${t} thousand"
    [[ ! -z $h ]] && result="${result} ${h}"
    
    echo "${result:-zero}" | xargs
}

# call main with all of the positional arguments
main "$@"
