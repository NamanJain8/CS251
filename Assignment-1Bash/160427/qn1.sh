#!/bin/bash
#This file is work of Anay Mehrotra
function cr {
	if [ $1 -ne 0 ]; then
		abc=$1
		th $[$abc/1000]
		if [ $[$abc/1000] -ne 0 ]; then
		echo -n " "
		fi

		abc=$[$abc%1000]

		hn $[$abc/100]
		if [ $[$abc/100] -ne 0 ];then
			echo -n " "
		fi

		abc=$[$abc%100]
		if [ $abc -ne 0 ]; then 
			sol $[$abc]
		fi
		
		echo -n " crore"
	fi
}
function lh {
	if [ $1 -ne 0 ]; then
		echo -n ${val[$1]}
		echo -n " lakh"
	fi
}
function th {	
	if [ $1 -ne 0 ]; then
		echo -n ${val[$1]}
		echo -n " thousand"
	fi
}
val=("" "one " "two " "three " "four " "five " "six " "seven " "eight " "nine " "ten " "eleven " "twelve " "thirteen " "fourteen " "fifteen " "sixteen " "seventeen " "eighteen " "nineteen " "twenty " "twenty one " "twenty two " "twenty three " "twenty four " "twenty five " "twenty six " "twenty seven " "twenty eight " "twenty nine " "thirty " "thirty one " "thirty two " "thirty three " "thirty four " "thirty five " "thirty six " "thirty seven " "thirty eight " "thirty nine " "forty " "forty one " "forty two " "forty three " "forty four " "forty five " "forty six " "forty seven " "forty eight " "forty nine " "fifty " "fifty one " "fifty two " "fifty three " "fifty four " "fifty five " "fifty six " "fifty seven " "fifty eight " "fifty nine " "sixty " "sixty one " "sixty two " "sixty three " "sixty four " "sixty five " "sixty six " "sixty seven " "sixty eight " "sixty nine " "seventy " "seventy one " "seventy two " "seventy three " "seventy four " "seventy five " "seventy six " "seventy seven " "seventy eight " "seventy nine " "eighty " "eighty one " "eighty two " "eighty three " "eighty four " "eighty five " "eighty six " "eighty seven " "eighty eight " "eighty nine " "ninety " "ninety one " "ninety two " "ninety three " "ninety four " "ninety five " "ninety six " "ninety seven " "ninety eight " "ninety nine "
)
function hn {
	if [ $1 -ne 0 ]; then
		echo -n ${val[$1]}
		echo -n " hundred"
	fi
}
function sol {	
	echo -n ${val[$1]}
}
function ini {		
	cr $[$num/10000000]
	if [ $[$num/10000000] -ne 0 ]; then
		echo -n " "
	fi
	num=$[$num%10000000]
	lh $[$num/100000] 
	if [ $[$num/100000] -ne 0 ]; then
		echo -n " "
	fi
	num=$[$num%100000]
	th $[$num/1000]
	if [ $[$num/1000] -ne 0 ]; then
		echo -n " "
	fi
	num=$[$num%1000]
	hn $[$num/100]
	if [ $[$num/100] -ne 0 ]; then
		echo -n " "
	fi
	num=$[$num%100]
	if [ $num -ne 0 ]; then 
		sol $[$num]
	fi
}

re='[^0-9]+'
if  [[ $1 =~ $re ]]; then
   echo "invalid input" 
   exit 0
fi

num=`echo -n $1 | sed 's/^0*'//g`
if [[ ${#num} -gt 11 ]]; then
	echo "invalid input";
	exit 0
fi

if [ $1 -eq 0 ] ; then
	echo "zero"
	exit 0
fi

ini $num
echo ""
