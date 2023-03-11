
# TEST LOADING SPEED  


**Lot of Code Block**



## OVERVIEW

Tcl is shortened form of **Tool Command Language**

## SPECIAL VARIABLES

The list of specials variables is listed below: 
**argc**						Refers to a number of command-line arguments.
**argv**						Refers to the list containing the command-line arguments.
**argv0**						Name of file being interpreted or the name by which we invoke the script.
**errorCode**				Provides the error code for last Tcl error.
**errorInfo**				Provides the stack trace for last Tcl error.
**tcl_interactive**		Switch between interactive/non-interactive modes by setting this to 1 and 0 
**tcl_library**				Used for setting the location of standard Tcl libraries.
**tcl_patchLevel**		Refers to the current patch level of the Tcl interpreter.
**tcl_platform**			Array of elements with objects byteOrder, machine, osVersion, platform, and os.
**tcl_precision**			Number of digits to retain when convert floating-point numbers to strings (12)
**tcl_prompt1**			Refers to the primary prompt.
**tcl_prompt2**			Refers to the secondary prompt with invalid commands.
**tcl_rcFileName**		Provides the user specific startup file.
**tcl_traceCompile**	Control the tracing of bytecode compilation. 0=no output, 1=summary, 2=detail
**tcl_traceExec**		Control the tracing of bytecode compilation. 0=no output, 1=summary, 2=detail
**tcl_version**			Returns the current version of the Tcl interpreter.

The above special variables have their special meanings for the Tcl interpreter.
__Examples for using Tcl special variables__
- Tcl version : `puts $tcl_version`						Return 8.6
- Tcl Environment Path: `puts $env(Path)`		Returns /usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
- Tcl Package Path : `puts $tcl_pkgPath`			Returns  /usr/lib64/tcl8.6 /usr/share/tcl8.6
- Tcl Library: `puts $tcl_library`						Returns  /usr/share/tcl8.6
- Tcl Patch Level : `puts $tcl_patchLevel`		Returns  8.6.6
- Tcl Precision:  `puts $tcl_precision`				Returns 0
- Tcl Startup File : `puts $tcl_rcFileName`		Returns  ~/.tclshrc

## BASIC SYNTAX

In Tcl, we use new line or semicolon to terminate the previous line of code. 
But semicolon is not necessary, if you are using newline for each command.

