#!/usr/bin/env bash

echo 'This script parses the file animals.txt.'

cat animals.txt | while read animal behaviour leg_number
do
    echo "$animal $behaviour with $leg_number legs."
done