# Foreach-loop and iterators

- In computer programming, an iterator is an object that enables a programmer to traverse a container, particularly lists - whereas a foreach loop (or for-each loop) is a control flow statement for traversing items in a collection. 

## Example

```pawn
iter::define,testiter,100;
var::define.int,foreachtestvar,0;

iter::add,testiter,1;
iter::add,testiter,10;
iter::remove,testiter,1;

foreach.int&var,foreachtestvar,testiter->console.println,"foreach test {foreachtestvar}";

iter::add,testiter,1;

foreach.int&var,foreachtestvar,testiter->console.println,"foreach test #2 {foreachtestvar}";

iter::delete,testiter;
```

Output:

```
foreach test 10
foreach test #2 1
foreach test #2 10
```

## Example `#2`

- Iterators inside classes.

```pawn
public&class.IterClass;
do;
	iter::define,iter,10;
end;

iter::add,IterClass:iter,364;
foreach.int&var,foreachtestvar,IterClass:iter->console.println,"foreach test #3 {foreachtestvar}";
```

Output:

```
foreach test #3 364
```

## `sizeof` instruction

- `sizeof` is a keyword you may have seen in a huge variety of programming languages. In D++, `sizeof` is by-default enabled instruction which returns the size of an iterator.


```pawn
console.cout,sizeof?testiter;
```

Output:

```
100
```