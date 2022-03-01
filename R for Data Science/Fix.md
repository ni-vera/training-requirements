> The notebook should be readable by a non-specialist. This means code and raw text output should be hidden completely by default.

Global chunk settings were changed to hide code and text output. An exception was manually made for chunks containing plotly commands, since text output is part of plotly commands.

> Plots also need to be optimized for readability. For example the very first plot has small, hard to read text and uses raw column names for the X axis. The axes is also not appropriately scaled -- consider using a log transform so the distribution of the data is easier to visualize. There is also no title and no styling/themeing applied. All of these issues need to be addressed for this plot and all others in the notebook, including the plotly ones.

Titles were added to all plots and lab readability was improved (shorter and more natural naming). Log transformation was performed for both correlation between CO2 vs GDP per cap graphs.

>For example, you use a scatter plot to visualize the year with the highest correlation between CO2 and GDP per cap (Figure 2). This is inappropriate because scatter plots are designed to visualize the relationship between two continuous variables -- but "Year" is not a continuous variable. Please consider using a different plot (bar chart, for example) -- or simply summarizing these data as a table.

The scatterplot was substituted by a barplot (a lineplot could also have been used).

 >For the first part, why are you using Pearson correlation? Does the data meet the assumptions of Pearson correlation? This should be explained in the notebook.

The data didn't meet Pearson's assumption of homoscedasticity (which was obvious from visual inspection) so Spearman correlation, which doesn't rely on homoscedasticity (since it is based on comparing each ranked value with the next one) was used.

>Only critique is your use of the Wilcoxon rank sum for a post-hoc test. I would personally have used Dunn's test and not Wilcoxon - [reason]

The test used was changed from Wilcoxon to Dunn, resulting in a slight change in results: one pair ceased to be significant.

>Your representation of the data as a lineplot with only the mean showing is inappropriate because it does not show the distibution of the data. Please redo that as another type of plot (probably paired boxplots or line plot with error bars and jitter is more appropriate)

The lineplot was substituted by a grouped barplot with error bars. While it is true that temporal, grouped barplots make temporal evolution less glaring to the  casual eye (since the x axis represents two things - group locally and time globally), the result was way more tidy than that of a lineplot with error bars (or at least than that of the lineplot with error bars that I managed to attain).

>You say "Since n > 30 we don’t need to check for normality" but you offer no citation for claiming this -- please add that.

I was doing this based on what I had been taught, but after reading this 2019 Korean paper https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6676026/ I was convinced that it's not correct.

 >The answer the last question is wrong. As a hint, check your code for bugs/errors

 For some reason slice_max() wasn't slice_maxing, so I substituted it by arranging and slice_tailing.

>Some lines are too long and this hurts readability.

A fix for this that wraps lines > n was copypasted from here:
https://github.com/yihui/knitr-examples/blob/master/077-wrap-output.Rmd unto the beginning of the document.

>`library` calls should go at the beginning the notebook only. This allows maintainer to easily see what all the requirements will be to run it.

Library calls were moved to the beginning.

>This operation (gather) should be performed with tidyverse functions

gather() was substituted by its superseder pivot_longer, as suggested.

>This `filter(x %in% as.matrix(gapminder[...]))` is not really within the tidyverse style for the `filter()` verb -- and also I'm pretty sure it isn't doing what you think it's doing. See if you can simplify this and use the `filter()` verb in a more straightforward way. A good rule of thumb is that there are very few cases with using `x$y` to access a column is going to be appropriate in tidyverse style.

Made it more tidyversal by filtering after grouping_by, obtaining the same filtering results as with the original untidy %in% filter.

> Minor point (suggested not required): you do not need to use `&` in a `filter()` verb. You can use the comma instead.

Substituted "&" for "," as an AND operator, though I still think that "&" helps the code reader because of it's more eye-catching (and feels more consistent).

>Self-reporting

Self-reporting patterns were included when possible (though arguably there would be places in which it could be attained if enough thought was put into it). The code chunk including the result of the Dunn test was set to show the result in a reader-friendly way (substituting the non-self reporting sentence that described the table).

>BRN requires all analyses to be reproducible: We do not typically use `setwd()` in code for BRN projects.

setwd() was removed.
