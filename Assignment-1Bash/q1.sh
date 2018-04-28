#!/bin/bash
read n
regex='^[0-9]+$'
str=""
function ones_fun(){
	if [ "$1" != "x" ] && [ "$1" \> "0" ]; then
		str+=" "
		case "$1" in
			1) str+="one";;
			2) str+="two";;
			3) str+="three";;
			4) str+="four";;
			5) str+="five";;
			6) str+="six";;
			7) str+="seven";;
			8) str+="eight";;
			9) str+="nine";;	
			*) ;;
		esac
		str+=" $2 "
	fi
}

function tens_fun(){
	if [ "$1" != "x" ]; then
		if [ "$1" == "1" ]; then
			case "$2" in
			0 ) str+="ten";;
			1 ) str+="eleven";;
			2 ) str+="twelve";;
			3 ) str+="thirteen";;
			4 ) str+="fourteen";;
			5 ) str+="fifteen";;
			6 ) str+="sixteen";;
			7 ) str+="seventeen";;
			8 ) str+="eighteen";;
			9 ) str+="nineteen";;
			* ) ;;
		esac
		str+=" $3 "

		else
			case "$1" in
				2 ) str+="twenty";;
				3 ) str+="thirty";;
				4 ) str+="forty";;
				5 ) str+="fifty";;
				6 ) str+="sixty";;
				7 ) str+="seventy";;
				8 ) str+="eighty";;
				9 ) str+="ninety";;
				* ) ;;
			esac
		fi
	fi

	if [ "$2" != "x" ] && [ "$2" \> "0" ] && [ "$1" != "1" ]; then
		ones_fun $2 "$3"
	fi
}

function num2eng(){
	ones=`echo ${1: -1}`
	if [[ "$ones" == "" ]]; then  # to make parameters passed valid
		ones=x
	fi
	tens=`echo ${1: -2:1}`
	if [[ "$tens" == "" ]]; then
		tens=x
	fi
	hundreds=`echo ${1: -3:1}`
	if [[ "$hundreds" == "" ]]; then
		hundreds=x
	fi
	thousands1=`echo ${1: -4:1}`
	if [[ "$thousands1" == "" ]]; then
		thousands1=x
	fi
	thousands2=`echo ${1: -5:1}`
	if [[ "$thousands2" == "" ]]; then
		thousands2=x
	fi
	lakhs1=`echo ${1: -6:1}`
	if [[ "$lakhs1" == "" ]]; then
		lakhs1=x
	fi
	lakhs2=`echo ${1: -7:1}`
	if [[ "$lakhs2" == "" ]]; then
		lakhs2=x
	fi
	crore1=`echo ${1: -8:1}`
	if [[ "$crore1" == "" ]]; then
		crore1=x
	fi
	crore2=`echo ${1: -9:1}`
	if [[ "$crore2" == "" ]]; then
		crore2=x
	fi
	crore3=`echo ${1: -10:1}`
	if [[ "$crore3" == "" ]]; then
		crore3=x
	fi
	crore4=`echo ${1: -11:1}`
	if [[ "$crore4" == "" ]]; then
		crore4=x
	fi
	crore5=`echo ${1: -12:1}`
	if [[ "$crore5" == "" ]]; then
		crore5=x
	fi

	tens_fun $crore5 $crore4 "thousand"
	ones_fun $crore3 "hundred"
	tens_fun $crore2 $crore1 ""
	if [ "x" != "$crore1" ] || [ "x" != "$crore2" ] || [ "x" != "$crore3" ] || [ "x" != "$crore4" ] || [ "x" != "$crore5" ]; then
		str+=" crore "
	fi
	tens_fun $lakhs2 $lakhs1 "lakh"
	tens_fun $thousands2 $thousands1 "thousand"
	ones_fun $hundreds "hundred"
	tens_fun $tens $ones ""
}

if ! [[ $n=~$regex ]];
	then
	echo "invalid input"
else
	n=`echo $n | sed 's/^0*//'`	#strip extra zeros
	if [[ "$n" == "" ]]; then
		echo zero
		exit 0
	fi
	if [ ${#n} -gt 11 ];
		then
		echo "invalid input"
	else
		num2eng $n
		echo $str
	fi
fi
