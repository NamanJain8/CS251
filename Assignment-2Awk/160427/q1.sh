#!/bin/bash
: 'read -d '' calcstr << 'EOF'
BEGIN {
    print "start"
    counter=0
}
{
	 $0 
	#| sed s/[^*/]//g
}
END{
    print "end:"
}
EOF '


function get_files(){
	OIFS="$IFS"		# for ignoring spaces in filename
	IFS=$'\n'
	#for file in `find "$1"/* -type f -name "*.c"`; do
	#	awk -f q1.awk "$file"
		awk -f q1.awk `find "$1"/* -type f -name "*.c"`
		#num_lines=`cat "$file" | wc -l`
		#awk "a1" "$file"	# call awk script defined above to calculate comments	
	#done
	IFS="$OIFS"
} 

cmnt_counter=0
str_counter=0
begin1=0
begin2=0

get_files "$1"