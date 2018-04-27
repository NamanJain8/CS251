#!/usr/bin/gawk

BEGIN{
	
}

function calc_time(time)
{
	split(time,sep,/[:]/);
	return 3600*sep[1]+60*sep[2]+sep[3]
}

NR==1{
	for(i=1;i<=NF;i++)
		idx[$i]=i;
}

NR>1{
	usr[$idx["USER"]]=$idx["USER"]
	num_threads[$idx["USER"]]++
	cpu_time[$idx["USER"]]+=calc_time($idx["TIME"])

	if(process[$idx["PID"]]=="")
	{
		num_process[$idx["USER"]]++
		mem_cons[$idx["USER"]]+=$idx["SZ"]
	}

	process[$idx["PID"]]=1
}

END{
	print "Number of Users: "length(usr)
	for(i in usr)
	{
		print "Username: " i " | No. of processes: " num_process[i] " | No. of threads: " num_threads[i] " | CPU Consumption: " cpu_time[i] " | Memory Consumption: " mem_cons[i]
	}
}