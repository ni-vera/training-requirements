>1. Don't make the selection of X or O case sensitive, currently 'x' and 'o' are invalid selections but they shouldn't be.

I used regex to ensure that the checkpoint is case insensitive.

>2. The players should be able to see the board before making a selection. Currently, after choosing O, the board is not shown to me which is important because in this case X would have gone first, and I can't see where X is placed.

To be honest in the previous version the X/O choice was just aesthetic and didn't affect the playing order. Now it does reflect the playing order.

>3. The current method of making a selection is not intuitive. Also, not everyone would have a numpad, so it would be more difficult to visualize.

Selection method was changed from numpad to row/column.

> When there's a tie, it says "StalemateEnd of game."

A conditional was added to ensure that a distinction is made between a victory and a stalemate.

>This practice highlights a problematic coding style seen throughout the notebook, especially when it comes to handling booleans

Redundant booleans were removed.

>There are many examples of repetitive code throughout this script.

Most repetitive code was made into functions.

>Also consider not using multi-nested `if...else` when practicable.

The core algorithm was remade from scratch to avoid unnecessary/conceptually inadequate ifelsing, also resulting in more inteligent computer play.

>logic of the new algorithm

The new algorithm stores, for each suitable (non-mixed) victory axis, the free positions, the number of steps to victory and the prospective victor. This information
is added to a dataframe and after all axis have been checked, the positions with the least distance to victory is selected. Victory attainment is given precedence over
user victory blocking for obvious reasons. That given, if there are several positions with the same distance to victory, one of them is randomly chosen.
