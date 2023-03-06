 

# Test FORMATTING  


## Test Header2
qsdqd

### Test Header3
qsdqd

#### Test Header4
qsdqd

##### Test Header5
qsdqd

###### Test Header6
khkjhkjhkh

###### TEST HEADER6
khkjhkjhkh

#NO Header
#_NO Header

######       Header with lot of space before/after


## Test Emphasis

Warning 1:  Pandoc format ` **bold ** ` as bold  ( for lowdown converter , not bold )
Warning 2:  with pandoc/lowdown, emphasis are done even if there is a new line :
The following syntax will be bold :
**bold
now**

Single Char:   **B**     _I_    __U__  <mark>H</mark>      ~~S~~     ++A++     <sup>E</sup>
Double Char :    **BB**      _II_       __UU__       <mark>HH</mark>        ~~SS~~       ++AA++      <sup>EE</sup>
Triple Char :    **BBB**      _III_       __UUU__       <mark>HHH</mark>        ~~SSS~~       ++AAA++      <sup>EEE</sup>

**A sentence with bold**
**bold**	 ** NObold **      *\*NObold*\*         **bold**        **NObold **

_italic_	  _ NOTitalic _    _ NOitalic_	 _italic_	    _NOitalic\_        _italic_
_A sentence with italic_     and  not in italic : last_word 

***BoldItalic***   *** NoBoldItalic ***    *\*\*NoBoldItalic*\*\*    ***BoldItalics*** ***NoBoldItalics ***
***A Sentence in bold italic***

__underline__  __ NOunderline __     __ NOunderline__   __underline__     __NOunderline\_\_ 
__A sentence in underline__

___BoldUnderline___        ___ NoBoldUnderline ___
___A Sentence in Bold Underline___

<mark>Highlight</mark>
<mark>A sentence in highlight</mark>

~~strike~~      ~~ NOStrike ~~      ~~ NOstrike~~       ~~strike~~      ~\~NOStrike~~     ~~strike~~
~~A sentence in strike~~

++BigFont++    ++ Nobig ++  ++ NoBig++    ++Big++   +\+Nobig ++     ++Big++
++A sentence in big font++

<sup>superscript with sup</sup>        <sup> sup </sup>       <sup> sup</sup>      <sup>sup</sup>
<sup>A sentence in supscript</sup>

##  Test Italics
This is composed_word that should **NO** be parsed in italics
qsdqsd _ NO italic _
_NOitalic _ foo
* In italic with `_` :  
_i_ foo _ii_ bar _iii_ foobar _iiii_
* In Italic with `*` : 
*i* qsdqs *ii* qsdqsd *iii* qsdqsd *iiii*
foo _italic  now_ foo
foo *italic  now* foo
**NOitalic\*\* 
*NOitalic\* qhgfs dqsd
NOitalic*qsdqsd qsdqsd*qsdqsd
_NOitalic\_ qhgfsd qd
__NOitalic\_\_
qsdqsd `_NOitalic_` qhsgdhqds
qsdqsd `*NOitalic*` qhsgdhqds


##  Test Foonote
Here is a footnote reference[^1] and another[^long]

[^1]: Here is the footnote.
[^long]: Here's a long one

## Test Code

Code Inline with only 1/2/3 letters : `a`  and `bb` and `ccc`
NO parsing inside   ` Code inline | echo **qsd** | ls _sd_ ` for paragraph
NO code inline with escaped backtick  :   \`NO Code Inline\`

- Code inline in a list/no parsing  ` Code **Inline** now`
- List line2

```
#  No Highlight / No markdown inside
set var 2;| set | **varf** "sgds";  __another__ $var
```

``` tcl
	# CodeBlock with a tab and highlight language=tcl
	set var 2;
