#!/usr/bin/env bash

echo 'This script removes letter e from the words:'

WORDS="elbow knee eyes"
echo $WORDS

for WORD in $WORDS; do
echo $WORD | sed 's/e//g'
done