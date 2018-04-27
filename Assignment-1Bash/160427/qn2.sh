#!/bin/bash	
#This file is work of Anay Mehrotra
function solve() {
	#1:file,2:depth
	a=0;b=0;
	if [ -d "$1" ] ; then
		
		cd "$1";
		
		while read fl; 
		do
			solve "$fl" $[$2+1]	
		done < <(ls)	
		cd ..;

			x=`grep -rE '[\.\!\?]' -o "$1" | wc -l`
			y=`grep -rE '[0-9]\.[0-9]' -o "$1" | wc -l`
			a=$[$x-$y]
		 
			x=`grep -rE '[0-9]+' -o "$1" | wc -l`
			y=`grep -rE '[0-9]+\.[0-9]+' -o "$1" | wc -l`
			b=$((x-2*y))

	else
		if [ -f "$1" ]; then
			x=`grep -E '[\.\!\?]' -o "$1" | wc -l`
			y=`grep -E '[0-9]\.[0-9]' -o "$1" | wc -l`
			a=$[$x-$y]
			
			x=`grep -E '[0-9]+' -o "$1" | wc -l`
			y=`grep -E '[0-9]+\.[0-9]+' -o "$1" | wc -l`
			b=$((x-2*y))

		else
			echo "invalid input";
			exit 1
		fi
	fi	

	i=0
	while [ $i -lt $2 ]
	do
		echo -n "  "
		((i++))
	done	
	
	if [ -d "$1" ];then echo -n '(D)'; fi
	if [ -f "$1" ];then echo -n '(F)'; fi
	echo  "$1-$a-$b";
	
	return;
}

solve $1 0
