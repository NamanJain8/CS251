from __future__ import print_function
import sys
import math
import numpy as np

def displayLevel(start,end,height,level):
	if start>end:
		print(' ',sep='',end='')
		return

	mid=int((start+end)/2)
	spacecnt=int(pow(2,height-1))-1
	x=' '

	if level==0:
		print(spacecnt*x,num[mid-1],spacecnt*x,sep='',end='')
	else:
		displayLevel(start,mid-1,height,level-1)
		print(' ',sep='',end='')
		displayLevel(mid+1,end,height,level-1)
	return

numbers=[]
n=len(sys.argv)-1
numbers.append(sys.argv[1:n+1])
num=np.array(numbers,dtype=int).flatten()
num=np.sort(num)

if n==0:
	print("Invalid Input")
	exit()

height=int(math.ceil(math.log(n,2)))
level=0
while level<=height:
	displayLevel(1,n,height-level,level)
	level+=1
	print()