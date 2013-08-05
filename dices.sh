#!/bin/bash

function roll()
{
    local calc=0
    local results=""

    for nbr in $(seq 1 $1)
    do
	# I know, it sucks because I lose some randomness, but it's probably not realy usefull here
	# +1 : because RANDOM began to 0
	local result=$(($RANDOM % $2 + 1))
	results="$results $result"
	calc="$calc + $result"
    done
    if [ -n $3 ]
    then
	calc="$calc $3"
    fi
    echo "$calc" | bc | tr '\n' ' '
    echo "($results)"
}

if [ -z "$1" ]
then
    echo "usage :"
    echo "$0 aDb[+/-c] [dDe[+/-f]] [gDh[+/-i]]"
    echo "example :"
    echo "$0 1d4+1 2D6-2"
    exit 1
fi

for roll in $*
do
    args=$(echo $roll | sed -r 's/([0-9]*)[dD]([0-9]*)([+-][0-9]*)?/\1 \2 \3/')
    printf "%s : " $roll
    roll $args
done
