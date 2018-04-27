FLAGS= -lpthread -lm
OFILES=prog.o thread_function.o
DATA=p1.out p2.out
PLOT=plot1.png plot2.png plot3.png plot4.png

all: report

App: $(OFILES) common.h
	gcc -o $@ $(OFILES) $(FLAGS)

%.o: %.c 	
	gcc -o $@ -c $^ $(FLAGS)

runtest: App runtest.py
	python runtest.py

analyse: runtest

plot: runtest $(PLOT)

%.png: %.p
	gnuplot $^

report: plot report.log
	
report.log: report.tex
	pdflatex report.tex

.PHONY: clean cleanlatex	
clean:
	-rm -f App *.out *.aux *.log report.pdf *.png runtest *.o
cleanlatex:
	-rm -f *.aux *.log report.pdf

