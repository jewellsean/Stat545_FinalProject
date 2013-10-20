## Makefile for Stat545a project, will regenerate figures and analysis

all: Data/gapminder_clean.tsv

Data/gapminder_clean.tsv Figures/inform_*.pdf: Data/gapminderDataFiveYear.txt Code/01_informativeFiguresReorder.R
	nohup nice -19 R --no-save < Code/01_informativeFiguresReorder.R > Log/01_log_informativeFiguresReorder.out &
	
Results/lifeExpLM_*.tsv: Data/gapminder_clean.tsv Code/02_lifeExpectancyRankingAnalysis.R
	nohup nice -19 R --no-save < Code/02_lifeExpectancyRankingAnalysis.R > Log/02_log_02_lifeExpectancyRankingAnalysis.out &

clean:
	rm -f Data/gapminder_clean.tsv  Figures/*.pdf *.pdf Log/*.out *.Rhistory *.out Results/*