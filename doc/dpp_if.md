# If-expressions
- The if-expression allows you to make a logical comparison between a value and what you expect by testing for a condition and returning a result if that condition is true or false.

- If-expressions are also possible in D++:

```pawn
if.equ,1,1->using::console.println,"1 is 1";
```

You also may compare variables, consants and vice-versa.

```pawn
var::define.str,myvar,"myvar worked.";

if.equ,myvar,"myvar worked."->using::console.println,myvar;
```

---------------------------------------------------------------------------------------------------------

## `if` comparsion methods

If-method is a new term used to describe the way how are you comparing the 2 elements, there are few if-methods:

- `equ` - check if 2 elements are equal.
- `notequ` - check if 2 elements are not equal.
- `gt` - check if the 1st element greater than the 2nd element.
- `lt` - check if the 1st element less than the 2nd element.
- `ge` - check if the 1st element greater or equal to the 2nd element.
- `le` - check if the 1st element less or equal to the 2nd element.

## `else` statements

- A quick example form:

```pawn
public&form.ElseTest;
do;
	if.equ,1,2->using::console.println,"1 and 2 are equal";
	else->if.equ,2,3->using::console.println,"2 and 3 are equal";
	else->using::console.println,"Nothing is equal";

	if.equ,1,1->using::console.println,"1 and 1 are indeed equal";
	else->using::console.println,"This should not be printed";
	
	return.int,1;
end;

using::user.ElseTest;
```

Output:

```
Nothing is equal
1 and 1 are indeed equal
```