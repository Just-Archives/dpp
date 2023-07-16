# System values

- System values are variables or more-likely constants that can be accessed from the D++ code, but are used and updated internally. Below is a list of accessible system values.

## `__proccessed_form_id`

Return type: `int`

- Returns a processed form id.

```pawn
var::define.int,formid,__proccessed_form_id;
console.println,"'inlinetest' is {formid}";
```

## `__majorver`

Return type: `int`

- Returns the major version number.

## `__minorver`

Return type: `int`

- Returns the minor version number.

## `__patch`

Return type: `int`

- Returns the patch version number.

## `__release`

Return type: `int`

- Returns the version release number.

## `__beta`

Return type: `int`

- Returns 1 if the build is beta and 0 if the build is stable.