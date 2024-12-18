#!/bin/bash

# returns the length of the shorter string

l1=${#1}
l2=${#2}

if [ $l1 -gt $l2 ]; then
	echo $l2
else
	echo $l1
fi
