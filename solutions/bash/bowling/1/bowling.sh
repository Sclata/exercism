#!/usr/bin/env bash

main () {
    local frame_bowl=0 frame_score=0 total_score=0 frame=1 pins=0 prev_frame=""

    # Check if any roll is negative...
    [[ $* =~ .*\-.* ]] && { echo "Negative roll is invalid"; exit 1; }
    # Check if any single roll is greater than ten...
    [[ $* =~ .*([1-9][0-9]{2,}|[2-9][0-9]|1[1-9]).* ]] && { echo "Pin count exceeds pins on the lane"; exit 1; }

    while ((frame < 11)); do
        
        # Check if game stopped short of ten frames...
        [[ -z "$1" ]] && { echo "Score cannot be taken until the end of the game"; exit 1; }
        
        pins=$1
        ((frame_score+=pins))
        ((frame_bowl++))
        ((frame_score > 10)) && { echo "Pin count exceeds pins on the lane"; exit 1; }
        shift

        if ((frame_score==10 && frame_bowl==1)); then
            [[ -z "$1" || -z "$2" ]] && { echo "Score cannot be taken until the end of the game"; exit 1; }
            (( $1 < 10 && ($1 + $2) > 10 )) && { echo "Pin count exceeds pins on the lane"; exit 1; }
            ((total_score+=$((pins + $1 + $2))))
            { frame_bowl=0; frame_score=0; ((frame++)); prev_frame="strike"; continue; }
        elif ((frame_score==10)); then
            [[ -z "$1" ]] && { echo "Score cannot be taken until the end of the game"; exit 1; }
            ((total_score+=$((pins + $1))))
            { frame_bowl=0; frame_score=0; ((frame++)); prev_frame="spare"; continue; }
        else 
            ((total_score+=pins))
        fi

        ((frame_bowl==2)) && { frame_bowl=0; frame_score=0; ((frame++)); prev_frame=""; continue; }

    done

    # Validate number of extra rolls...
    [[ ($prev_frame == "strike" && "$#" -gt 2) || 
        ($prev_frame == "spare" && "$#" -gt 1) || 
        ( -z $prev_frame && "$#" -gt 0 )
    ]] && { echo "Cannot roll after game is over"; exit 1; }

    echo "$total_score"
    exit 0
}

# call main with all of the positional arguments
main "$@"