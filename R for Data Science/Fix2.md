>I do not understand why you changed the headers..

The headers were reverted to their original state.

>2. The first plot is still not very well-formatted. For example, the distribution of data along the y axis is still very difficult to interpret from the plot -- it should probably be log transformed. The same issue applies to your plot of "CO2 emissions per capita vs GDP per capita". Finally, when an axis is log-scaled it should probably say that in the axis title -- e.g., "GDP per capital (log scale)" or something like that.

The scale of the y-axis was changed to log in both plots and labels were changed to reflect it.

>3. You mention in "3:" that you use Spearman correlation, but have not provided any statistical justification, especially given that the question asks for Pearson -- please provide this justification.

I had included the justification in Fix.md but forgot to mention it in the .Rmd. I have added it to the .Rmd.

> The preferred solutions are typically (1) to include a jitter to the plot and/or (2) to use a violin plot or strip plot. I would recommend simply adding a jitter here unless you want to change the underlying plot geometry.

The barplot with error bars was substituted by a violin plot (easier to implement and more informant).

>There is no title on your last plot.

A title was added to my last plot.

>For readability, important information should be indicated using **bold** or *italics* or some other emphasis that it makes it easy to find. Currently, all the results in your notebook are described in the same plain text as nearly everything else.

Important parts within results were boldened.

>The table in "Unguided part :1" should not be raw text - consider using a well-formatted `kable` (with the {{ kableExtra }} package) or `datatable` (from the {{ DT }} package).

The unpleasant tibble was kabled.

> It is unclear what the purpose of this hook is. Why would you need to wrap lines in the notebook?

The purpose of the hook is to ensure that no line is too long.

>some lines are too long and this hurts readability.

Lines too long were split (only done for code lines), Since
the non code ones are expected to show wrapped in the knitted
doc.

>it appears you have improperly formed markdown for your in-line code blocks.

Fixed.
