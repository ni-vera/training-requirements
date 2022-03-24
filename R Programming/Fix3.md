>1. Small aesthetic issue: The `You won.` message disturbs the orientation of the tic-tac-toe table. Also, there should be a new line after `You lost`.

A newline was introduced so this doesn't happen.

>The styling can be improved in places, for example, the character limit for each line should be around 80, in `Line 157` you have 136 characters, which is not good.

The infractor lines were split.

>1. `Line 66-68` and `Line 114-116`: For the `for loop`, firstly, the variations of `apply()` functions does allow iterations with indexes. I suggest you take time to read more about them and implement them.

All loops were turned into lapply functions (with the modification of some functions that this implies).

>2. Try to reduce the repetitive code, like the nested `if...else` from `line 177-216`. There is a lot of repetitive code used here, which should be reduced and simplified, like the use of `str_detect()` and the following.

The str_detect() expressions were modified. The other pattern was not modified, since other required modification (not using assign()) was incompatible with this
modification (putting victory checking within another function can only be done if we can declare global variables from within that function, so it can't be put within other function and thus has to be repeated each time).

>. `Line 91-100`: You could have used `verifier <- all(c(x, y) %in% 1:3)` instead.

Proposed change implemented.

>2. `Line 36`: Your use of boolean operators can be simplified like instead of `TRUE %in% x` use `any(x)`, it also provides NA handling capabilities if needed.

Proposed change implemented.

 >4. `Line 144-146`: This code seems unreachable, and should be removed in that case.

 Line 144-146 wqs removed.

 >4. Avoid the use of `assign()`

 Assign was substituted by common assignment method "<-"

>5. Even though the game logic functions properly, making your code self-explanatory is very important, your functions like `computer_turn` or formulas used in `rankadd`, are not understood clearly

The logic of these functions has been explained a bit. 
