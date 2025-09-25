#!/usr/bin/env bash

declare -A alphabet=(
    [a]=0 [b]=1 [c]=2 [d]=3 [e]=4 [f]=5 [g]=6 [h]=7 [i]=8 [j]=9 
    [k]=10 [l]=11 [m]=12 [n]=13 [o]=14 [p]=15 [q]=16 [r]=17 [s]=18 
    [t]=19 [u]=20 [v]=21 [w]=22 [x]=23 [y]=24 [z]=25
)

picker="abcdefghijklmnopqrstuvwxyz"

main () {
    # Check inputs...
    [[ ! $# == 4 || ! $1 =~ [encode|decode] || \
    ! $2 =~ ^[0-9]*$ || ! $3 =~ ^[0-9]*$ ]] &&
        { echo "Usage: $0 [encode|decode] <int> <int> <str>"; exit 1; }

    # Init variables...
    local action=$1 a=$2 b=$3 msg=$4 m=26
    local E_x D_y i l MMI=1 new_msg=""

    # Format incoming message string...
    msg=$( tr -cd "[:digit:][:alpha:]" <<< "${4,,}" )

    # Ensure automatic decryption is possible...
    (( a%2 == 0 || a%13 == 0 )) &&
        { echo "a and m must be coprime."; exit 1; }

    if [[ $action == 'encode' ]]; then
        for ((j=0; j<${#msg}; j++)); do
            l="${msg:$j:1}"
            [[ $l =~ [0-9] ]] && { new_msg+="$l"; continue; }
            i="${alphabet[$l]}"
            E_x=$(((a*i + b) % m)) # Compute encrypted value.
            new_msg+="${picker:$E_x:1}" # Select encode letter.
        done
        echo "$new_msg" | fold -w5 | tr "\n" " " | xargs
    else
        for ((j=0; j<${#msg}; j++)); do
            l="${msg:$j:1}"
            [[ $l == ' ' ]] && continue # Ignore spaces.
            [[ $l =~ [0-9] ]] && { new_msg+="$l"; continue; } # Keep nums.
            E_x="${alphabet[$l]}" # Get computed encrypted value.
            # Determine MMI...
            while ((MMI < m)); do
                (( (MMI * (a%m))%m == 1 )) && break
                ((MMI++))
            done
            D_y=$(( (MMI * (E_x - b)) % m )) # Compute decrypted value.
            new_msg+="${picker:$D_y:1}" # Select decoded letter.
        done
        echo "$new_msg"
    fi

    exit 0
}

# call main with all of the positional arguments
main "$@"
