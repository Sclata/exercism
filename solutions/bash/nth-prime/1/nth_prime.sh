#!/usr/bin/env bash

# To employ the Sieve of Eratosthenes, you have to know the upper bound
# to which you want to evaluate. In the related problem along Exercism's
# bash track (sieve), we were given this value. Here we aren't. We have
# to find a solution to approximate a good upper bound for our target prime.
# If we don't, then we'll have to guess and keep iteratively increasing
# this bound if it is deficient (new range over which we would need to
# sieve all known primes to that point again...).

# The prime number theorem posits that there are approximately
# n / log(n) primes less than n, but the gaps between the values are
# arbitrarily big. There is also no closed-form formula for solving
# for n given the xth prime. However, n/log(n) is a continuously increasing
# function past it's local minimum in quadrant one of a coordinate graph. 
# As a result, binomial search can be used to calculate an approximate 
# upper bound, as long as the xth prime value is sufficiently big:
# (in this case 3 or greater).

# To sum up, I use binomial search to estimate a solution to the
# prime number theorom for the argument provided. This establishes
# a guess for the upper bound. Then I execute the Sieve of Eratosthenes
# until the xth prime is found.

calc_upper_bound () {
    local low_b up_b
    low_b=0
    up_b=$(bc <<< "$1 * $1")
    # Simple guess for insufficiently large x...
    (($1 < 3)) && { echo "$((2*$1))"; exit 0; }
    while true; do
        mid=$(bc <<< "($low_b + $up_b) / 2")
        if ((low_b==mid || up_b==mid)); then
            bc <<< "2 * $mid"; exit 0;
        elif (("$(bc -l <<< "($mid / l($mid)) > $1")")); then
            up_b=$mid
        else
            low_b=$mid
        fi
    done
}

main () {
    local -i prime=2 prime_count=0 n=$1 upper_bound
    declare -A sieve=()

    ((n<1)) && { echo "invalid input"; exit 1; }
    
    upper_bound=$(calc_upper_bound "$n")

    for ((i=2; i<=upper_bound; i++)); do
        [[ -n "${sieve[$i]}" ]] && continue
        prime=$i
        ((++prime_count == n)) && break
        mult=2
        while (( mult*i <= upper_bound )); do
            sieve[$((mult*i))]="M"
            ((mult++))
        done
    done
    echo "$prime"
}

# call main with all of the positional arguments
main "$@"