```

NO CodeBlock with 3 backtick inline  ```sdsfd ```

   ```tcl
	# NO CodeBlock with spaces before the 3 backticks
	set var 2;
   ```


|  Code in table               |     Header2      |
|------------------------------|-----------------:|
| ` Code **inline** now `      | Center align


## Test BlockQuote

> A blockQuote. Begin each line with '> ' or '>> '
> This line is **part** of the __same__ quote. This is another blockquote with a very long line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone
>
>> BlockQuote2 is indented also : This is a very **long** line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone

 > Always a  BlockQuote1 if a space before
 >
 >> Always a BlockQuote2 if a space before

## Test Definition List

Definition Term1
: This is a defininion1 with **one space**
And Another Line

Definition Term2
:   This is another definition with **3 spaces**. ohboy let's keep writing to make sure this is long enough to actually wrap for everyone

Definition Term3
:	This is another definition with **one tab**. ohboy let's keep writing to make sure this is long enough to actually wrap for everyone

Test No Definition List1
:NOT a definition list if no spaces after ":"

Test No Definition List2
\: NOT a definition list if ":" is escaped

## Test Formatting with newline

OK ?

## Paragraph Justification

|	Paraph **Indent1** __jqhgjsdhgqjd__ qsjgdh qfsdhgqhd hqgfsdhgqhd hqgfsdgq hqgdhgq hqgfsdhgfqhdg hqsdhgqfd
	1TAB LINE  jqhgjdhgjqgd hgqshdfg

|		Paraph **Indent2** __qjhsgdjhqd__ jqsd qhgfsdhgfqd hqfsdhgfqd hqgdshg hgfqs qhsfgdqd hqgfsdgfqhd hqfsdhgfqd
		2TAB LINE qghdhqgdhgfqd hqsdfgqdf

|			Paraph **Indent3** qjhsd jqgdfqd hqgfsdh qhgfsdhgqfhgdf qhfsdhgqfd qhgfsdhgq hqgfsdhgq hqsfdhgqhdfqhdfhqd
			3TAB LINE

## Line Justification

:::	center 1TAB
:::		center 2TAB
:::NO Center if no space
::: center 1 SPACE
:::     center multi-spaces
:\:: NO center if escape characters

::::	right 1TAB
::::		right 2TAB
::::NORight 0 Space
:::: right 1 Space
::::     right multi-spaces
:\::: NO Right if escape characters

::: **Bold**  and Center Text
::: 	 Another __Center__ Text with Spaces/TABs
::::	__Underline__  Right Text
::::		**Bold** Right Text


## Text Fully-justify

The text is not fully-justify inside xwriter but  fully-justify when exporting document. 
HTML CSS class must contain 'white-space: normal'

:: qfd qhgfsdq hfgqshgdq hqfgsdh hqfsdhg qhfsgdqd hgfqsd hqgfshdgqd hqsfdhgfqd hg qhsfdhgq qhfsdhfqhdf qhsfdh qhgfdshqd hqfsdhqd hqfsdhg hfqhs hgqfshdgfhqd qgsdhg qhsfdhfqd hqf hqgfsdhgfq hqfsd qhgfsd hqsfdhgfqd hqfsdhfq qhsdfhqd hqfsd hqsfdhgfq hfqhsfd hqfgsd qhgfsd hgfhq hf hqgfsd hqfshdf qsjdg qsdfh hqgfsdhgfq qsfd hqsfd qhgfsdhgqd hfqs jqsdjqgjd jqhg hqsfdh qhsfdhfq hqgfs qhsfdhfqd

## Test  Comment

 <!--  This is a Comment  -->

##  Test  Special Tabulation

this is	1 tab and		2 tabs
	An initial tab
		2 initial tabs
A space+tab 	now and 	 	2 special Tabs now


##  Test Pandoc Attribute
ONLY IF PANDOC IS INSTALLED

NO [pandoc]{attribute} if not ` {.xxx} or {#xxx} `
This is a [pandoc attribute with .]{.attribute}  and [anotherOne]{.attribute}
This is a [pandoc attribute with #]{#attribute}
::: {attribute} and NO center line
::: {.attribute}  pandoc attribute with .  and NO center line
::: {#attribute}  pandoc attribute with # and NO center line
{NOattribute if escaped\}

##  Test  Pandoc line block
ONLY IF PANDOC IS INSTALLED

| This is a pandoc line_block with mandatory empty line before
|      Leading Spaces in line blocks are preserved but not       the other extra spaces
|         Don't forget that |+tabs is reserved for paragraph indentation in markdock 