### First Tcl Program
```tcl
puts "Hello, World";  # Return Hello, World
```
### Comments
Comments are like helping text in your Tcl program and the interpreter ignores them. 
- Comments can be written using a hash_(#) sign in the beginning.
`# my first program in Tcl`
- Multiline/block comment is written using 'if' with condition '0'
	if 0 {  my first program in Tcl program }
- Inline comments use ;#
`puts "Hello World!";    # my first print in Tcl program`

###  Identifiers
A Tcl identifier is a name used to identify a variable, function, or any other user-defined item. An identifier starts with a letter A to Z or a to z or an underscore (_) followed by zero or more letters, underscores, dollars ($) , and digits (0 to 9).
Tcl does not allow punctuation characters such as @, and % within identifiers. Tcl is a **case sensitive** language. Thus *Manpower* and *manpower* are two different identifiers in Tcl. Here are some of the examples of acceptable identifiers :
mohd       zara    abc   move_name  a_123
myname50   _temp   j     a23b9      retVal

### Reserved Words
The following list shows a few of the reserved words in Tcl. 
These reserved words may not be used as constant or variable or any other identifier names.
```tcl
after	append	array	auto_execok	auto_import	auto_load	auto_load_index auto_qualify
binary	bgerror	break	catch  cd	clock	close concat  continue	dde	default
else  elseif	  encoding	eof	error  eval	exec	exit	expr
fblocked		fconfigure	fcopy	file	fileevent	flush	for	foreach  format
gets	 glob	global	history	if	info	interp  join	
lappend	lindex	linsert  list	 llength	load	lrange	lreplace	lsearch	lsort	namespace  open	 package	 pid	 pkg_mkIndex  proc	puts	pwd	
read		regexp	regsub	rename	resource  return	scan	seek	set  socket	source	split	string	subst 	switch	tclLog	tell  time	trace	unknown	unset  update	uplevel	upvar	variable	vwait while
```
### Whitespace in Tcl
A line containing only whitespace, possibly with a comment, is known as a **blank line**, and a Tcl interpreter totally ignores it.
Whitespace is the term used in Tcl to describe blanks, tabs, newline characters, and comments. Whitespace separates one part of a statement from another and enables the interpreter to identify where one element in a statement, such as puts, ends and the next element begins. Therefore, in the following statement :

puts "Hello World!" 
There must be at least one whitespace character (usually a space) between “puts” and "Hello World!" for the interpreter to be able to distinguish them. On the other hand, in the following statement : `puts [expr 3 + 2] ;# print sum of the 3 and 2`
When the above code is executed, it produces the following result : 5
No whitespace characters are necessary between 3 and +, or between + and 2; although, you are free to include some if you wish for the readability purpose.

## COMMANDS

As you know, Tcl is a Tool command language, commands are the most vital part of the language. Tcl commands are built in-to the language with each having its own predefined function. These commands form the reserved words of the language and cannot be used for other variable naming. The advantage with these Tcl commands is that, you can define your own implementation for any of these commands to replace the original built-in functionality.
Each of the Tcl commands validates the input and it reduces the work of the interpreter.
Tcl command is actually a list of words, with the first word representing the command to be executed. The next words represent the arguments. In order to group the words into a single argument, we enclose multiple words with "" or {}.
The syntax of Tcl command is as follows :
commandName argument1 argument2 ... argumentN

Let's see a simple example of Tcl command :  `puts "Hello, world!"`
When the above code is executed, it produces the following result : Hello, world!
In the above code, ‘puts’ is the Tcl command and "Hello World" is the argument1. As said before, we have used "" to group two words.
Let's see another example of Tcl command with two arguments : ` puts stdout "Hello, world!" `
When the above code is executed, it produces the following result :
Hello, world!
In the above code, ‘puts’ is the Tcl command, ‘stdout’ is argument1, and "Hello World" is argument2. Here, stdout makes the program to print in the standard output device.

### Command Substitution
In command substitutions, square brackets are used to evaluate the scripts inside the square brackets. A simple example to add two numbers is shown below : ` puts [expr 1 + 6 + 9] `
When the above code is executed, it produces following result : 16

### Variable Substitution
In variable substitutions, $ is used before the variable name and this returns the contents of the variable. A simple example to set a value to a variable and print it is shown below.
```tcl
set a 3
puts $a;  # Return 3
```
### Backslash Substitution
These are commonly called **escape sequences**; with each backslash, followed by a letter having its own meaning. A simple example for newline substitution is shown below :
`puts "Hello\nWorld"`
When the above code is executed, it produces the following result :
Hello
World

## DATA TYPES

The primitive data-type of Tcl is string and often we can find quotes on Tcl as string only language. These primitive data-types in turn create composite data-types for list and associative array. In Tcl, data-types can represent not only the simple Tcl objects, but also can represent complex objects such as handles, graphic objects (mostly widgets), and I/O channels. Let's look into the details about each of the above.

### Simple Tcl Objects
In Tcl, whether it is an integer number, boolean, floating point number, or a string. When you want to use a variable, you can directly assign a value to it, there is no step of declaration in Tcl. There can be internal representations for these different types of objects. It can transform one data-type to another when required. The syntax for assigning value to variable is as follows :
```tcl
set myVariable 18
puts $myVariable
```
When the above code is executed, it produces the following result : 18

The above statement will create a variable name myVariable and stores it as a string even though, we have not used double quotations. Now, if we try to make an arithmetic on the variable, it is automatically turned to an integer. A simple example is shown below :
```tcl
set myVariable 18
puts [expr $myVariable + 6 + 9];   # Return 33
```
One important thing to note is that, these variables don't have any default values and must be assigned value before they are used.
If we try to print using puts, the number is transformed into proper string. Having two representations, internal and external, help Tcl to create complex data structures easily compared to other languages. Also, Tcl is more efficient due to its dynamic object nature.

### String

Unlike other languages, in Tcl, you need not include double quotes when it's only a single word. An example can be :
```tcl
set myVariable hello
puts $myVariable
```
When the above code is executed, it produces the following result :
hello
When we want to represent multiple strings, we can use either double quotes or curly braces. It is shown below :
```tcl
set myVariable "hello world"
puts $myVariable
set myVariable {hello world}
puts $myVariable
```
When the above code is executed, it produces the following result :
hello world
hello world

### List
List is nothing but a group of elements. A group of words either using double quotes or curly braces can be used to represent a simple list. A simple list is shown below :
```tcl
set myVariable {red green blue}
puts [lindex $myVariable 2]
set myVariable "red green blue"
puts [lindex $myVariable 1]
```
When the above code is executed, it produces the following result :
blue
green

### Associative Array
Associative arrays have an index (key) that is not necessarily an integer. It is generally a string that acts like key value pairs. A simple example is shown below :
```tcl
set  marks(english) 80
puts $marks(english);  # Return 80
set  marks(mathematics) 90
puts $marks(mathematics); # Return 90
```
### Handles
Tcl handles are commonly used to represent files and graphics objects. These can include handles to network requests and also other channels like serial port communication, sockets, or I/O devices. The following is an example where a file handle is created : ` set myfile [open "filename" r] `


## VARIABLES

In Tcl, there is no concept of variable declaration. Once, a new variable name is encountered, Tcl will define a new variable.

### Variable Naming
The name of variables can contain any characters and length. You can even have white spaces by enclosing the variable in curly braces, but it is not preferred.
The set command is used for assigning value to a variable. 
The syntax for set command is : `set variableName value`
A few examples of variables are shown below :
```tcl
set varA 10
set {variable B} test
puts $varA;  # Return 10
puts ${variable B};  # Return test
```
As you can see in the above program, the $variableName is used to get the value of the variable.

### Dynamic Typing
Tcl is a dynamically typed language. The value of the variable can be dynamically converted to the required type when required. For example, a number 5 that is stored as string will be converted to number when doing an arithmetic operation. It is shown below :
```tcl
set varA "10"
puts $varA;  # Return 10
set sum [expr $varA +20];
puts $sum;  # Return 30
```
When the above code is executed, it produces the following result :
10
30

### Mathematical Expressions
As you can see in the above example, expr is used for representing mathematical expression. The default precision of Tcl is 12 digits. In order to get floating point results, we should add at least a single decimal digit. A simple example explains the above.
```tcl
set varA "10"
set result [expr $varA / 9];   #return 1
puts $result
set result [expr $varA / 9.0];   #return 1.1111111111111112
puts $result
set varA "10.0"
set result [expr $varA / 9];    #return 1.1111111111111112
puts $result
```
In the above example, you can see three cases. In the first case, the dividend and the divisor are whole numbers and we get a whole number as result. In the second case, the divisor alone is a decimal number and in the third case, the dividend is a decimal number. In both second and third cases, we get a decimal number as result.
In the above code, you can change the precision by using tcl_precision special variable. It is shown below :
```tcl
set varA "10"
set tcl_precision 5
set result [expr $varA / 9.0];
puts $result;   #return 1.1111
```

## OPERATORS

Perform specific mathematical or logical manipulations with  the following types of operators :
	- Arithmetic Operators
	- Relational Operators
	- Logical Operators
	- Bitwise Operators
	- Ternary Operator

### Arithmetic Operators
Assume variable ‘A’ holds 10 and variable ‘B’ holds 20, then :
- Adds two operands:    A + B will give 30
- Subtracts second operand from the first : A - B will give -10
- Multiplies both operands:  A * B will give 200
- Divides numerator by de-numerator  :  B / A will give 2
- Modulus Operator and remainder of after an integer division : B % A will give 0

### Relational Operators
Assume variable A holds 10 and variable B holds 20, then :
- Checks if the values of two operands are equal or not, if yes then condition becomes true.
(A == B) is not true.
- Checks if the values of two operands are equal or not, if values are not equal then condition becomes true.
(A != B) is true.
- Checks if the value of left operand is greater than the value of right operand, if yes then condition becomes true.
(A > B) is not true.
- Checks if the value of left operand is less than the value of right operand, if yes then condition becomes true.
(A < B) is true.
- Checks if the value of left operand is greater than or equal to the value of right operand, if yes then condition becomes true.
(A >= B) is not true.
- Checks if the value of left operand is less than or equal to the value of right operand, if yes then condition becomes true.
(A <= B) is true.

### Logical Operators
Following table shows all the logical operators supported by Tcl language. 
Assume variable A holds 1 and variable B holds 0, then :
Called Logical AND operator. If both the operands are non-zero, then condition becomes true.
(A && B) is false.
Called Logical OR Operator. If any of the two operands is non-zero, then condition becomes true.
`(A || B) is true.`
Called Logical NOT Operator. Use to reverses the logical state of its operand. If a condition is true then Logical NOT operator will make false.
!(A && B) is true.

### Bitwise Operators

Bitwise operator works on bits and perform bit-by-bit operation. 
The truth tables for &, |, and ^ are as follows :
p				0	0	0	0	0
q				0	1	0	1	1
p & q		1	1	1	1	0
p | q			1	0	0	1	1
p ^ q
Assume if A = 60; and B = 13; now in binary format they will be as follows :
A = 0011 1100
B = 0000 1101
A&amp;B = 0000 1100
A|B = 0011 1101
A^B = 0011 0001

The Bitwise operators supported by Tcl language are listed in the following table. 
Assume variable A holds 60 and variable B holds 13, then :
- Binary AND Operator copies a bit to the result if it exists in both operands.
(A & B) will give 12, which is 0000 1100
- Binary OR Operator copies a bit if it exists in either operand.
(A | B) will give 61, which is 0011 1101
- Binary XOR Operator copies the bit if it is set in one operand but not both : 
	(A ^ B) will give 49, which is 0011 0001
- Binary Left Shift Operator. The left operands value is moved left by number of bits specified by the right operand : 
	A << 2 will give 240, which is 1111 0000
- Binary Right Shift Operator. The left operands value is moved right by the number of bits specified by the right operand : 
A >> 2 will give 15, which is 0000 1111

### Ternary Operator
Operator	Description Example
If Condition is true? Then value X : Otherwise value Y

### Operators Precedence in Tcl
Operator precedence determines the grouping of terms in an expression. This affects how an expression is evaluated. Certain operators have higher precedence than others; for example, the multiplication operator has higher precedence than the addition operator.
**For example** : x = 7 + 3 * 2; here, x is assigned 13, not 20 because operator * has higher precedence than +, so it first gets multiplied with 3 * 2 and then adds into 7.
Here, operators with the highest precedence appear at the top of the table, those with the lowest appear at the bottom. Within an expression, higher precedence operators will be evaluated first.
- Unary					+ -					Right to left
- Multiplicative		* / %				Left to right
- Additive				+ -					Left to right
- Shift					<< >>			Left to right
- Relational			< <= > >=		Left to right
- Bitwise AND			&				Left to right
- Bitwise XOR			^				Left to right
- Bitwise OR				|				Left to right
- Logical AND			&&			Left to right
- Logical OR				\|\|				Left to right
- Ternary					?:				Right to left

## DECISIONS

Decision making structures require that the programmer specifies one or more conditions to be evaluated or tested by the program, along with a statement or statements to be executed if the condition is determined to be true, and optionally, other statements to be executed if the condition is determined to be false.
Tcl language uses the expr command internally and hence it’s not required for us to use expr statement explicitly.
Tcl language provides following types of decision making statements :
- **if** statement : An 'if' statement consists of a Boolean expression followed by one or more statements.
- **if...else** statement : An 'if' statement can be followed by an optional 'else' statement, which executes when the Boolean expression is false.
- **nested if** statements : You can use one 'if' or 'else if' statement inside another 'if' or 'else if statement(s).
- **switch** statement : A switch statement allows a variable to be tested for equality against a list of values.
- **nested switch** statements : 
You can use one switch statement inside another switch statement(s).


### The ? : Operator
We have covered **conditional operator ? :** in previous chapter, which can be used to replace **if...else** statements. It has the following general form :

Exp1 ? Exp2 : Exp3;

Where Exp1, Exp2, and Exp3 are expressions. Notice the use and placement of the colon.
The value of a '? expression' is determined like this: Exp1 is evaluated. If it is true, then Exp2 is evaluated and becomes the value of the entire '? expression.' If Exp1 is false, then Exp3 is evaluated and its value becomes the value of the expression. An example is shown below.
```tcl
set a 10;
set b [expr $a == 1 ? 20: 30]
puts "Value of b is $b\n"
set b [expr $a == 10 ? 20: 30]
puts "Value of b is $b\n"
``` 
When you compile and execute the above program, it produces the following result :
Value of b is 30
Value of b is 20

## LOOPS

There may be a situation, where you need to execute a block of code several number of times. In general, statements are executed sequentially: The first statement in a function is executed first, followed by the second, and so on.
Programming languages provide various control structures that allow for more complicated execution Paths.
A loop statement allows us to execute a statement or group of statements multiple times and following is the general form of a loop statement
Tcl language provides the following types of loops to handle looping requirements.
- while loop : Repeats a statement or group of statements while a given condition is true. It tests the condition before executing the loop body.
- for loop : Executes a sequence of statements multiple times and abbreviates the code that manages the loop variable.
- nested loops : You can use one or more loop inside any another while, for or do..while loop.


### Loop Control Statements
Loop control statements change execution from its normal sequence. When execution leaves a scope, all automatic objects that were created in that scope are destroyed.
Tcl supports the following control statements.
**break**  : Terminates the loop or switch statement and transfers execution to the statement immediately following the loop or switch.
**continue** : Causes the loop to skip the remainder of its body and immediately retest its condition prior to reiterating.


### The Infinite Loop
The **while** loop is traditionally used for this purpose. You can make an endless loop by leaving the conditional expression as 1.
`while {1} { puts "This loop will run forever." }`
When the conditional expression is absent, it is assumed to be true. 
_NOTE: You can terminate an infinite loop by pressing Ctrl + C keys._

## ARRAYS

An array is a systematic arrangement of a group of elements using indices. The syntax for the conventional array is shown below.
set ArrayName(Index) value
An example for creating simple array is shown below.
```tcl
set languages(0) Tcl
set languages(1) "C Language"
puts $languages(0)
puts $languages(1)
```
When the above code is executed, it produces the following result :
Tcl
C Language

### Size of Array
The syntax for calculating size array is shown below.
[array size variablename]
An example for printing the size is shown below.
```tcl
set languages(0) Tcl
set languages(1) "C Language"
puts  [array size languages]
```
When the above code is executed, it produces the following result :
2

### Array Iteration
Though, array indices can be non-continuous like values specified for index 1 then index 10 and so on. But, in case they are continuous, we can use array iteration to access elements of the array. A simple array iteration for printing elements of the array is shown below.
```tcl
set languages(0) Tcl
set languages(1) "C Language"
for { set index 0 }  { $index < [array size languages] }
  { incr index } {
   puts "languages($index) : $languages($index)"
}
```
When the above code is executed, it produces the following result :
languages(0) : Tcl
languages(1) : C Language

### Associative Arrays
In Tcl, all arrays by nature are associative. Arrays are stored and retrieved without any specific order. Associative arrays have an index that is not necessarily a number, and can be sparsely populated. A simple example for associative array with non-number indices is shown below.
```tcl
set personA(Name) "Dave"
set personA(Age) 14
puts  $personA(Name)
puts  $personA(Age)
```
When the above code is executed, it produces the following result :
Dave
14

### Indices of Array
The syntax for retrieving indices of array is shown below.
[array names variablename]
An example for printing the size is shown below.
```tcl
set personA(Name) "Dave"
set personA(Age) 14
puts [array names personA]
```
When the above code is executed, it produces the following result :
Age Name

### Iteration of Associative Array
You can use the indices of array to iterate through the associative array. An example is shown below.
```tcl
set personA(Name) "Dave"
set personA(Age) 14
foreach index [array names personA] {
   puts "personA($index): $personA($index)"
}
```
When the above code is executed, it produces the following result :
personA(Age): 14
personA(Name): Dave

## STRINGS

The primitive data-type of Tcl is string and often we can find quotes on Tcl as string only language. These strings can contain alphanumeric character, just numbers, Boolean, or even binary data. Tcl uses 16 bit unicode characters and alphanumeric characters can contain letters including non-Latin characters, number or punctuation.
Boolean value can be represented as 1, yes or true for true and 0, no, or false for false.

### String Representations
Unlike other languages, in Tcl, you need not include double quotes when it's only a single word. An example can be :
```tcl
set myVariable hello
puts $myVariable
```
When the above code is executed, it produces the following result :
hello

When we want to represent multiple strings, we can use either double quotes or curly braces. It is shown below :
```tcl
set myVariable "hello world"
puts $myVariable
set myVariable {hello world}
puts $myVariable
```
When the above code is executed, it produces the following result :
hello world
hello world

### String Escape Sequence
A character literal can be a plain character (e.g., 'x'), an escape sequence (e.g., '\t'), or a universal character (e.g., '\u02C0').
There are certain characters in Tcl when they are preceded by a backslash they will have special meaning and they are used to represent like newline (\n) or tab (\t). 
List of some of such escape sequence codes :
\\
\'
\"
\?
\a		Alert or bell
\b		Backspace
\f		Form feed
\n		Newline
\r		Carriage return
\t		Horizontal tab
\v		Vertical tab
	
### String Command
The list of subcommands for string command is listed in the following table :
**compare** string1 string2			Returns 0 if equal, -1 if string1 comes before string2, else 1.
**first** string1 string2			Returns the index first occurrence of string1 in string2. If not found, returns -1.
**index** string index			Returns the character at index.
**last** string1 string2			Returns the index last occurrence of string1 in string2. If not found, returns -1.
**length** string			Returns the length of string.
**match pattern** string			Returns 1 if the string matches the pattern.
**range** string index1 index2			Return the range of characters in string from index1 to index2.
**tolower** string			Returns the lowercase string.
**toupper** string			Returns the uppercase string.
**trim** string ?trimcharacters?			Removes trimcharacters in both ends of string. 
				default trimcharacters: whitespace.
**trimleft** string ?trimcharacters?	Removes trimcharacters in left beginning of string. 
				The default trimcharacters is whitespace.
**trimright** string ?trimcharacters?	Removes trimcharacters in left end of string. 
				The default trimcharacters is whitespace.
**- wordend** findstring index			Return the index in findstring of the character after the word containing the character at index.
**- wordstart** string index			Return index in string of the first character in the word containing the character at index.
Examples of some commonly used Tcl string sub commands are given below.

### String Comparison
```tcl
set s1 "Hello"
set s2 "World"
set s3 "World"
puts [string compare s1 s2]
if {[string compare s2 s3] == 0} {  puts "String \'s1\' and \'s2\' are same."; } 
if {[string compare s1 s2] == -1} { puts "String \'s1\' comes before \'s2\'."; }
if {[string compare s2 s1] == 1} { puts "String \'s2\' comes after \'s1\'."; }
```
When the above code is compiled and executed, it produces the following result :
-1
String 's1' comes before 's2'.
String 's2' comes after 's1'.

### Index of String
```tcl
set s1 "Hello World"
set s2 "o"
puts "First occurrence of $s2 in s1"
puts [string first $s2 $s1]
puts "Character at index 0 in s1"
puts [string index $s1 0]
puts "Last occurrence of $s2 in s1"
puts [string last $s2 $s1]
puts "Word end index in s1"
puts [string wordend $s1 20]
puts "Word start index in s1"
puts [string wordstart $s1 20]
```
When the above code is compiled and executed, it produces the following result :
First occurrence of o in s1
4
Character at index 0 in s1
H
Last occurrence of o in s1
7
Word end index in s1
11
Word start index in s1
6

### Length of String
```tcl
set s1 "Hello World"
puts "Length of string s1"
puts [string length $s1]
```
When the above code is compiled and executed, it produces the following result :
Length of string s1
11

### Upper/Lower Case
```tcl
set s1 "Hello World"
puts "Uppercase string of s1"
puts [string toupper $s1]
puts "Lowercase string of s1"
puts [string tolower $s1]
```
When the above code is compiled and executed, it produces the following result :
Uppercase string of s1
HELLO WORLD
Lowercase string of s1
hello world

### Trimming Characters
```tcl
set s1 "Hello World"
set s2 "World"
puts "Trim right $s2 in $s1"
puts [string trimright $s1 $s2]
set s2 "Hello"
puts "Trim left $s2 in $s1"
puts [string trimleft $s1 $s2]
set s1 " Hello World "
set s2 " "
puts "Trim characters s1 on both sides of s2"
puts [string trim $s1 $s2]
```
When the above code is compiled and executed, it produces the following result :
Trim right World in Hello World
Hello 
Trim left Hello in Hello World
 World
Trim characters s1 on both sides of s2
Hello World

### Matching Strings
```tcl
set s1 "test@test.com" 
set s2 "*@*.com"
puts "Matching pattern s2 in s1"
puts [string match "*@*.com" $s1 ]
puts "Matching pattern tcl in s1"
puts [string match {tcl} $s1]
```
When the above code is compiled and executed, it produces the following result :
Matching pattern s2 in s1
1
Matching pattern tcl in s1
0

### Append Command
```tcl
set s1 "Hello" 
append s1 " World"
puts $s1
```
When the above code is compiled and executed, it produces the following result :
Hello World

### Format command
The following table shows the list of format specifiers available in Tcl :
%s	String representation
%d	Integer representation
%f	Floating point representation
%e	Floating point representation with mantissa-exponent form
%x	Hexa decimal representation
Some simple examples are given below :
```tcl
puts [format "%f" 43.5];							# return 43.500000
puts [format "%e" 43.5];							# return 4.350000e+01
puts [format "%d %s" 4 tuts];				# return 4 tuts
puts [format "%s" "Tcl Language"];  # return Tcl Language
puts [format "%x" 40];								# return 28
```
### Scan command
Scan command is used for parsing a string based to the format specifier. Some examples are shown below.
```tcl
puts [scan "90" {%[0-9]} m]
puts [scan "abc" {%[a-z]} m]
puts [scan "abc" {%[A-Z]} m]
puts [scan "ABC" {%[A-Z]} m]
```
When the above code is compiled and executed, it produces the following result :
1
1
0
1

## LISTS

List is one of the basic data-type available in Tcl. It is used for representing an ordered collection of items. It can include different types of items in the same list. Further, a list can contain another list.
An important thing that needs to be noted is that these lists are represented as strings completely and processed to form individual items when required. So, avoid large lists and in such cases; use array.

### Creating a List
The general syntax for list is given below :
set listName { item1 item2 item3 .. itemn }
set listName [list item1 item2 item3]
set listName [split "items separated by a character" split_character]

Some examples are given below :
```tcl
set colorList1 {red green blue}
set colorList2 [list red green blue]
set colorList3 [split "red_green_blue" _]
puts $colorList1
puts $colorList2
puts $colorList3
```
When the above code is executed, it produces the following result :
red green blue
red green blue
red green blue

### Appending Item to a List
The syntax for appending item to a list is given below :
append listName split_character value
lappend listName value
Some examples are given below :
```tcl
set var orange
append var " " "blue"
lappend var "red" 
lappend var "green" 
puts $var
```
When the above code is executed, it produces the following result :
orange blue red green

### Length of List
The syntax for length of list is given below :
llength listName
Example for length of list is given below :
```tcl
set var {orange blue red green}
puts [llength $var] 
```
When the above code is executed, it produces the following result :
4

### List Item at Index
The syntax for selecting list item at specific index is given below :
lindex listname index
Example for list item at index is given below :
```tcl
set var {black blue red green}
puts [lindex $var  1]; # return blue
```

### Insert Item at Index
The syntax for inserting list items at specific index is given below.
linsert listname index value1 value2..valuen
Example for inserting list item at specific index is given below.
```tcl
set var {orange blue red green}
set var [linsert  $var 3 black white]
puts $var
```
When the above code is executed, it produces the following result :
orange blue red black white green

### Replace Items at Indices
The syntax for replacing list items at specific indices is given below :
lreplace listname firstindex lastindex value1 value2..valuen
Example for replacing list items at specific indices is given below.
```tcl
set var {orange blue red green}
set var [lreplace $var 2 3 black white]
puts $var
```
When the above code is executed, it produces the following result :
orange blue black white

### Set Item at Index
The syntax for setting list item at specific index is given below :
lset listname index value 
Example for setting list item at specific index is given below :
```tcl
set var { brown blue red green }
lset var 0 black 
puts $var;  # return black blue red green
```

### Transform List to Variables
The syntax for copying values to variables is given below :
lassign listname variable1 variable2.. variablen
Example for transforming list into variables is given below :
```tcl
set var {orange blue red green}
lassign $var colour1 colour2
puts $colour1
puts $colour2
```
When the above code is executed, it produces the following result :
orange
blue

### Sorting a List
The syntax for sorting a list is given below :
lsort listname
An example for sorting a list is given below :
```tcl
set var {orange blue red green}
set var [lsort $var]
puts $var
```
When the above code is executed, it produces the following result :
blue green orange red

### Read all item on a list

Use foreach : `foreach item {1 2 3 4 5 6 7 8 9} {  puts $item }`


## DICTIONARY

A dictionary used the same formatting as a list - in other words, it's a string of text (just like every other variable type except an array) which is handled through the same tokeniser / interpreter that's used for the source code of Tcl. 
However, in the using of the dict command, list members are taken as alternate **key / value pairs**. In effect, that gives you the capabilities of an array but with the flexibility of handling your data as a pure string too - in the right circumstances, it's the best of both worlds

Some examples for creating a dictionary are shown below :
```tcl
dict set colours  colour1 red 
puts $colours;  # Return  colour1 red
dict set colours  colour2 green
puts $colours;  # Return  colour1 red colour2 green
set colours [dict create colour1 "black" colour2 "white"]
puts $colours;  #  Return  colour1 black colour2 white
``` 

### Size of Dict
The syntax for getting size of dict is shown below :
[dict size dictname]
An example for printing the size is shown below :
```tcl
set colours [dict create colour1 "black" colour2 "white"]
puts [dict size $colours]
```
When the above code is executed, it produces the following result :
2

### Dictionary Iteration
A simple dictionary iteration for printing keys and valued of the dictionary is shown below :
```tcl
set colours [dict create colour1 "black" colour2 "white"]
foreach item [dict keys $colours] {
   set value [dict get $colours $item]
   puts $value
}
```
When the above code is executed, it produces the following result :
black
white

### Value for Key in Dict
The syntax for retrieving value for key in dict is shown below :
[dict get $dictname $keyname]
An example for retrieving value for key is given below :
```tcl
set colours [dict create colour1 "black" colour2 "white"]
set value [dict get $colours colour1]
puts $value
```
When the above code is executed, it produces the following result :
black

### All Keys in Dict
The syntax for retrieving all keys in dict is shown below :
[dict keys $dictname]
An example for printing all keys is shown below :
```tcl
set colours [dict create colour1 "black" colour2 "white"]
set keys [dict keys $colours]
puts $keys
```
When the above code is executed, it produces the following result :
colour1 colour2

### All Values in Dict
The syntax for retrieving all values in dict is shown below :
[dict values $dictname]
An example for printing all values is shown below :
```tcl
set colours [dict create colour1 "black" colour2 "white"]
set values [dict values $colours]
puts $values
```
When the above code is executed, it produces the following result :
black white

### Key Exists in Dict
The syntax for checking if a key exists in dict is shown below :
[dict exists $dictname $key]
An example for checking if a key exists in dict is shown below :
```tcl
set colours [dict create colour1 "black" colour2 "white"]
set result [dict exists $colours colour1]
puts $result
```
When the above code is executed, it produces the following result :
1

### Read/Write Dict in File

```tcl
#--  Read Dictionary from file
set f [open "$FileName" r]
set config [read $f]
close $f
dict for {key value} $config { puts "$key: $value" }
#-- Set/Get  key and value 
dict set config   MyKey  MyValue
puts " [dict get $config MyKey] "
#-- Write dictionary in File 
set f [open $FileName w];
dict for {key value} $config { puts $f "$key   \"$value\"" }
close $f
```

## PROCEDURES

Procedures are nothing but code blocks with series of commands that provide a specific reusable functionality. It is used to avoid same code being repeated in multiple locations. Procedures are equivalent to the functions used in many programming languages and are made available in Tcl with the help of **proc** command.
The syntax of creating a simple procedure is shown below :
proc procedureName {arguments} {
   body
}
A simple example for procedure is given below :
```tcl
proc helloWorld {} {
   puts "Hello, World!"
}
helloWorld
```
When the above code is executed, it produces the following result :
Hello, World!

### Procedures with Multiple Arguments
An example for procedure with arguments is shown below :
```tcl
proc add {a b} {
   return [expr $a+$b]
}
puts [add 10 30]
```
When the above code is executed, it produces the following result :
40

### Procedures with Variable Arguments
An example for procedure with arguments is shown below :
```tcl
proc avg {numbers} {
   set sum 0
   foreach number $numbers {
      set sum  [expr $sum + $number]
   }
   set average [expr $sum/[llength $numbers]]
   return $average
}
puts [avg {70 80 50 60}]
puts [avg {70 80 50 }]
```
When the above code is executed, it produces the following result :
65
66

### Procedures with Default Arguments
Default arguments are used to provide default values that can be used if no value is provided. An example for procedure with default arguments, which is sometimes referred as implicit arguments is shown below :
```tcl
proc add {a {b 100} } {
   return [expr $a+$b]
}
puts [add 10 30]
puts [add 10]
```
When the above code is executed, it produces the following result :
40
110

### Recursive Procedures
An example for recursive procedures is shown below :
```tcl
proc factorial {number} {
   if {$number <= 1} {
      return 1
   } 
   return [expr $number * [factorial [expr $number - 1]]]
}
puts [factorial 3]
puts [factorial 5]
```
When the above code is executed, it produces the following result :
6
120

## PACKAGES

Packages are used for creating reusable units of code. A package consists of a collection of files that provide specific functionality. This collection of files is identified by a package name and can have multiple versions of same files. The package can be a collection of Tcl scripts, binary library, or a combination of both.
Package uses the concept of namespace to avoid collision of variable names and procedure names. Check out more in our next '<a href="/tcl-tk/tcl_namespaces.htm">namespace</a>' tutorial.

### Creating Package
A package can be created with the help of minimum two files. One file contains the package code. Other file contains the index package file for declaring your package.
The list of steps for creating and using package is given below.

### STEP 1 : Creating Code
Create code for package inside a folder say HelloWorld. Let the file be named HelloWorld.tcl with the code as shown below :
/Users/rajkumar/Desktop/helloworld/HelloWorld.tcl 

## Create the namespace
```tcl
namespace eval ::HelloWorld {
  # Export MyProcedure
  namespace export MyProcedure
  # My Variables
   set version 1.0
   set MyDescription "HelloWorld"
  # Variable for the Path of the script
   variable home [file join [pwd] [file dirname [info script]]]
}
```
 
## Definition of the procedure MyProcedure
```tcl
proc ::HelloWorld::MyProcedure {} {
   puts $HelloWorld::MyDescription
}
package provide HelloWorld $HelloWorld::version
package require Tcl 8.0
```

### STEP 2 : Creating Package Index
Open tclsh. Switch to HelloWorld directory and use the pkg_mkIndex command to create the index file as shown below :
```tcl
% cd /Users/rajkumar/Desktop/helloworld 
% pkg_mkIndex . *.tcl
```

### STEP 3 : Adding Directory to AutoPath
Use the lappend command to add the package to the global list as shown below :
`% lappend auto_Path "/Users/rajkumar/Desktop/helloworld"`

### STEP 4 : Adding Package
Next add package to program using package require statement as shown below :
`% package require HelloWorld 1.0`

### STEP 5 : Invoking Procedure
Now, everything being setup, we can invoke our procedure as shown below :
`% puts [HelloWorld::MyProcedure]`
You will get the following result :
HelloWorld

First two steps create the package. Once package is created, you can use it in any Tcl file by adding the last three statements as shown below :
```tcl
lappend auto_Path "/Users/rajkumar/Desktop/helloworld"
package require HelloWorld 1.0
puts [HelloWorld::MyProcedure]
```
You will get the following result :
HelloWorld

## NAMESPACES

Namespace is a container for set of identifiers that is used to group variables and procedures. Namespaces are available from Tcl version 8.0. Before the introduction of the namespaces, there was single global scope. Now with namespaces, we have additional partitions of global scope.

### Creating Namespace
Namespaces are created using the **namespace** command. A simple example for creating namespace is shown below :
```tcl
namespace eval MyMath {
  # Create a variable inside the namespace
  variable myResult
}
```

### Create procedures inside the namespace
```tcl
proc MyMath::Add {a b } {  
  set ::MyMath::myResult [expr $a + $b]
}
MyMath::Add 10 23
puts $::MyMath::myResult
```
When the above code is executed, it produces the following result :
33

In the above program, you can see there is a namespace with a variable **myResult** and a procedure **Add.** This makes it possible to create variables and procedures with the same names under different namespaces.

### Nested Namespaces
Tcl allows nesting of namespaces. A simple example for nesting namespaces is given below :
```tcl
namespace eval MyMath {
   # Create a variable inside the namespace
   variable myResult
}

namespace eval extendedMath {
   # Create a variable inside the namespace
   namespace eval MyMath {
      # Create a variable inside the namespace
      variable myResult
   }
}
set ::MyMath::myResult "test1"
puts $::MyMath::myResult
set ::extendedMath::MyMath::myResult "test2"
puts $::extendedMath::MyMath::myResult
```
When the above code is executed, it produces the following result :
test1
test2

### Importing and Exporting Namespace
You can see in the previous namespace examples, we use a lot of scope resolution operator and it's more complex to use. We can avoid this by importing and exporting namespaces. An example is given below :
```tcl
namespace eval MyMath {
   # Create a variable inside the namespace
   variable myResult
   namespace export Add
}
```

### Forget Namespace
You can remove an imported namespace by using **forget** subcommand. A simple example is shown below :
```tcl
namespace eval MyMath {
   # Create a variable inside the namespace
   variable myResult
   namespace export Add
}
```

## FILE

### Get File Info
/tmp/Myfile.jpg
file dirname <file>		: Returns the name of the directory a file is located within ( return /tmp)
file extention <file>		: Returns extention as .jpg, .exe ...   (return .jpg)
file tail <file>				: Retuns FileName  without Path, with extention  (return Myfile.jpg)
file rootname <file>		: Returns  Filename with Path, without extention (return /tmp/Myfile)
file rootname [file tail <file>] : Returns  Filename without Path, without extention (return Myfile)

Tcl supports file handling with the help of the built in commands open, read, puts, gets, and close.
A file represents a sequence of bytes, does not matter if it is a text file or binary file.

### Opening Files
The syntax for opening a file is as follows : ` open fileName accessMode `
**filename** is string literal to name the file. 
**accessMode** can have one of the following values :
- As a list of any of the following flags 
Exactly one of RDONLY, WRONLY, or RDWR must included in the list.
**RDONLY**	The file is opened for reading only.
**WRONLY**	The file is opened for writing only.
**RDWR**		The file is opened for reading and writing.
**APPEND**	The file pointer is positioned at EOF before each write.
**CREAT**		The file is created if it doesn't already exist.
**EXCL**		Used with CREAT, generates an error if the does already exist (exclusive access).
**NONBLOCK**	Do not block when opening the file; generally only applies to fifos and sockets.
**TRUNC**		If the file exists, truncate it to length zero upon open.

- As a mode :
**r** : Read Only, No Create ( File must exist)  
		(default mode if accessMode is specified )
**r+** : Read/write. No Create (File must exist )
**w** : Write Only.  if it does not exist, new file is created else existing file is truncated
**w+** : Read/Write. It first truncate the file to zero length if it exists otherwise create the file if it does not exist.
**a** : Opens a text file for writing in appending mode. file must exist. Here, your program will start appending content in the existing file content.
**a+** : Opens a text file for reading and writing both. It creates the file if it does not exist. The reading will start from the beginning, but writing can only be appended.


### Closing a File
To close a file, use the close command. The syntax for close is as follows :
close fileName 
Any file that has been opened by a program must be closed when the program finishes using that file. In most cases, the files need not be closed explicitly; they are closed automatically when File objects are terminated automatically.

### Writing a File
Puts command is used to write to an open file.
puts $filename "text to write"
A simple example for writing to a file is shown below.
```tcl
set fp [open "input.txt" w+]
puts $fp "test"
close $fp
```
When the above code is compiled and executed, it creates a new file **input.txt** in the directory that it has been started under (in the program's working directory).

### Reading a File
Following is the simple command to read from a file :
`set file_data [read $fp]`
A complete example of read and write is shown below :
```tcl
set fp [open "input.txt" w+]
puts $fp "test"
close $fp
set fp [open "input.txt" r]
set file_data [read $fp]
puts $file_data
close $fp
```
When the above code is compiled and executed, it reads the file created in previous section and produces the following result :
test
Here is another example for reading file till end of file line by line :
```tcl
set fp [open "input.txt" w+]
puts $fp "test\ntest"
close $fp
set fp [open "input.txt" r]
while { [gets $fp data] >= 0 } {
   puts $data
}
close $fp
```
When the above code is compiled and executed, it reads the file created in previous section and produces the following result :
test
test

###  Get Relative Path

__Method 1__
set RelativePath "[ exec  realPath --relative-to [file normalize $SourceFileName]  $File]
__Method 2__
set InitDir [file normalize [file dirname $SourceFileName ]]
set RelativePath "[regsub "$InitDir/" $File {} ]"



###  Compress/Uncompress Files

- with tcl v8.7+ : 
	https://www.magicsplat.com/blog/tcl87-zipfs2/index.html

- with tcl V8.6:
```tcl
package require zipfile::mkzip;	# Zip; Require package tcllib
package require zipfile::decode;	# Unzip;Require package tcllib
#---  ZIP files in folder "config" to file test.zip
zipfile::mkzip::mkzip test.zip -directory config
#---  UNZIP file test.zip to folder config
::zipfile::decode::open test.zip
set archiveDict [::zipfile::decode::archive]
::zipfile::decode::unzip $archiveDict config
::zipfile::decode::close
```

## ERROR HANDLING

Error handling in Tcl is provided with the help of **error** and **catch** commands. The syntax for each of these commands is shown below.

### Error syntax
**error message info code**
In the above error command syntax, message is the error message, info is set in the global variable errorInfo and code is set in the global variable errorCode.

### Catch Syntax
**catch script resultVarName**
In the above catch command syntax, script is the code to be executed, resultVarName is variable that holds the error or the result. The catch command returns 0 if there is no error, and 1 if there is an error.
An example for simple error handling is shown below :
```tcl
proc Div {a b} {
   if {$b == 0} {
      error "Error generated by error" "Info String for error" 401
   } else { return [expr $a/$b] }
}
if {[catch {puts "Result = [Div 10 0]"} errmsg]} {
   puts "ErrorMsg: $errmsg  ErrorCode: $errorCode   ErrorInfo:\n$errorInfo\n"
}
if {[catch {puts "Result = [Div 10 2]"} errmsg]} {
   puts "ErrorMsg: $errmsg   ErrorCode: $errorCode   ErrorInfo:\n$errorInfo\n"
}
```

When the above code is executed, it produces the following result :
ErrorMsg: Error generated by error    ErrorCode: 401   ErrorInfo:
Info String for error
   (procedure "Div" line 1)
   invoked from within
"Div 10 0"

Result = 5

You can create our own custom error messages.  An example is shown below :
```
catch {set file [open myNonexistingfile.txt]} result
puts "ErrorMsg: $result    ErrorCode: $errorCode   ErrorInfo:\n$errorInfo\n"
```
When the above code is executed, it produces the following result :
ErrorMsg: couldn't open "myNonexistingfile.txt": no such file or directory
ErrorCode: POSIX ENOENT {no such file or directory}
ErrorInfo:
couldn't open "myNonexistingfile.txt": no such file or directory
while executing
"open myNonexistingfile.txt"

## BUILT-IN FUNCTIONS

Tcl provides a number of built-in functions (procedures) for various operations. This includes :
- Functions for <a href="/tcl-tk/tcl_lists.htm">list</a> handling.
- Functions for <a href="/tcl-tk/tcl_strings.htm">string</a> handling.
- Functions for <a href="/tcl-tk/tcl_arrays.htm">array</a> handling.
- Functions for <a href="/tcl-tk/tcl_dictionary.htm">dictionary</a> handling.
- Functions for <a href="/tcl-tk/tcl_file_io.htm">File I/O</a> handling.
- Functions for creating <a href="/tcl-tk/tcl_namespaces.htm">namespaces</a> and <a href="/tcl-tk/tcl_packages.htm">packages.</a>
- Functions for Math operations.
- Functions for System operations.

Each of the above except for math and system functions are covered in earlier chapters. Math and system built-in functions are explained below.

### Math Functions
The math functions available in Tcl are listed in the following table :
**abs** arg		Calculates the absolute value of arg.
**acos** arg		Calculates the arccosine of arg.
**asin** arg		Calculates the arcsine of arg.
**atan** arg		Calculates the arctangent of arg.
**atan2** y x		Calculates the arctangent of the quotient of its arguments(y/x).
**ceil** arg		Calculates the smallest integer greater than or equal to a number.
**cos** arg		Calculates the cosine of arg.
**cosh** arg		Calculates the hyperbolic cosine of arg.
**double** arg		Calculates if arg is a floating-point value, returns arg, otherwise converts arg to floating-point and returns the converted value.
**exp** arg		Calculates an exponential function (e raised to the power of arg).
**floor** arg		Calculates the largest integer less than or equal to arg.
**fmod** x y		Calculates the floating-point remainder of the division of x by y. If y is 0, an error is returned.
**hypot** x y		Calculates the length of the hypotenuse of a right-angled triangle sqrt(x*x+y*y).
**int** arg		Calculates if arg is an integer value of the same width as the machine word, returns arg, otherwise converts arg to an integer.
**log** arg		Calculates the natural logarithm of arg.
**log10** arg		Calculates the base 10 logarithm of arg.
**pow** x y		Calculates the value of x raised to the power y. If x is negative, y must be an integer value.
**rand**		Calculates a pseudo-random number between 0 and 1.
**round** arg		Calculates the value of arg rounded to the nearest integer.
**sin** arg		Calculates the sine of arg.
**sinh** arg		Calculates the hyperbolic sine of arg.
**sqrt** arg		Calculates the square root of arg. arg must be positive.
**srand** arg		Calculates a pseudo-random number between 0 and 1. 
				arg must be an integer, is used to reset the seed for the random number generator of rand.
**tan** arg		Calculates the tangent of arg.
**tanh** arg		Calculates the hyperbolic tangent of arg.
**wide** arg		Calculates integer value at least 64-bits wide (by sign-extension if arg is a 32-bit number) for arg if it is not one already.

Some examples using math functions are given below :
```tcl
namespace import ::tcl::mathfunc::*
puts [tan 10]
puts [pow 10 2]
puts [ceil 10.34]
puts [hypot 10 20]
puts [srand 45]
puts [log 10]
puts [srand 45]
```

When the above code is executed, it produces the following result :
0.6483608274590866
100.0
11.0
22.360679774997898
0.0003521866166741525
2.302585092994046
0.0003521866166741525

### System Functions
The important system functions in Tcl includes,
- **clock** : seconds function, which returns current time in seconds.
- **clock** : format function, which formats the seconds into date and time.
- **clock** : scan function, which scans the input string and converts it into seconds.
- **open** : function, which is used to open a file.
- **exec** : function, which is used to execute a system command.
- **close** : function, which is used to close a file.

Some examples for the above functions are listed below :
 get seconds
set currentTime [clock seconds]
puts $currentTime

### clock format

```tcl
puts "The time is: [clock format $currentTime -format %H:%M:%S]"
puts "The date is: [clock format $currentTime -format %D]"
set date "Jun 15, 2014"
puts [clock scan $date -format {%b %d, %Y}]
puts [exec ls]
puts [exec dir]
set a  [open input.txt]
puts [read $a];
puts $a
close $a
```

When the above code is executed, it produces the following result :
1402819756
The time is: 03:09:16
The date is: 06/15/2014
1402808400
input.txt
main.tcl
input.txt  main.tcl

The following table provides the lstrings that can be used to format the date/time.
%a	Day in short form, eg:Sun.
%A	Day in full form eg:Sunday.
%b	Month in short form.
%B	Month in full form.
%d	Day of month.
%j		Julian day of year.
%m	Month in number.
%y	Year in two digits.
%Y	Year in four digits.
%H	Hour in 24 hour clock.
%I		Hour in 12 hour clock.
%M	Minutes.
%S	Seconds.
%p	AM or PM.
%D	Date in number, mm /dd/yy.
%r	Time in 12 hour clock.
%R 	Time in 24 hour clock without seconds.
%T	Time in 24 hour clock with seconds.
%Z	Time Zone Name like GMT, IST, EST and so on.

## REGULAR EXPRESSION

The "regexp" command is used to match a regular expression in Tcl. A regular expression is a sequence of characters that contains a search pattern. It consists of multiple rules and the following table explains these rules and corresponding use.
x**	Exact match.
[a-z]**	Any lowercase letter from a-z.
.**	Any character.
^**	Beginning string should match.
$**	Ending string should match.
\^**	Backlash sequence to match special character ^.Similarly you can use for other characters.
()**	Add the above sequences inside parenthesis to make a regular expression.
x***	Should match 0 or more occurrences of the preceding x.
x+**	Should match 1 or more occurrences of the preceding x.
[a-z]?**	Should match 0 or 1 occurrence of the preceding x.
{digit}**	Matches exactly digit occurrences of previous regex expression. Digit that contains 0-9.
{digit,}**	Matches 3 or more digit occurrences of previous regex expression. Digit that contains 0-9.
{digit1,digit2}**	Occurrences matches the range between digit1 and digit2 occurrences of previous regex expression.
 Syntax
The syntax for regex is given below :

regexp optionalSwitches patterns searchString fullMatch subMatch1 ... subMatchn

Here, regex is the command. We will see about optional switches later. Patterns are the rules as mentioned earlier. Search string is the actual string on which the regex is performed. Full match is any variable to hold the result of matched regex result. Submatch1 to SubMatchn are optional subMatch variable that holds the result of sub match patterns.
Let's look at some simple examples before diving into complex ones. A simple example for a string with any alphabets. When any other character is encountered the regex, search will be stopped and returned.

regexp {([A-Z,a-z]*)} "Tcl Tutorial" a b 
puts "Full Match: $a"
puts "Sub Match1: $b"

When the above code is executed, it produces the following result :
Full Match: Tcl
Sub Match1: Tcl

### Multiple Patterns
The following example shows how to search for multiple patterns. This is example pattern for any alphabets followed by any character followed by any alphabets.
```tcl
regexp {([A-Z,a-z]*).([A-Z,a-z]*)} "Tcl Tutorial" a b c  
puts "Full Match: $a"
puts "Sub Match1: $b"
puts "Sub Match2: $c"
```
When the above code is executed, it produces the following result :
Full Match: Tcl Tutorial
Sub Match1: Tcl
Sub Match2: Tutorial

A modified version of the above code to show that a sub pattern can contain multiple patterns is shown below :
```tcl
regexp {([A-Z,a-z]*.([A-Z,a-z]*))} "Tcl Tutorial" a b c  
puts "Full Match: $a"
puts "Sub Match1: $b"
puts "Sub Match2: $c"
```
When the above code is executed, it produces the following result :
Full Match: Tcl Tutorial
Sub Match1: Tcl Tutorial
Sub Match2: Tutorial

### Switches for Regex Command
The list of switches available in Tcl are,
- **nocase** : Used to ignore case.
- **indices** : Store location of matched sub patterns instead of matched characters.
- **line** : New line sensitive matching. Ignores the characters after newline.
- **start index** : Sets the offset of start of search pattern.
- Marks the end of switches

In the above examples, I have deliberately used [A-Z, a-z] for all alphabets, you can easily use -nocase instead of as shown below :
```tcl
regexp -nocase {([A-Z]*.([A-Z]*))} "Tcl Tutorial" a b c  
puts "Full Match: $a"
puts "Sub Match1: $b"
puts "Sub Match2: $c"
```
When the above code is executed, it produces the following result :
Full Match: Tcl Tutorial
Sub Match1: Tcl Tutorial
Sub Match2: Tutorial

Another example using switches is shown below :
```tcl
regexp -nocase -line -- {([A-Z]*.([A-Z]*))} "Tcl \nTutorial" a b 
puts "Full Match: $a"
puts "Sub Match1: $b"
regexp -nocase -start 4 -line -- {([A-Z]*.([A-Z]*))} "Tcl \nTutorial" a b  
puts "Full Match: $a"
puts "Sub Match1: $b"
```
When the above code is executed, it produces the following result :
Full Match: Tcl 
Sub Match1: Tcl 
Full Match: Tutorial
Sub Match1: Tutorial

### Whole Word Only
To detect a whole word only (and not words containing the expression) , Use {\yEXPRESSION\y}
Example: \yca\y match ca in 'black ca', but NO match in cato,toca,cicate

## CLIPBOARD
Clear and add $var to clipboard :  `clipboard clear; clipboard append $var`

## WIDGETS OVERVIEW

The basic component of a Tk-based application is called a widget. A component is also sometimes called a window, since, in Tk, "window" and "widget" are often used interchangeably. Tk is a package that provides a rich set of graphical components for creating graphical applications with Tcl.
Tk provides a range of widgets ranging from basic GUI widgets like buttons and menus to data display widgets. The widgets are very configurable as they have default configurations making them easy to use.
Tk applications follow a widget hierarchy where any number of widgets may be placed within another widget, and those widgets within another widget. The main widget in a Tk program is referred to as the root widget and can be created by making a new instance of the TkRoot class.

### Creating a Widget
The syntax for creating a widget is given below.

type variableName arguments options

The type here refers to the widget type like button, label, and so on. Arguments can be optional and required based on individual syntax of each widget. The options range from size to formatting of each component.

### Widget Naming Convention
Widget uses a structure similar to naming packages. In Tk, the root window is named with a period (.) and an element in window, for example button is named .myButton1. The variable name should start with a lowercase letter, digit, or punctuation mark (except a period). After the first character, other characters may be uppercase or lowercase letters, numbers, or punctuation marks (except periods). It is recommended to use a lowercase letter to start the label.

### Color Naming Convention
The colors can be declared using name like red, green, and so on. It can also use hexadecimal representing with #. The number of hexadecimal digits can be 3, 6, 9, or 12.

### Dimension Convention
The default unit is pixels and it is used when we specify no dimension. The other dimensions are i for inches, m for millimeters, c for centimeters and p for points.

### Common Options
There are so many common options available to all widgets and they are listed below in the following table :
* background color
Used to set background color for widget.
* borderwidth width
Used to draw with border in 3D effects.
* font fontDescriptor
Used to set font for widget.
* foreground color
Used to set foreground color for widget.
* height number
Used to set height for widget.
* highlightbackground color
Used to set the color rectangle to draw around a widget when the widget does not have input focus.
* highlightcolor color
Used to set the color rectangle to draw around a widget when the widget has input focus.
* padx number
Sets the padx for the widget.
* pady number
Sets the pady for the widget.
* relief condition
Sets the 3D relief for this widget. The condition may be raised, sunken, flat, ridge, solid, or groove.
* text text
Sets the text for the widget.
* textvariable varName
Variable associated with the widget. When the text of widget changes, the variable is set with text of widget.
* width number
Sets the width for widget.

A simple example for options is shown below.

```
grid [label .myLabel -background red -text "Hello World" -relief ridge -borderwidth 3]
   -padx 100 -pady 100
```

The list of available widgets are categorized below :

## BASIC WIDGETS
Label		: Widget for displaying single line of text.
Button		: Widget that is clickable and triggers an action.
Entry		: Widget used to accept a single line of text as input.
Message	: Widget for displaying multiple lines of text.
Text			: Widget for displaying and optionally edit multiple lines of text.
Toplevel	: Window with all borders and decorations provided by the Window manager.
A simple Tk example is shown below using basic widgets :
```tcl
grid [label .myLabel -text "Label Widget" -textvariable labelText] 
grid [text .myText -width 20 -height 5]
.myText insert 1.0 "Text\nWidget\n"
grid [entry .myEntry -text "Entry Widget"]
grid [message .myMessage -background red -foreground white -text "Message\nWidget"]
grid [button .myButton1  -text "Button" -command "set labelText clicked"]

```

## LAYOUT WIDGETS
Layout widgets are used to handle layouts for the Tk application. Frame widget is used group other widgets and place, pack, and grid are layout manager to give you total control over your adding to windows. The list of available layout widgets are as shown below :
- **Frame** : Container widget to hold other widgets.
- **Place** : Widget to hold other widgets in specific place with coordinates of its origin and an exact size.
- **Pack** : Simple widget to organize widgets in blocks before placing them in the parent widget.
- **Grid** : Widget to nest widgets packing in different directions.

A simple Tk example is shown below for layout widgets :
```tcl
frame .frame1 -borderwidth 2 -padx 5 -pady 5 -height 100 -width 100
frame .frame2 -background blue -padx 5 -pady 5 -height 100 -width 50
pack .myFrame1 
pack .myFrame2
```

## SELECTION WIDGETS
Selection widgets are used to select different options in a Tk application. The list of available selection widgets are as shown below.
- **Radiobutton** : Widget that has a set of on/off buttons and labels, one of which may be selected.
- **Checkbutton** : Widget that has a set of on/off buttons and labels, many of which may be selected.
- **Menu** : Widget that acts as holder for menu items.
- **Listbox** : Widget that displays a list of cells, one or more of which may be selected.

A simple Tk example is shown below using selection widgets :
```tcl
grid [frame .gender ]
grid [label .label1  -text "Male" -textvariable myLabel1 ] 
grid [radiobutton .gender.maleBtn -text "Male"   -variable gender -value "Male"
   -command "set  myLabel1 Male"] -row 1 -column 2
grid [radiobutton .gender.femaleBtn -text "Female" -variable gender -value "Female"
   -command "set  myLabel1 Female"] -row 1 -column 3
.gender.maleBtn select
grid [label .myLabel2  -text "Range 1 not selected" -textvariable myLabelValue2 ] 
grid [checkbutton .chk1 -text "Range 1" -variable occupied1 -command {if {$occupied1 } {
   set myLabelValue2 {Range 1 selected}
} else {
   set myLabelValue2 {Range 1 not selected}
} }]
proc setLabel {text} { .label configure -text $text }
```

## CANVAS WIDGETS

Canvas is used for providing drawing areas. The syntax for canvas widget is shown below :
canvas canvasName options

### Options
The options available for the canvas widget are listed below in the following table :
- background color  : Used to set background color for widget.
- closeenough distance : Sets the closeness of mouse cursor to a displayable item. The default is 1.0 pixel. This value may be a fraction and must be positive.
- scrollregion boundingBox : The bounding box for the total area of this canvas.
- height number : Used to set height for widget.
- width number : Sets the width for widget.
- xscrollincrement size : The amount to scroll horizontally  when scrolling is requested.
- yscrollincrement size : The amount to scroll vertically when scrolling is requested.

A simple example for canvas widget is shown below :
```tcl
canvas .myCanvas -background red -width 100 -height 100 
pack .myCanvas
```

### Widgets for Drawing in Canvas
The list of the available widgets for drawing in canvas is listed below :
	- Line : Draws a line.
	- Arc : Draws an arc.
	- Rectangle : Draws a rectangle.
	- Oval : Draws an oval.
	- Polygon : Draws a polygon.
	- Text : Draws a text.	
	- Bitmap  : Draws a bitmap.
	- Image : Draws an image.

An example using different canvas widgets is shown below :
```tcl
canvas .myCanvas -background red -width 200 -height 200 
pack .myCanvas
.myCanvas create arc 10 10 50 50 -fill yellow
.myCanvas create line 10 30 50 50 100 10 -arrow both -fill yellow -smooth true
   -splinesteps 2
.myCanvas create oval 50 50 100 80 -fill yellow
.myCanvas create polygon 50 150 100 80 120 120 100 190 -fill yellow -outline green
.myCanvas create rectangle 150 150 170 170  -fill yellow
.myCanvas create text 170 20 -fill yellow -text "Hello" -font {Helvetica -18 bold}
.myCanvas create bitmap 180 50 -bitmap info
```


## MEGA WIDGETS
Mega widgets include many complex widgets which is often required in some large scale Tk applications. The list of available mega widgets are as shown below :
- **Dialog** : Widget for displaying dialog boxes.
- **spinbox** : Widget that allows users to choose numbers.
- **Combobox** : Widget that combines an entry with a list of choices available to the use.
- **Notebook** : Tabbed widget that helps to switch between one of several pages, using an index tab.
- **Progressbar** : Widget to provide visual feedback to the  progress of a long operation like file upload.
- **Treeview** : Widget to display and allow browsing through a hierarchy of items more in form of tree.
- **Scrollbar** : Scrolling widgets without a text or canvas widgets.
- **Scale** : Scale widget to choose a numeric value through sliders.

A simple Tk example is shown below using some mega widgets.
```tcl
ttk::treeview .tree -columns "Creator Year" -displaycolumns "Year Creator" 
.tree heading Creator -text "Creator" -anchor center
.tree heading Year -text "Year" -anchor center
pack .tree
.tree insert {} end -id Languages -text "Languages"
.tree insert Languages end -text C -values [list "Dennis Ritchie" "1990"]
proc scaleMe {mywidget scaleValue} {
	$mywidget configure -length $scaleValue
} 
pack [scale .s2  -from 100.0 -to 200.0 -length 100 -background yellow -borderwidth 5
   -font{Helvetica -18 bold} -foreground red -width 40 -relief ridge -orien horizontal
   -variable a -command "scaleMe .s2" ]
pack [ttk::progressbar .p1 -orient horizontal -length 200 -mode indeterminate -value 90]ttk::treeview .tree -columns "Creator Year" -displaycolumns "Year Creator" 
.tree heading Creator -text "Creator" -anchor center
.tree heading Year -text "Year" -anchor center
pack .tree
.tree insert {} end -id Languages -text "Languages"
.tree insert Languages end -text C -values [list "Dennis Ritchie" "1990"]
proc scaleMe {mywidget scaleValue} {
	$mywidget configure -length $scaleValue
} 
pack [scale .s2  -from 100.0 -to 200.0 -length 100 -background yellow -borderwidth 5
   -font{Helvetica -18 bold} -foreground red -width 40 -relief ridge -orien horizontal
   -variable a -command "scaleMe .s2" ]
pack [ttk::progressbar .p1 -orient horizontal -length 200 -mode indeterminate -value 90]
pack [ttk::progressbar .p2 -orient horizontal -length 200 -mode determinate -variable a
   -maximum 75 -value 20]
pack [ttk::progressbar .p2 -orient horizontal -length 200 -mode determinate -variable a
   -maximum 75 -value 20]
```


## FONTS

There are a number of widgets that supports displaying text. Most of these provides the option of font attribute. The syntax for creating a font is shown below :
`font create fontName options`

### Options Font Create
The options available for the font create are listed below in the following table :
**-family familyName**				The name of font family.
**-size number**						The size of font.
**-weight level**					The weight for font.

A simple example for a font creation is shown below :
```tcl
font create myFont -family Helvetica -size 18 -weight bold 
pack [label .myLabel -font myFont -text "Hello World"]
```

To get all the fonts available, we can use the following command :
`puts [font families]`
When we run the above command, we will get the following output :
{Andale Mono} Arial {Arial Black}

## IMAGES

To manipulate jpg,ico... format, you need to add **package require Img** at init
The image widget is used to create and manipulate images. The syntax for creating image is as follows :
**image create type name options**
In the above syntax type is photo or bitmap and name is the image identifier.

### Image create Options

The options available for image create are listed below in the following table :
**-file fileName**			The name of the image file name.
**-height number**			Used to set height for widget.
**-width number**			Sets the width for widget.
**-data string**			Image in base 64 encoded string.

A simple example for image widget is shown below :
```tcl
image create photo imgobj -file "/Users/Forests/680049.png" -width 400 -height 400
pack [label .myLabel]
.myLabel configure -image imgobj
```

The available function for image are listed below in the following table :
- **image delete imageName**			Deletes the image from memory and related widgets visually.
- **image height imageName**			Returns the height for image.
- **image width imageName**			Returns the width for image.
- **image type imageName**			Returns the type for image.
- **image names**			Returns the list of images live in memory.

A simple example for using the above image widget commands is shown below :
```tcl
image create photo imgobj -file "/Users/rajkumar/images/680049.png"  -width 400 -height 400 
pack [label .myLabel]
.myLabel configure -image imgobj
puts [image height imgobj]
puts [image width imgobj]
puts [image type imgobj]
puts [image names]
image delete imgobj
```
The image will be deleted visually and from memory once "image delete imgobj" command executes. In console, the output will be like the following :
400
400
photo
imgobj ::tk::icons::information ::tk::icons::error ::tk::icons::
warning ::tk::icons::question

**Built-in Image** :   ::tk::icons::information     ::tk::icons::error     ::tk::icons::warning    ::tk::icons::question


## EVENTS

Events in its simplest form is handled with the help of commands. A simple example for event handling is event handling with button and is shown below :
$!/usr/bin/wish
proc myEvent { } {
   puts "Event triggered"
}
pack [button .myButton1  -text "Button 1"   -command myEvent]
A simple program to show delay text animation event is shown below :
```tcl
proc delay {} {
   for {set j 0} {$j < 100000} {incr j} {} 
}
label .myLabel -text "Hello................" -width 25
pack .myLabel
set str "Hello................"
for {set i [string length $str]} {$i > -2} {set i [expr $i-1]} {
   .myLabel configure -text [string range $str 0 $i]
   update
   delay
}
```

### Event after delay
The syntax for event after delay is shown below :
**after milliseconds number command**
A simple program to show after delay event is shown below :
```tcl
proc addText {} {
		label .myLabel -text "Hello..." -width 25
		pack .myLabel
}
after 1000 addText
```
You can cancel an event using the after cancel command as shown below :
```tcl
proc addText {} {
   label .myLabel -text "Hello..." -width 25
   pack .myLabel
}
after 1000 addText
after cancel addText

```
### Event Binding
The syntax for event binding is as shown below :
**bind arguments **

### Keyboard Events Example

`bind .  {puts "Key Pressed: %K "}`
When we run the program and press a letter X, we will get the following output :
Key Pressed: X 

### Mouse Events Example

`bind .  {puts "Button %b Pressed : %x %y "}`
When we run the program and press the left mouse button, we will get an output similar to the following :
Button 1 Pressed : 89 90 

### Linking Events with Button Example

```tcl
proc myEvent { } {
   puts "Event triggered"
}
pack [button .myButton1  -text "Button 1"   -command myEvent]
bind .  ".myButton1 invoke"
```

When we run the program and press enter, we will get the following output :
Event triggered

## WINDOW MANAGER

Window manager is used to handle the top level window. It helps in controlling the size, position, and other attributes of the window. In Tk, . is used to refer the main window. The syntax for window command is shown below :

wm option window arguments

The list of options available for Tk wm command is shown in the following table :
**aspect windowName a b c d**   Tries to maintain the ratio of width/height to be between a/b and c/d.
**geometry windowName geometryParams**   Use to set geometry for window.
**grid windowName w h dx dy**			Sets the grid size.
**deiconify windowName**		Brings the screen to normal if minimized.
**iconify windowName**			Minimizes the window.
**state windowName**		Returns the current state of window.
**withdraw windowName**		Unmaps the window and removes its details in memory.
**iconbitmap windowName image**		Sets or returns the icon bitmap.
**iconPhoto windowName image**		Sets or returns the icon photo.
**command windowName commandString**		Records the startup command in the WM_COMMAND property.
**protocol windowName arguments**	Register a command to handle the protocol request name, which can be WM_DELETE_WINDOW,
WM_SAVE_YOURSELF,
WM_TAKE_FOCUS. Eg: wm protocol.
WM_DELETE_WINDOW Quit.
**minsize windowName size**		Determines the minimum window size.
**maxsize windowName size**		Determines the maximum window size.
**title windowName titleText**		Determines the title for window.
**attributes subOptions**		There are lots of attributes available like alpha, full screen and so on.
Some of the above commands are used in the following example :
```tcl
$!/usr/bin/wish
wm maxsize . 800 800
wm minsize . 300 300
wm title . "Hello"
wm attributes . -alpha ".90" 
wm geometry . 300x200+100+100
```
When we run the above program, we will get the following output :
<img src="/tcl-tk/images/windowManager.png" alt="Window Manager" />
As you can see alpha is one of the attributes available. The list of commonly used subcommands are listed below :
**-alpha number**		Sets the alpha for window.
**-fullscreen number**	Number can be 0 for normal screen or 1 for full screen.
**-topmost number**	Sets or returns whether window is topmost.Value can be 0 or 1.

### Creating Window
We can use toplevel command to create window and an example is shown below :
$!/usr/bin/wish
toplevel .t
When we run the above program, we will get the following output :
<img src="/tcl-tk/images/windowManager2.png" alt="Window Manager2" />

### Destroying Window
We can use destroy command to destroy window and an example is shown below :
$!/usr/bin/wish
destroy .t
The above command will destroy window named **.t**.

## GEOMETRY MANAGER
The geometry manager is used to manage the geometry of the window and other frames. We can use it to handle the position and size of the window and frames. 

### Positioning and sizing
The syntax for positioning and sizing window is shown below :
wm geometry . wxh+/-x+/-y
Here, w refers to width and h refers to height. It is followed by a '+' or '-' sign with number next referring to the x position on screen. Similarly the following '+' or '-' sign with number refers to the y position on screen
A simple example is shown below for the above Statement :.
```tcl
$!/usr/bin/wish
wm geometry . 300x200+100+100
```

### Grid Geometry
The syntax for grid geometry is shown below :
`grid gridName -column number -row number -columnspan number -rowspan number`
The column, row, columnspan, or rowspan helps in providing the grid geometry.
A simple example is shown below for the above statement :
```tcl
$!/usr/bin/wish
frame .myFrame1 -background red  -height 100 -width 100
frame .myFrame2 -background blue -height 100 -width 50
grid .myFrame1 -columnspan 10 -rowspan 10 -sticky w
grid .myFrame2 -column 10 -row 2
```

