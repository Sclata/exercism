#!/usr/bin/env bash

main () {
    declare -A team_stats=()
    declare -A team_scores=()
    declare -a stats=(MP W D L P)
    local team1 team2

    printf "Team%27s" " "
    printf  "| MP |  W |  D |  L |  P\n"

    while IFS=$'\n' read -r -a line; do
        
        (( ${#line} == 0 )) && exit 0

        IFS=";" read -r -a match <<< "${line[@]}"
        
        team1=${match[0]}
        team2=${match[1]}
        
        if [[ ${match[2]} == "win" ]]; then
            for stat in "${stats[@]}"; do
                case $stat in
                    MP) 
                        team_stats["${team1}_${stat}"]=$((${team_stats["${team1}_${stat}"]:-0}+1))
                        team_stats["${team2}_${stat}"]=$((${team_stats["${team2}_${stat}"]:-0}+1))
                    ;;
                    W) team_stats["${team1}_${stat}"]=$((${team_stats["${team1}_${stat}"]:-0}+1));;
                    L) team_stats["${team2}_${stat}"]=$((${team_stats["${team2}_${stat}"]:-0}+1));;
                    P) 
                        team_scores["${team1}"]=$((${team_scores["${team1}"]:-0}+3))
                        team_scores["${team2}"]=$((${team_scores["${team2}"]:-0}))
                    ;;
                    D) true;;
                esac
            done
        elif [[ ${match[2]} == "loss" ]]; then
            for stat in "${stats[@]}"; do
                case $stat in
                    MP) 
                        team_stats["${team1}_${stat}"]=$((${team_stats["${team1}_${stat}"]:-0}+1))
                        team_stats["${team2}_${stat}"]=$((${team_stats["${team2}_${stat}"]:-0}+1))
                    ;;
                    W) team_stats["${team2}_${stat}"]=$((${team_stats["${team2}_${stat}"]:-0}+1));;
                    L) team_stats["${team1}_${stat}"]=$((${team_stats["${team1}_${stat}"]:-0}+1));;
                    P) 
                        team_scores["${team2}"]=$((${team_scores["${team2}"]:-0}+3))
                        team_scores["${team1}"]=$((${team_scores["${team1}"]:-0}))
                    ;;
                    D) true;;
                esac
            done
        else
            for stat in "${stats[@]}"; do
                case $stat in
                    MP|D) 
                        team_stats["${team1}_${stat}"]=$((${team_stats["${team1}_${stat}"]:-0}+1))
                        team_stats["${team2}_${stat}"]=$((${team_stats["${team2}_${stat}"]:-0}+1))
                    ;;
                    W) true;;
                    L) true;;
                    P) 
                        team_scores["${team1}"]=$((${team_scores["${team1}"]:-0}+1))
                        team_scores["${team2}"]=$((${team_scores["${team2}"]:-0}+1))
                    ;;
                esac
            done
        fi
    done < "${1:-/dev/stdin}"

    for team in "${!team_scores[@]}"; do 
        printf "%s%$((31-${#team}))s" "$team" " "
        printf "|%4s|%4s|%4s|%4s|%3s\n" \
            "${team_stats["${team}_MP"]} " \
            "${team_stats["${team}_W"]:-0} " \
            "${team_stats["${team}_D"]:-0} " \
            "${team_stats["${team}_L"]:-0} " \
            "${team_scores["${team}"]}"
    done | sort -k12rn,12 -k1,1
}

# call main with all of the positional arguments
main "$@"
