>1. The player should be able to see the board before making the first move. When the player chooses `O` the board is seen first, but for `X' board is not seen first.

An initial show of the empty table has been added in case the player chooses to play first.

>2. The player should be informed they won or lost the game along with `End of Game`.

The end of game message was made player-sensitive by adding a conditional after each victory checking.

> 3. I was given an error with a valid input

The cause of the error was identified and fixed.

>4. There also exists a bug with whitespaces in input: ![Whitespace Bug](https://ibb.co/PwWkxVQ). The programme should be able to ignore such cases.

I wasn't able to replicate this error: https://ibb.co/qDD4Ksp. This may be due to me playing in a Linux shell and you playing in some windows command shell which is processing input differently and including the spaces. I doubt that though since one of the conditions is that nchar is 1.

>5. The X-O bug: ![X-O bug](https://ibb.co/r47gHFr) and also ![X-O bug v2](https://ibb.co/z7h94gF). These bugs can make the game unplayable at times.

The cause of the bug was identified and fixed.


 >1. The style of the code can improve,  like some errors in the use of [whitespaces]

 The function style_dir() of the package styler was used to polish the style.

 >2. The aesthetics can be improved by introducing new line character `\n` and whitespaces in the output terminal, it looks congested right now.

Newlining was implemented when necessary.

> 3. You can improve your commenting, try to reduce the [bad habbits]

Some comments have been deleted in line with the recommendations shown in the linked webpage.

>There is no need to `return bools` in R programming.

The alternative, more elegant way suggested was implemented.

>Reduce the use of `for` loops

For loops were used because the apply function doesn't feature iteration indexing which is necessary here (the matrix index is obtained from a formula that
contains the row/col index). There are convoluted ways to allow index access by the apply function but they are not really worth it over a loop.
