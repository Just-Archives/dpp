# While-loop
- The while statement creates a loop that executes a specified statement as long as the test condition evaluates to true. The condition is evaluated before executing the statement.

- While loops are also possible in D++:

```pawn
var::define.int,testvar,0;
while.notequ,testvar,10->var::set.int,testvar,add?testvar:1&console.println,"{testvar}";
```

Code above is going to count from 1 to 10.

You may also combine other statements; such as if-expressions; with while-loops.

```pawn
if.equ,1,1->while.equ,testvar,11->var::set.int,testvar,add?testvar:1&console.println,"This should be printed again!";
```

---------------------------------------------------------------------------------------------------------

## While-methods

While-method is a new term used to describe the way how are you comparing the 2 elements, there are few while-methods:

- `equ` - check if 2 elements are equal.
- `notequ` - check if 2 elements are not equal.