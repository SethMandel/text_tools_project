#!/bin/bash

for file in $1; do
    tr '[:upper:]' '[:lower:]' < $file > $file.tmp
    touch $file.out
    cut -f1 -d$'\t' $file.tmp > $file.eng
    cut -f2 -d$'\t' $file.tmp > $file.spa
    i=1
    while read -r line; do
	    echo "$line" | tr -sc '[a-z]' '\n' | sort -u > $file.eng.$i # creates a temporary file of tokens on eng line
	    i=$((i+1))
    done <$file.eng
    i=1
    while read -r line; do
	    echo "$line" | tr -sc '[a-záéíóúñ]' '\n' | sort -u > $file.spa.$i # creates a temporary file of tokens on spa line
	    i=$((i+1))
    done <$file.spa
    j=$i
    i=1
    for (( c=$i; c<$j; c++ ))
    do
	    while read -r line; do
		    char_ct_eng=$(echo -n $line | wc -c)
		    if [ "$char_ct_eng" -gt 4 ]; then
			    echo -n "$line" > $file.left
			    eng_word=$(head -n 1 $file.left) #store the English word as a variable
			    while read -r line; do
				    char_ct_spa=$(echo -n $line | wc -c)
				    if [ "$char_ct_spa" -gt 4 ]; then
					    echo "$line" > $file.right
					    spa_word=$(head -n 1 $file.right) #store the Spanish word as a variable
					    # do the calculation`
					    lmin=$(./lmin.sh $eng_word $spa_word)
					    ldif=$(./ldif.sh $eng_word $spa_word)
					    med=$(./med.py -s1 $eng_word -s2 $spa_word)
					    lvar=$(expr $med - $ldif)
					    rvar=$(expr $lmin / 3)
					    if [ $lvar -le $rvar ] && [ $ldif -le 2 ]; then
						    paste $file.left $file.right >> $file.out
					    fi
					    : > $file.right
				    fi
			    done <$file.spa.$c
			    : > $file.left
		    fi
	    done <$file.eng.$c
	    echo "Processed line $c"
    done
    rm $file.eng.*
    rm $file.spa.*
done
