#!/usr/bin/env bash

main () {
    local orientation=${3:-north} x=${1:-0} y=${2:-0} instructions=$4
    local orient_indx
    (( $# == 0 )) && { echo "$x $y $orientation"; exit 0; }

    (( ! $# == 3 || ! $# == 4 )) && { echo "SOME USAGE MESSAGE"; exit 1; }
    [[ ! $1 =~ ^-?[0-9]*$ || ! $2 =~ ^-?[0-9]*$ ]] && { echo "invalid position"; exit 1; }
    [[ ! $3 =~ north|south|east|west ]] && { echo "invalid direction"; exit 1; }
    
    [[ $instructions == "" ]] && { echo "$x $y $orientation"; exit 0; }

    declare -a cards=(north east south west)
    case $orientation in
        north) orient_indx=0;;
        east) orient_indx=1;;
        south) orient_indx=2;;
        west) orient_indx=3;;
    esac

    for ((i=0; i<${#instructions}; i++)); do
        instruction=${instructions:$i:1}
        case $instruction in
            L) 
                #if ((orient_indx == 0)); then orient_indx=3; else ((orient_indx-=1)); fi
                ((orient_indx=(orient_indx+3)%4))
                orientation=${cards[$orient_indx]}
            ;;
            R) 
                ((orient_indx=(orient_indx+1)%4)) 
                orientation=${cards[$orient_indx]}
            ;;
            A) 
                case $orientation in
                    north) ((y+=1));;
                    south) ((y-=1));;
                    east) ((x+=1));;
                    west) ((x-=1));;
                esac
            ;;
            ?) echo "invalid instruction"; exit 1;
        esac
    done

    echo "$x $y $orientation"
    exit 0
}

# call main with all of the positional arguments
main "$@"
