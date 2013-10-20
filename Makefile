## Makefile for Stat545a project, will regenerate figures and analysis

all: Results/lifeExpLM_*.tsv

Data/gapminder_clean.tsv Figures/inform_*.pdf: Data/gapminderDataFiveYear.txt Code/01_informativeFiguresReorder.R
	R CMD BATCH --no-save Code/01_informativeFiguresReorder.R Log/01_log_informativeFiguresReorder.out
	Rscript -e "knitr::stitch_rhtml('Code/01_informativeFiguresReorder.R', output = 'Web/01_informativeFiguresReorder.html')";

Results/lifeExpLM_*.tsv Figures/res_*.pdf: Data/gapminder_clean.tsv Code/02_lifeExpectancyRankingAnalysis.R
	R CMD BATCH --no-save Code/02_lifeExpectancyRankingAnalysis.R Log/02_log_lifeExpectancyRankingAnalysis.out
	Rscript -e "knitr::stitch_rhtml('Code/02_lifeExpectancyRankingAnalysis.R', output = 'Web/02_lifeExpectancyRankingAnalysis.html')";

clean:
	rm -f Data/gapminder_clean.tsv  Figures/*.pdf *.pdf Log/*.out *.Rhistory *.out Results/* *html *md Web/*




