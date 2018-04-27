#!/usr/bin/gawk
BEGIN {
    print "start"
    strcount=0
    cmntcount=0	
    cmntopen=0
    stropen=0
}

{
	gsub(/[MmOS]/,"",$0)
	gsub(/[/]+[*]+/,"M ",$0)
	gsub(/[*]+[/]+/,"m ",$0)
	gsub(/[/]{2}/,"O ",$0)
	gsub(/"/,"S ",$0)
	gsub(/[^MmOS/]/,"",$0)

	if(cmntopen==1){
		cmntcount++
	}

	split($0,cbc,"")
	for(i=1;i<=length($0);i++){
		if(cbc[i]=="O" && stropen==0 && cmntopen==0){
			cmntcount++
			break
		}
		if(stropen==0 && cbc[i]=="M"){
			cmntopen=1
			cmntcount++
			continue
		}

		if(stropen==0 && cbc[i]=="m"){
			cmntopen=0
			continue
		}

		if(cmntopen==0 && cbc[i]=="S" && stropen==0){
			stropen=1
			strcount++
			continue
		}

		if(cmntopen==0 && cbc[i]=="S"){
			stropen=0
		}
	}
}
END{
   print strcount" strings and "cmntcount" lines of comment"
}
