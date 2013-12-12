Stat545 FinalProject
====================

Final project for Stat545A at UBC with [Jenny Bryan](http://www.stat.ubc.ca/~jenny/). This project is based on building an automated pipeline for research. As such the content of the tables, figures, and subsequent results are not the focus. The focus instead is based on designing a pipeline with make, github, RStudio and Knitr. Throughout the building process I have been using [Sourcetree](http://www.sourcetreeapp.com/) to commit early stage development (and pushing commits to github). 

I use the Gapminder data to perform the basic pipeline assembly. Since we are all intimately familiar with the dataset I will not go into any detail describing the various characteristics. The figures and other inspiration came from JBs in class meetings and my own assignments. 


To replicate the analysis: 
* Download the following files locally: 
  - Input data: [`Data/gapminderDataFiveYear.txt`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Data/gapminderDataFiveYear.txt)
  - Scripts: [`Code/01_informativeFiguresReorder.R`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Code/01_informativeFiguresReorder.R) and [`Code/02_lifeExpectancyRankingAnalysis.R`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Code/02_lifeExpectancyRankingAnalysis.R)
  - Makefile: [`Makefile`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Makefile)

* In a shell (be careful Windows people, I've used sub-directories and the delimiting will be different on your machine) run `make all` to generate the following list of files

* New files after running this pipeline: 
  - [`Data/gapminder_clean.tsv`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Data/gapminder_clean.tsv)
  - [`Figures/inform_lifeExpectancyVsGdpPerCap_2002.png`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/inform_lifeExpectancyVsGdpPerCap_2002.png)
  - [`Figures/inform_lifeExpectancyVsGdpPerCap_all_loessSmooth.png`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/inform_lifeExpectancyVsGdpPerCap_all_loessSmooth.png)
  - [`Figures/inform_lifeExpectancy_measuresOfSpread.png`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/inform_lifeExpectancy_measuresOfSpread.png)
  - [`Figures/res_extremeLifeExpectancy_Africa.png`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/res_extremeLifeExpectancy_Africa.png)
  - [`Figures/res_extremeLifeExpectancy_Americas.png`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/res_extremeLifeExpectancy_Americas.png)
  - [`Figures/res_extremeLifeExpectancy_Asia.png`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/res_extremeLifeExpectancy_Asia.png)
  - [`Figures/res_extremeLifeExpectancy_Europe.png`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/res_extremeLifeExpectancy_Europe.png)
  - [`Web/01_informativeFiguresReorder.html`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Web/01_informativeFiguresReorder.html)
  - [`Web/02_lifeExpectancyRankingAnalysis.html`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Web/02_lifeExpectancyRankingAnalysis.html)
  - [`Web/03_debugBlankFigure.html`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Web/03_debugBlankFigure.html)
  
* To remove all of the output, ie. do some cleaning go back to shell and execute `make clean`

### Notes on debugging:

* In experimenting with various export features in my second script [`Code/02_lifeExpectancyRankingAnalysis.R`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Code/02_lifeExpectancyRankingAnalysis.R), I found that there were errors producing images from the ['d_ply'] call. 
  - In particular the first image that would have been produced appeared blank
  - Executing `ggsave` `png(..) print(p) dev.off()` did little to help either inside or outside of the `d_ply` call. 
  - The most confusing element was that the figures were successfully produced within the console on a line-by-line basis as well as when sourcing the file, but DID NOT work when using `R CMD BATCH`
  - Moving into another separate debugging file, I was unable to reproduce the errors. The debugging file, ['Code/03_debugBlankFigure.R'](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Code/03_debugBlankFigure.R) imported previously written data as a starting point for the analysis. 
  - The only difference between these two scripts is that in one (the original) the data is reordered on a levels basis and then merged with the extreme values. In the debugging script the raw file is merged. 
  - Trying to reorder before the merge in the original file did not help, either. 
  - My comments in the debugging file should provide more detailed information
* I also included many different saving methods that were attempted in the original script, all of which work in the debugging. 
* The debugging figures are located [here](https://github.com/jewellsean/Stat545_FinalProject/tree/master/Figures/Debug)
* Big picture problem: something is going on with how the data is being processed when the plot is made in console vs. `R CMD BATCH` which is sensitive to the input data's reordering. It is completely beyond me what is happening (and I, simply, cannot dedicate any more time to solving this issue)
* For the record, I also tried `Rscript` in place of `R CMD BATCH`

### Embedding a PNG instead of just linking to it

This is less slick and immediate: [`Figures/inform_lifeExpectancyVsGdpPerCap_2002.png`](https://github.com/jewellsean/Stat545_FinalProject/blob/master/Figures/inform_lifeExpectancyVsGdpPerCap_2002.png)

Nicer to embed:
  ![](https://raw.github.com/jennybc/Stat545_FinalProject/master/Figures/inform_lifeExpectancyVsGdpPerCap_all_loessSmooth_SMALL.png)
