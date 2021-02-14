#!/bin/bash

# generates a coverage badge based on the total line coverage output
# takes 1 argument:
#     ${1} filename of the badge

total=`go tool cover -func=coverage.out | grep total | grep -Eo '[0-9]+\.[0-9]+'`
if (( $(echo "$total <= 50" | bc -l) )) ; then
	COLOR=red
elif (( $(echo "$total > 80" | bc -l) )); then
	COLOR=green
else
	COLOR=orange
fi

mkdir -p $(dirname ${1})
echo "generating coverage badge in $(dirname ${1})"
curl "https://img.shields.io/badge/coverage-$total%25-$COLOR" > ${1}
