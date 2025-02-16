# Also
A hobby intrepreter langauge that can do a lot of things. Created as a part of course `CSC376 - Compiler Design and Construction`.

# Language Design
I have used a very simple approach and design for this language. The source code is feed to the Lexer as input which produce a list of tokens at the first scan. The token list is then passed into the Parser which evaluates the token while parsing. I have used the SDT(`Syntax Directed Translation`) parsing technique here.

# Introduction to Also
A simple, general purpose language.

### Hello World
Let's create a file called `helloworld.also` with following code:
```
print "Hello World"
```
The `print` statement prints whatever is in the Right Hand Side of it. It can print string, number, expressions, etc. Now to execute the above code, use following command:
```
also helloworld.also
```
This will run your code and you will see a `Hello World` prompt in the CLI.

### Data Type, Variables and Constants
To create a variable, we can use `var` keyword.
```
var x = 5
// we can also create a constant
const y = 5
// variable can be reassigned
x = 25
// constant can not be
y = 25 // errors
```

Also supports following data types:
- Integer
- Double
- String
- Array
- Boolean

We can use the `typeof` function to get the type of a variable or constants.
```
print typeof(x) // int
```

### Conditionals
```
if (condition) {
    // statements
} elseif (condition) {
    // statements
} else {
    // statements
}
```

### Loops
```
while(condition) {
    statements;
}
```

### Functions
We can define functions like as:
```
function fn_name(arg1, arg2) {
    // statements
    return value
}

// usage
var x = fn_name(a, b)
```

Some of the predefined library function provided by the language itself are:
- readFile
- writeFile
- appendFile
- input
- length
- pos
- substr
- typeof
- parseInt
- parseFloat

### Array
```
// Define an array
var arr = # // <- creates an empty array
var arr = [0, 2 , 3] <- creates filles array
print length(arr)
print arr[1]
```
