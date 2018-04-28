#!/bin/bash
recurse(){
	num1=0
	num2=0
	local var1=0
	local var2=0
	OIFS="$IFS"
	IFS=$'\n'
	for entry in $1/*
	do
		if [ -f $entry ]; then
			local file_name=$(basename $entry)
			local count=`grep -o "[a-z]*[\.'!''?'][[:space:]]*" $entry | wc -l`
			local count2=`grep -o "[0-9]*\.[0-9]" $entry | wc -l`
			local count=$(($count-$count2))
			abc=`grep -o "[-]*[0-9]\+" $entry | wc -l`
			efg=`grep -o "[-]*[0-9]\+\.[0-9]\+" $entry | wc -l`
			abc=$(($abc-2*$efg))
			echo -e "\t$2(F)$file_name-$count-$abc"
			num1=$(($num1+$count))
			num2=$(($num2+$abc))
		else
			local dir_name=$(basename $entry)
			var1=$(($num1+$var1))
			var2=$(($num2+$var2))
			recurse $entry "$2\t"
		fi
	done
	IFS="$OIFS"
	total1=$(($var1+$num1))
	total2=$(($var2+$num2))
	local dir_name=$(basename $1)
	echo -e "$2(D)$dir_name-$total1-$total2"
}

dir_path=$1
# echo ${#1} length of file name
if ! [[ -d $dir_path ]]; then
	echo "invalid input"
else
	recurse $dir_path 
fi
