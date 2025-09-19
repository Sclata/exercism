#!/usr/bin/env bash

# First submission...intend to come back to and clean up.
# Too much repeated code, need to optimize and offload
# some work to hepler function(s).

main () {
    local flags="" pattern
    declare -i line_no
    while getopts nlivx flag; do
        case $flag in
            n|l|i|v|x) flags="${flags}${flag}";;
            *) true;;
        esac
    done
    shift $((OPTIND-1))
    pattern=$1; shift;

    for f in "$@"; do
        [[ $flags =~ .*x.* ]] && pattern="^$pattern\$" || pattern=".*$pattern.*"
        line_no=0
        while IFS=$'\n' read -r line; do
            compline=$line
            [[ $flags =~ .*i.* ]] && { compline="${compline,,}"; pattern="${pattern,,}"; }
            (( line_no++ ))
            if [[ $flags =~ .*v.* ]]; then
                if [[ ! $compline =~ $pattern ]]; then
                    if [[ $flags =~ .*l.* ]]; then
                        echo "$f"
                        break
                    elif [[ $flags =~ .*n.* ]]; then
                        if (( $# > 1 )); then
                            printf "%s:%d:%s\n" "$f" "$line_no" "$line"
                        else
                            printf "%d:%s\n" "$line_no" "$line"
                        fi
                    else
                        if (( $# > 1 )); then
                            printf "%s:%s\n" "$f" "$line"
                        else
                            echo "$line"
                        fi
                    fi
                fi
            else
                if [[ $compline =~ $pattern ]]; then
                    if [[ $flags =~ .*l.* ]]; then
                        echo "$f"
                        break
                    elif [[ $flags =~ .*n.* ]]; then
                        if (( $# > 1 )); then
                            printf "%s:%d:%s\n" "$f" "$line_no" "$line"
                        else
                            printf "%d:%s\n" "$line_no" "$line"
                        fi
                    else
                        if (( $# > 1 )); then
                            printf "%s:%s\n" "$f" "$line"
                        else
                            echo "$line"
                        fi
                    fi
                fi
            fi
        done < "$f"
    done
}

# call main with all of the positional arguments
main "$@"
