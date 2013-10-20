## Makefile for Stat545a project, will regenerate figures and analysis

all: Figures/Debug/*.png

Data/gapminder_clean.tsv Figures/inform_*.png: Data/gapminderDataFiveYear.txt Code/01_informativeFiguresReorder.R
	R CMD BATCH --no-save Code/01_informativeFiguresReorder.R Log/01_log_informativeFiguresReorder.out
	Rscript -e "knitr::stitch_rhtml('Code/01_informativeFiguresReorder.R', output = 'Web/01_informativeFiguresReorder.html')";

Results/lifeExpLM_*.tsv Figures/res_*.png: Data/gapminder_clean.tsv Code/02_lifeExpectancyRankingAnalysis.R
	R CMD BATCH --no-save Code/02_lifeExpectancyRankingAnalysis.R Log/02_log_lifeExpectancyRankingAnalysis.out
	Rscript -e "knitr::stitch_rhtml('Code/02_lifeExpectancyRankingAnalysis.R', output = 'Web/02_lifeExpectancyRankingAnalysis.html')";

Figures/Debug/*.png: Results/lifeExpLM_*.tsv
	R CMD BATCH --no-save Code/03_debugBlankFigure.R Log/03_log_debugBlankFigure.out
	Rscript -e "knitr::stitch_rhtml('Code/03_debugBlankFigure.R', output = 'Web/03_debugBlankFigure.html')";

clean:
	rm -f Data/gapminder_clean.tsv  Figures/*.png *.png Log/*.out *.Rhistory *.out Results/* *html Web/*
	rm -f Figures/Debug/*.png




