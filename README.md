Stat545 FinalProject
====================

Final project for Stat545A at UBC with J.Bryan. This project is based on building an automated pipeline for research. As such the content of the tables, figures, and subsequent results are not the focus. The focus instead is based on designing a pipeline with make, github, RStudio and Knitr. Throughout the building process I have been using [Sourcetree](http://www.sourcetreeapp.com/) to commit early stage development (and pushing commits to github). 

I use the Gapminder data to perform the basic pipeline assembly. Since we are all intimately familiar with the dataset I will not go into any detail describing the various characteristcs. The figures and other inspiration came from JBs in class meetings and my own assignments. 


To replicate the analysis: 
* Download the following files locally: 
- Input data: ['Data/gapminderDataFiveYear.txt'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Data/gapminderDataFiveYear.txt)
- Scripts: ['Code/01_informativeFiguresReorder.R'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Code/01_informativeFiguresReorder.R) and ['Code/02_lifeExpectancyRankingAnalysis.R'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Code/02_lifeExpectancyRankingAnalysis.R)
- Makefile: ['Makefile'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Makefile)

* In a shell (be careful Windows people, I've used subdirectories and the delimiting will be different on your machine) run 'make all'

* New files after running this pipeline: 
- ['Data/gapminder_clean.tsv'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Data/gapminder_clean.tsv)
- ['Figures/inform_lifeExpectancyVsGdpPerCap_2002.png'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/inform_lifeExpectancyVsGdpPerCap_2002.png)
- ['Figures/inform_lifeExpectancyVsGdpPerCap_all_loessSmooth.png'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/inform_lifeExpectancyVsGdpPerCap_all_loessSmooth.png)
- ['Figures/inform_lifeExpectancy_measuresOfSpread.png'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/inform_lifeExpectancy_measuresOfSpread.png)
- ['Figures/res_extremeLifeExpectancy_Africa.png'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/res_extremeLifeExpectancy_Africa.png)
- ['Figures/res_extremeLifeExpectancy_Asia.png'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/res_extremeLifeExpectancy_Asia.png)
- ['Figures/res_extremeLifeExpectancy_Asia.png'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/res_extremeLifeExpectancy_Asia.png)
- ['Figures/res_extremeLifeExpectancy_Europe.png'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/res_extremeLifeExpectancy_Europe.png)
- ['Web/01_informativeFiguresReorder.html'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Web/01_informativeFiguresReorder.html)
- ['Web/02_lifeExpectancyRankingAnalysis.html'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Web/02_lifeExpectancyRankingAnalysis.html)

* To remove all of the output, ie. do some cleaning go back to shell and execute 'make clean'


