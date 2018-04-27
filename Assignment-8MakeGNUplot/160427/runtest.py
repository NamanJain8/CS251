import subprocess
import math

if __name__=='__main__':
    params=open("params.txt",'r')
    for line in params:
        num_elements = [int(x) for x in line.split()]

    threads=open("threads.txt",'r')
    for line in threads:
        num_threads = [int(x) for x in line.split()]
        
    p1=open("p1.out",'w')
    p2=open("p2.out",'w')
    
    n=100
    
    avg=[]
    sq=[]
    for idx in range(len(num_threads)):
        avg.append(int(0))
        sq.append(int(0))
     
    for element in num_elements:
        for idx in range(len(num_threads)):
            avg[idx]=0
            sq[idx]=0
        p2.write('%d '%(math.log10(element)))
        for i in range(n):
            idx=0
            p1.write('%d '%(math.log10(element)))
            for thread in num_threads:
                cmd="./App %d %d"%(element,thread)
                time=int(subprocess.check_output(cmd,stderr=subprocess.STDOUT,shell=True).split()[3])
                p1.write('%d '%time)
                avg[idx]+=time
                sq[idx]+=time*time
                idx+=1
            p1.write('\n')
        for idx in range(len(num_threads)):
            avg[idx]/=n
            p2.write('%d '%(avg[idx]))
        for idx in range(len(num_threads)):
            std=math.sqrt(sq[idx]/n - avg[idx]*avg[idx])
            p2.write('%d '%(std) )
        p2.write('\n')
    f=open('runtest','w')
