set terminal png

set key samplen 2 spacing 1 font ",10"


set xtics font ",10"
set ytics font ",10"
set ylabel font ",10"
set xlabel font ",10"

set xlabel "Number of elements (log base10 scale)"
set ylabel "Time taken (in microsecs)"
set ytic auto
set xtic auto

set output "plot1.png"
plot 'p1.out' using 1:2 title "1T" with points pt 3 ps 0.5,\
'' using 1:3 title "2T" with points pt 3 ps 0.5,\
'' using 1:4 title "4T" with points pt 3 ps 0.5,\
'' using 1:5 title "8T" with points pt 3 ps 0.5,\
'' using 1:6 title "16T" with points pt 3 ps 0.5

