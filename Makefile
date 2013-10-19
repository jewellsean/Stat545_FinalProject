## Makefile for Stat545a project, will regenerate figures and analysis

all: Data/gapminder_clean.tsv

Data/gapminder_clean.tsv Figures/inform_*.pdf: Data/gapminderDataFiveYear.txt Code/01_informativeFiguresReorder.R
	nohup nice -19 R --no-save < Code/01_informativeFiguresReorder.R > Log/01_log_informativeFiguresReorder.out &
	
##stripplot_wordsByRace_*.png totalWordsByFilmRace.tsv: lotr_clean.tsv 02_aggregatePlot.R
## fix for tab in nohup nice -19 R --no-save < Code/02_lifeExpectancyRankingAnalysis.R > Log/02_log_02_lifeExpectancyRankingAnalysis.out &

clean:
	rm -f Data/gapminder_clean.tsv  Figures/*.pdf *.pdf Log/*.out *.Rhistory *.out