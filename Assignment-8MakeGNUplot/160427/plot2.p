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

set output "plot2.png"
plot 'p2.out' using 1:2 title "1T" with linespoints pt 5 lc 5,\
'' using 1:3 title "2T" with linespoints pt 5 lc 4,\
'' using 1:4 title "4T" with linespoints pt 5 lc 3,\
'' using 1:5 title "8T" with linespoints pt 5 lc 2,\
'' using 1:6 title "16T" with linespoints pt 5 lc 1
