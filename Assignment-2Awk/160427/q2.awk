#!/usr/bin/gawk

BEGIN{
	count=0
}

function throughput(start,end,databytes){
	split(start, s, /[.:]/);
	split(end, e, /[.:]/);
	time_diff=3600*(e[1]-s[1]) + 60*(e[2]-s[2]) + 1*(e[3]-s[3]) + 0.000001*(e[4]-s[4])
	return databytes/time_diff
}

{

	split($5,rec,/[:]/)
		rec_ip=rec[1]
	total_pack[$3,rec_ip]+=1


	if(end_time[$3,rec_ip]==""){
		begin_time[$3,rec_ip]=$1
		begin_time[rec_ip,$3]=$1
	}

	if(data_pack[$3,rec_ip]==""){
		data_pack[$3,rec_ip]=0
		data[$3,rec_ip]=0
	}

	if($NF > 0){							#check length
		data_pack[$3,rec_ip]+=1
		data[$3,rec_ip]+=$NF
	}

	if($0 ~ /seq/ && $NF > 0){
			split($9,sepr,/[:,]/)
			low=sepr[1]
			high=sepr[2]
			if(high-low==1448)
				retrans[$3,rec_ip,high,low]+=1448
			if(high-low==2896){
				retrans[$3,rec_ip,(high+low)/2,low]+=1448
				retrans[$3,rec_ip,high,(high+low)/2]+=1448
			}
			if(high-low==4344){
				retrans[$3,rec_ip,(high+2*low)/3,low]+=1448
				retrans[$3,rec_ip,(2*high+low)/3,(high+2*low)/3]+=1448
				retrans[$3,rec_ip,high,(2*high+low)/3]+=1448
			}
			if(high-low==5792){
				retrans[$3,rec_ip,(high+3*low)/4,low]+=1448
				retrans[$3,rec_ip,(2*high+2*low)/4,(high+3*low)/4]+=1448
				retrans[$3,rec_ip,(3*high+low)/4,(2*high+2*low)/4]+=1448
				retrans[$3,rec_ip,high,(3*high+low)/4]+=1448
			}
			if(high-low==7240){
				retrans[$3,rec_ip,(high+4*low)/5,low]+=1448
				retrans[$3,rec_ip,(2*high+3*low)/5,(high+4*low)/5]+=1448
				retrans[$3,rec_ip,(3*high+2*low)/5,(2*high+3*low)/5]+=1448
				retrans[$3,rec_ip,(4*high+low)/5,(3*high+2*low)/5]+=1448
				retrans[$3,rec_ip,high,(4*high+low)/5]+=1448
			}


			#if(retran[$3,rec_ip,$9] == 1)		#check if packet is retransmitted or not
			#	retransmitted[$3,rec_ip]+=$NF
			#retran[$3,rec_ip,$9]=1
		}

	end_time[$3,rec_ip]=$1
	end_time[rec_ip,$3]=$1
}

END{

for(i in retrans){
	split(i,sep1,SUBSEP)
	send=sep1[1]
	recieve=sep1[2]
	retransmitted[send,recieve]+=retrans[i]-1448
}


for (i in total_pack){
	split(i,sep,SUBSEP);
	if(occured[sep[2],sep[1]]==1)
		continue;
	split(sep[1],ip1,/[.]/)
	sender_ip=ip1[1]"."ip1[2]"."ip1[3]"."ip1[4]":"ip1[5]
	split(sep[2],ip2,/[.]/)
	reciever_ip=ip2[1]"."ip2[2]"."ip2[3]"."ip2[4]":"ip2[5]

	print "Connection (A=" sender_ip " B=" reciever_ip ")"

	if(retransmitted[sep[1],sep[2]]=="")
			retransmitted[sep[1],sep[2]]=0
	
	printf "A --> B #packets=%u #data_packets=%u #data_bytes=%u #retrans=%u xput=%u bytes/sec\n", total_pack[sep[1],sep[2]], data_pack[sep[1],sep[2]], data[sep[1],sep[2]], retransmitted[sep[1],sep[2]], throughput(begin_time[sep[1],sep[2]],end_time[sep[1],sep[2]],data[sep[1],sep[2]])
	
	if(retransmitted[sep[2],sep[1]]=="")
		retransmitted[sep[2],sep[1]]=0

	printf "B --> A #packets=%u #data_packets=%u #data_bytes=%u #retrans=%u xput=%u bytes/sec\n", total_pack[sep[2],sep[1]], data_pack[sep[2],sep[1]], data[sep[2],sep[1]], retransmitted[sep[2],sep[1]], throughput(begin_time[sep[2],sep[1]],end_time[sep[2],sep[1]],data[sep[2],sep[1]])
	
	occured[sep[1],sep[2]]=1
	}
}
