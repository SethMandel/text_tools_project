#!/bin/bash

# returns the length differential of two strings
l1=${#1}
l2=${#2}


if [ $l1 -gt $l2 ]; then
	echo $(($l1 - $l2))
else
	echo $(($l2 - $l1))
fi

