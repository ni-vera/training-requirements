> Please add a floating TOC which would be handy to navigate long reports

Added.

> Please add code snippets to the report, and have them folded/hidden by default. Make it easier for us to look at your code and assessing your report

Done.

> Looks like you're are missing subheadings for your Venn diagrams and Volcano plots.

I added a subheading for the volcano plot. I didn't add subheadings for the Venn diagrams because I am using them to better interpret required items.

> Add a `.csl` file to make your referencing format numbered.

Added.

> Add the dataset accession code to the intro of the report

Added.

> To address (1) of the requirements, please include an interactable table of all DEGs

Included.

> For DEGs, it would be helpful to clarify that "CR vs. PD" or "CR_PD" means that CR is the numerator and PD is the denominator when calculating log2FC

A clarification has been added.

> For your Venn diagrams, change the set labels A/B/C to the actual names of the DEG contrasts

Fixed.

> You should probably also mention this condition and define `baseMean` as it is not a commonly known metric

Done.

> HEATMAPS: It's not clear which contrast pair is being shown; add a title to clarify

Tittles added.

> HEATMAPS: Add row annotations that state which genes are over-expressed, and which are under-expressed

Row annotations added.

> HEATMAPS: We want 10 over-expressed and 10 under-expressed DEGs

20 top abs substituted by top 10 over and 10 under expressed genes.

> Your ranking metric for GSEA (your R variable `vector_gsea`) uses `log2FC` which I don't think is an appropriate gene ranking metric for GSEA. Choose a more suitable metric.

log2FC was substituted by t-stat as a ranking metric.

> Since we're only looking at top 5, choose a more suitable plot than an `emapplot`

Emaplot got substituted by dot plot of top 5 up-enriched and top 5 down-enriched gene sets.

>GSEA Venn diagrams: like other Venn diagrams, change A/B/C to the actual contrast pair names

Done for all Venn diagrams.

> Use an R function to programmatically download those files (if they doesn't already exist)

Done.

> Lines 99 & 131: Move your `library(DESeq2)` to the top, and remove the redundant code

Moved.

> All triplet lapplying suggestions:

Implemented except for the heatmaps. For some unknown reason, lapplying resulted in the last plot's labels having the second's labels overlapped on them. As using a for loop didn't generate the same problem, I used one such a loop instead of lapplying.

The first of the three dotplots fails to show a single activated pathway after rendering (knitting), despite it showing within RStudio.

> All tidying suggestions:

Implemented.
