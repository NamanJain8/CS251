#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: <XML file>"
	exit 0
fi

cat $1 | \
while read CMD; do
    line=`echo $CMD | sed 's/\s+//g' `
    
    if [ "$line" == "<dir>" ]; then
    	check=0
    fi

    if [ "$line" == "<file>" ]; then
    	check=1
    fi

    if [[ $line == \<name* ]]; then
    	file_name=`echo $line | sed 's/<name>//g'`
    	file_name=`echo $file_name | sed 's/<\/name>//g'`
    	if(( check == 0 )); then
    		mkdir $file_name
    		cd $file_name
    	fi
    fi

    if [[ $line == \<size* ]]; then
    	size=`echo $line | sed 's/<size>//g'`
    	size=`echo $size | sed 's/<\/size>//g'`
    	fallocate -l $size $file_name
    fi

    if [ "$line" == "</dir>" ]; then
    	cd ..
    fi
done


