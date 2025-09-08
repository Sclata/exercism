#!/usr/bin/env bash

# Because of the nature of the problem statement,
# and the desire to use this function call for benchmark
# testing, I decided not to optimize the solution
# and instead write it in strict accordance with the
# described algorithm. This would potentially better
# highlight the comparative omputational abilities
# of the different hardware components.

main () {
    declare -A primes marked

    for ((i=2; i<=$1; i++)); do
        [[ -n "${marked[$i]}" ]] && continue || {
            primes[$i]=0
            mult=2
            while [[ $mult*$i -le $1 ]]; do
                marked[$((mult*i))]="M"
                (( mult++ ))
            done
        }
    done

    printf "%s\n" "${!primes[@]}" | # Expand primes, which are the keys in the array.
        sort -n | # Sort these values numerically.
        tr "\n" " " | # Replace newlines in the stream with spaces.
        sed "s/.$//" # Remove trailing space.
}

# call main with all of the positional arguments
main "$@"
