#!/usr/bin/env bash

declare -A keyshift=(
    [a]=0 [b]=1 [c]=2 [d]=3 [e]=4 [f]=5 [g]=6
    [h]=7 [i]=8 [j]=9 [k]=10 [l]=11 [m]=12 [n]=13
    [0]=14 [p]=15 [q]=16 [r]=17 [s]=18 [t]=19 [u]=20
    [v]=21 [w]=22 [x]=23 [y]=24 [z]=25
)

carousel="abcdefghijklmnopqrstuvwxyz"

generate_key () {
    key=""
    for k in {1..100}; do
        key="${key}${carousel:$((RANDOM%(25+1))):1}"
    done
    echo "$key"
}

main () {
    local translate key action message k
    
    (( ! $# == 1 || ! $# == 4 )) && { echo "SOME USAGE ERROR"; exit 1; }
    [[ $1 == "key" ]] && { generate_key; exit 0; }
    [[ ! $2 =~ ^[[:lower:]]+$ ]] && { echo "invalid key"; exit 1; }

    while getopts "k:" option; do
        case $option in
            k) key=$OPTARG;;
            *) { echo "INVALID FLAG"; exit 1; }
        esac
    done
    shift $((OPTIND-1))

    action=$1
    message=${2,,}
    
    for ((i=0; i<${#message}; i++)); do
        k=${key:$(((i+${#key})%${#key})):1}
        shift_amt=${keyshift[$k]}
        translate="${carousel:$shift_amt}${carousel:0:$shift_amt}"
        if [[ $action == "encode" ]]; then
            echo -n "$(tr "$carousel" "$translate" <<< "${message:$i:1}")"
        elif [[ $action == "decode" ]]; then
            echo -n "$(tr "$translate" "$carousel" <<< "${message:$i:1}")"
        fi
    done

    exit 0
}

# call main with all of the positional arguments
main "$@"
