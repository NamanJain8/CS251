#set term postscript eps enhanced color size 3.9,2.9
#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal png

set key font ",10"
set xtics font ",10"
set ytics font ",10"
set ylabel font ",10"
set xlabel font ",10"
set xlabel "Number of elements (log base10 scale)"
set ylabel "Time taken (in microsecs)"
set yrange[0:]
set ytic auto

set boxwidth 1 relative
set style fill pattern border

set output "plot4.png"

set style histogram errorbars lw 3
set style data histogram

plot 'p2.out' u 2:7:xticlabels(1) title "1T" fillstyle pattern 13,\
'' u 3:8 title "2T" fillstyle pattern 12,\
'' u 4:9 title "4T" fillstyle pattern 11,\
'' u 5:10 title "8T" fillstyle pattern 10,\
'' u 6:11 title "16T" fillstyle pattern 9,\

