
# Markdock  

Mardock is a markup language based on markdown to edit rich-text documents  


## Table Of Contents

-  [Table Of Contents](#table-of-contents)
-  [About Markdock](#about-markdock)
-  [Cheat Sheet](#cheat-sheet)
-  [Document structure](#document-structure)
-  [New Line](#new-line)
-  [Title](#title)
-  [Header](#header)
-  [Heading2](#heading2)
	-  [Heading3](#heading3)
		-  [Heading4](#heading4)
			-  [Heading5](#heading5)
				-  [Heading6](#heading6)
-  [Emphasis](#emphasis)
-  [Text Size And Color](#text-size-and-color)
-  [Line Justification](#line-justification)
-  [Paragraph Indentation](#paragraph-indentation)
-  [Advanced Text Justification](#advanced-text-justification)
-  [PDF Page Break](#pdf-page-break)
-  [Horizontal Rule](#horizontal-rule)
-  [List Unordered](#list-unordered)
-  [List Ordered](#list-ordered)
-  [Block Quotes](#block-quotes)
-  [Code Inline](#code-inline)
-  [Code Block](#code-block)
-  [Link](#link)
	-  [Link URL](#link-url)
	-  [Link File](#link-file)
	-  [Link Header](#link-header)
	-  [Link Mail](#link-mail)
-  [Image](#image)
-  [Image with URL ( Web Link )](#image-with-url-web-link)
-  [Task Lists](#task-lists)
-  [Definition List](#definition-list)
-  [Table](#table)
-  [Table Of Content](#table-of-content)
-  [Footnote](#footnote)
-  [Metadata](#metadata)
-  [Files inclusion](#files-inclusion)
-  [Escape Characters](#escape-characters)
-  [Disable/Escape HTML Code](#disableescape-html-code)
-  [Comment](#comment)
-  [HTML Code](#html-code)
-  [HTML alias](#html-alias)
-  [Archive .mdz](#archive-mdz)
-  [Archive encrypted .mdZ](#archive-encrypted-mdz)
-  [Pandoc compatibility](#pandoc-compatibility)
-  [References](#references)


## About Markdock

Markdock is a plain-text formatting language based on markdown.  
The main usage is to **create/exchange "Rich-Text" documents** based on markdown  

This language extend and simplify markdown rules  
These rules **do not break backward compatibility** with markdown  
You can always use Markdown/HTML code inside the document to obtain full-compatibility  

Main changes compared to markdown are :  

1.  New line doesn't need 2 trailing spaces or '\\'  
2.  Rules for :  underline, text  justification, image size, document title and files inclusion  
3.  HTML alias  
4.  Define an archive '.mdz'   ( ZIP archive )  
5.  Define headers font size  


## Cheat Sheet

|         MARKDOWN                |         MARKDOCK
|:-------------------------------|:-------------------------------------------|
| Newline: 2trailing spaces or \\  |  New line/hard-break done by default
| Empty line : \\ or <br\>          |  Empty line: 2 Spaces ( or \\ )
| Extra-spaces/tabs ignored       | 	Extra Spaces/Tab ignored
|   .md file                      |  .md / zip archive(.mdz)
|  \*italic\*  or  \_italic\_         |  \_italic\_
|  \*\*bold\*\* or \_\_bold\_\_           |  \*\*bold\*\*
|  \*\*\*bold italics\*\*\*             |  \*\*\*bold italics\*\*\*
|    \<u\>underline\</u\>             |  \_\_underline\_\_
|   <b\><u\>underline\</u\></b\>       |  \_\_\_bold underline\_\_\_
|     \~\~strikeout~\~               |  \~\~strikeout\~\~
| 	<mark\>highlight\</mark\>         |  \<mark\>highlight\</mark\>
|         -                       |  \+\+Big Font\+\+   ( FontSize +2pt )
|         -                       |  Title: # Text + 2 trailing spaces
| # Header 1                      |  # Header1 (FontSize+6pt)
| ##(##) Header2-4                |  ##(##) Header2-4 (FontSize +4/+2/0)
| #####(#) Header5-6              |  #####(#) Header5-6 (FontSize 0/-2)
| Underlined headers with =/-     |  NOT SUPPORTED
| \<sup\>superscript\</sup\>          |  \<sup\>superscript\</sup\>
| \<sub\>subscript\</sub\>            |  \<sub\>subscript\</sub\>
| Unordered list [Spaces]- * +    |  Unordered list [Spaces/0-2Tabs]- * +
| Ordered list  [Spaces]1. 1)     |  Ordered list  [Spaces/0-2Tabs]1. 1)
| >/>> Block Quote                | >/>> Block Quote  (begin line with >)
|          -                      |  ::[Spaces/Tabs] Full-Justification
| \<div align='center'\>            |  :::[Spaces/Tabs] Justify line center
| \<div align='right'\>             |  ::::[Spaces/Tabs] Justify line Right
|            -                    |  \|1Tab   Paragraph indentation Level1
|            -                    |  \|2Tabs  Paragraph indentation Level2
|            -                    |  \|3Tabs  Paragraph indentation Level3
| Horizontal rule -\--/*\*\*/_\_\_     |  -\-- Horizontal Rule
| \<div style='page-break-...'\>    | {\{pagebreak}\}   Page Break
| \<span style='...'>Text</span\>   |  'Text'\{serif #red 1.0em center ...}
|  <\!--  comment  --\>             |	  <\!--  comment  --\>
|  HyperLink [Name]\(http...)      | URL:[Name]\(http..) <http..\>  http..
|  Link File:  [Name]\(FilePath)   |  Link File:  [Name]\(FilePath)
|  Header Link [HeaderName]\(#ID)  |  Header Link: [HeaderName]\(#ID)
| Image ![Name]\(ImagePath)        |  ![Name]\(ImagePath)
| Image ![Name]\(Path\){width=20px} |  ![Name;20px]\(ImagePath)
|   \`Code Inline\`                 |   \`Code Inline\`
| Indented CodeBlock(4spaces+Code |  NOT SUPPORTED
|  \`\`\`[language] Code Block\`\`\`    |  \`\`\`[language] Code Block\`\`\`
|  Table(Github Flavor Markdown)  |  Table (Github Flavor Markdown GFM)
|  : Definition List              |  : Definition List
|  [\^text]  footnote reference    |  [\^text]  footnote reference 
|  [\^text]: footnote description  |  [\^text]: footnote description 
|  - [x]  Task Completed          |  - [x]  Task Completed
|  - [ ]  Task incomplete         |  - [ ]  Task incomplete
|  NO files inclusion             | {\{include [name]\(FilePath)}\} 
|  NO metadata                    | YAML block ( --- Key: Value --- )


## Document structure

In markdown/markdock, a document consists of a series of block elements :  

-  Metadata    ( Title/Subject/Author... )  
-  Header  
-  Paragraph  
-  List  
-  Definition list  
-  Blockquote  
-  Code block  
-  Table  
-  HTML block  
-  Horizontal rule  
-  Footnote definition  

**A block element starts on a new line and extends to the next empty line/block element**  
**An empty line between 'block elements" is necessary**  


## New Line

With Markdown, you need two trailing spaces, backslash '\\'  or  \<br\> to make a hard line break.   
With **Markdock**, a new line is a new line  
If you need more than 1 empty lines between block elements, use ` 2 spaces ` or  \\  

```  
Block1  
2 spaces or \  
Empty line  
Block2  
```  

## Title

Markdock introduces a new rule for document title :  
`# Text [ 2 Trailing spaces ]`  
This header reference is ' h1.Title ' in CSS style sheet   and is not displayed in Table Of Content  


##  Header

Begin lines with 1 to 6 '#' followed by space.  
##  Heading2
###  Heading3
####  Heading4
#####   Heading5
######    Heading6

In markdock, formatting inside headers and Headers with "====" / "-----" are not supported  

The table below show the recommendation for header size :  

| Header  | Markdock Size   | HTML5 default Size      
|:-------:|:---------------:|:-----------------------:|:-----------:|
|H1 title |    +10pt        |       -                 
|   H1    |    +6pt         | 2em/24pt                
|   H2    |    +4pt         | 1.5em/18pt              
|   H3    |    +2pt         | 1.17em/14pt             
|   H4    |    Normal       | 16px/1em/12pt (Normal)  
|   H5    |    Normal       | 10pt                
|   H6    |    -2pt         | 8pt                 


## Emphasis

|    Syntax               |   Render as
|---------------------------------|:----------:|
|  \_italic\_               |   _italic_
|  \*\*Bold\*\*               |    **bold**
|  \_\_Underline\_\_          |  __Underline__
|  \*\*\*Bold Italic*\*\*        |  ***bold italic***
|  \_\_\_Bold Underline\_\_\_   |  ___bold underline___
|  \<mark\>Highlight\</mark\> |  <mark>Highlight</mark>
|  \~\~Strikeout\~\~          |  ~~strikeout~~
|  \<sup\>subscript\</sup\>   | <sup>superscript</sup>
|  \<sub\>subscript\</sub\>   |  <sub>subscript</sub>

 You can combine emphasis :    ` _italic **bold** now_ `  render as   _italic **bold** now_  


## Text Size And Color

1.  Big Font : markdock introduces a new syntax:     +\+Big font+\+    ( render as ++BigFont++ )  
2.  Small font :  Use  `<sup>superscript</sup>`  or ` <sub>subscript</sub> ` syntax  
3.  For specific Text size/Family/color,  use [HTML alias](#html-alias)  


## Line Justification

Markdock introduce a new syntax for text justification  

-  Fully-justify  :  Begin each lines with  ` :: [spaces/tabs] Text `  
-  Center justification  :  Begin each line with ` ::: [spaces/tabs] Text `  
-  Right justification  :   Begin each line with ` :::: [spaces/tabs] Text `  

> Note : There is no full-justification inside Xwriter:  only when you export the document  

For a block justification, you can use CSS class with  [HTML alias](#html-alias) :  
```  
'  
The paragraph to fully-justify here  
It's cool  
'{.fulljustify}  
```  
CSS class ( .center .right .fulljustify) are defined in ` Menu > ▣ > Edit HTML style `   


## Paragraph Indentation

Markdock introduce a new syntax for paragraph indentation : `|1/2/3 Tabs + Text`      

|	Paragraph indentation1 :  begin line with  | + 1 tab  
	Line2 with 1 tab  

|		Paragraph indentation2 : begin line with | + 2 tabs  
		Line2 with 2 tabs  

|			Paragraph indentation3 : begin line with |+ 3 tabs  
			Line2 with 3 tabs  

Each paragraph stop with empty line or another paragraph indentation  
Add tabs to indent the lines as you will do in a plain-text editor  


## Advanced Text Justification

You can use [HTML alias](#HTML alias) to obtain Advanced Text justification on same line :  
Example1 :  
```  
This is left Text and 'Right-JustifyText'{right}  
::: This is  'center' text with  'Right-JustifyText'{right}  
```  

Example2 :  left/center/right text on same line ( order and empty lines are important )  

```  
'left text'{left <>33%}  

'right text'{right}  

'center text'{center <>33%}  
```  

⚠️  HTML alias are applied only when you export to HTML  


## PDF Page Break

Begin line with ` {{pagebreak}} `  


## Horizontal Rule

Begin Lines with at least 3  '-'  :  ` --- `  


## List Unordered

Syntax:    ` [Spaces , 0-2Tabs]  +/-/*  [Spaces/Tabs] Text   `  
A list stop with another block element ( paragraph, header ... )  
**If you use TAB, always begin a list with 0 TAB**  

- List **0 TAB**  
	* List   **1 TAB**  
		+ List **2 TAB**  
		+ List **2 TAB**  
	* List  **1 TAB**  


## List Ordered

Syntax:    ` [Spaces, 0-2Tabs]  Number./Number)  [Spaces/Tabs] Text   `  
A list stop with another block element ( paragraph, header ... )  
**If you use TAB, always begin a list with 0 TAB**  

1. List  **0 Tab**  
	1) List   **1 Tab**  
		1. List **2 Tab**  
		1. List **2 Tab**  
	2) List **1 Tab**  


## Block Quotes

Syntax : begin each line  with ` >  or >>    `  

> This is a block quote  qhsdqds qjshgdjhqgsdq jqhsdjhgqh sdgqgs hdqgjsdgh hqsgdjqd qhsdgjqhgdsjhgqdqhgsdjhqdsqd  hf fqsd  qsfd gfdsdgfqsd gqsd  
>  
>> A sub-level blockquote  


## Code Inline

Use backtick for code Inline :   \` code inline  \`  

> Note: Markdown formatting is disable inside  'Code inline'  


## Code Block

Fenced Code block with three backticks  and optional language   ( \`\`\`[language] )  

\`\`\`sh  
	echo this  | grep i | awk lol  
\`\`\`  

Markdock **DO NOT** support  Indented Code block with four spaces  ( strongly discouraged )  
Xwriter support highlight inside CodeBlock ( See  [CodeHighlighting.md](test/TestCodeHighlighting.md) )  


## Link

### Link URL

Syntax : ` <http..>  ,     http...     ,    [Name](http:...) with Name=NO empty string`  

Direct Link :    http://duckduckgo.com      and    <http://google.com>  
Link with Name :     [Duck Duck Go](https://duckduckgo.com)  

### Link File

Syntax : ` [Name](Absolute or Relative Path) ` with Name=NO empty string  

```  
Absolute Path	:  [My File](/etc/apt/sources.list)  
Same Folder	:  [My File](README.md)  
Sub Folder		:  [My File](test/file.md)  
Up Folder     :  [My File](../test.md)  
```  

### Link Header

Syntax : ` [Description]\(#headerID) `  

The headerID  is generated from the header name by replacing spaces/special characters to one hyphen "-", then lowercase the string and trim leading/trailing spaces  

Do not use multiples spaces and special characters ` \ ( ) [  ] ... `  


### Link Mail

Syntax: `[Description](mailto:example@gitlab.com)`  


## Image

**Syntax** :  ` ![Name;Optional With+px](Path/Image.jpg) `  
( on Xwriter, same Image with different width will NOT work )  

```  
Absolute Path : ![Name;100px](/Path/Image.jpg)  
Relative Path : ![Name;100px](SubFolder/Image.png or Image.jpg)  
Justify Center: :::  ![Name](Path) + space/any character  
```  

**Example** : Image with width=100px  ![MyImage;100px](test/test1.jpg)  

Note : you can apply [HTML alias](#html-alias) to an image  
A typical usage is to put image on the right with text on the left : ` Text Left  ' ![MyImage;100px](test1.jpg) '{right} `  


## Image with URL ( Web Link )

Images from the web are **not downloaded automatically**  
To download/display image :    Go to Toolbar > ▣ > Enable 'Display Web Image'  
( Images are stored in ~/.cache/xwriter   and are downloaded only once )  

Example:  Image with LINK ![ImagewithHTTP](https://www.freeiconspng.com/uploads/linux-icon-19.png)  

## Task Lists

- [x] this is a complete item with - \[x]  
- [ ] this is an incomplete item  with - \[ ]  
- [x] A task for @user  


## Definition List

```  
Term1  
: Description line1  
Description line2  

Term2  
: Description2  
```  

A new block element ( paragraph, header... ) stop the definition list  


## Table

The delimiter row consists of cells whose only content are hyphens (-), and optionally, a leading or trailing colon (:), or both, to indicate left, right, or center alignment respectively.  

```  
| Header1    |    Header2     |  Header3     |
|------------|:--------------:|-------------:| At least 3 '-'/column
| Left Item1 |   Center Item1 |   Right Item1|
| Left Item2 |   Center Item2 |   Right Item2| 
```  

Leading/trailing pipes `|` are optional  
( On Xwriter, a leading pipe on delimiter row display table with monospace font )
Use \\  to force a new line inside a table  
For table caption, begin a line with 'Table: xxx'  
__Note__ :  if you use pandoc converter, you can also define column width ( See [TestTable.md](/home/myself/.bin/Xwriter/test/TestTable.md) )  

**Column Width ( Only with pandoc converter )**  
   
Column width is defined by :  number of '-'/total number of '-' in delimiter row  
( ------|--- would make the first column 2/3,  and the second column 1/3 of the full text width )  

```  
| Header1 |         Header2            |  Header3
|---------|:--------------------------:|---------------------------:|
| a very long text will be shrink      | Center align | Right align
```  

By default, inside Xwriter, the table font is monospace : text justification, some formatting (bold...) are not visible but will be rendered properly when exporting to HTML/Docx.  


## Table Of Content

Xwriter can insert a Table Of Contents with ` Menu > Ins > Table Of Contents `  

>TIP  for a link to 'Table of Content'  :  ` :::: [⬆ back to top](#table-of-contents) `  


##  Footnote

```  
This is a footnote reference[^text]  
...  
[^text]: Footnote description  
```  

This is a footnote reference [^text]  
[^text]: Footnote description  


##   Metadata

Documents can include a metadata block that is not part of the main text.  

```  
---
author:           myself  
title:            This is the title  
subtitle:         A subtitle just below the title  
date:             11 Dec 2022  
description:      A long description...  
---
```  

Any  "key: value" can be used.  
If there are multiple lines of text in a metadata value, subsequent lines should be offset with whitespace  

If you use **pandoc** converter :  
1.  Metadata block can be located anywhere in the document  
2.  Metadata are exported to other documents  ( html, odt, docx, ... )  

If the document begins with a metadata block, this metadata block is hidden  ( Use shortkey 'Ctrl-Space'   to view/hide metadata)  


##  Files inclusion

Markdock introduces 2 syntax to include file(s) inside a document :  

1.  First syntax :  ` {{include [Name](FilePath) }} `         
	( Recommended :  File link is preserved. you can click to open the file )  
2.  Use code block with  \`\`\`include  :  

\`\`\`include  
	# Comment :  List of files with Absolute/Relative file path  
	\AbsoluteFilePath1  
	..\RelativeFilePath2  
\`\`\`  


## Escape Characters

Use backslash \\ to disable markdown formatting :   ` \_Not Italic\_    *\*Not Bold*\*  `  
__Supported characters__:  

	\* (asterisk)     \| (pipe)     \` (tick mark)     \_ (underscore)    \# (pound sign)  
	\+ (plus sign)    \- (minus sign/hyphen)      \^ (caret)      \=  (equal)    \< (left)   \> (right)  
    \~ (tilde)   \[ \]	(brackets)    \( \) (parentheses)    \\ (backslash)       \{ \}  curly braces   \: (colon)  
	\! (Exclamation mark)  \' (apostrophe)    \" (quotation)  

> Note:  No need to escape characters in "Code Inline" and "Code Block"  


## Disable/Escape HTML Code

Use  ` \<xxx\> ` to escape html code  : \<span style='color:red'\> text red  \</span\>  


## Comment

Syntax : ` <!--   Text  -->  `      Render as :   <!--   Text  -->  

on Xwriter, use `Control-Space` to View/Hide comment  


##  HTML Code

HTML code can be embedded in markdown/markdock document.   

**Note** : If you use 'lowdown' converter, markdown syntax inside HTML block elements ( as `<div>...` ) are not exported to HTML.  Install 'pandoc' converter if you need this feature  

Xwriter render ` <b> , <i>,  <u>, <center>, <kbd> ` as bold/italics/underline ... but only line by line  


## HTML alias

HTML alias enables to define font size, foreground/background colors, border...  
It can be applied to text, image and symbols  
HTML alias are applied **ONLY** when you print/export the document to HTML ( and PDF via HTML )  

**Syntax**:  'Text'\{serif  1.0em  #white  ##grey  |red  center ...}  

```  
Definition:  
- Font Family       :  serif/sans/mono = Serif/Sans/Monospace font  
- Font Size         :  1.0em (100%/16px) 0.8em (=80%/11px) 1.2em (120%/19px)..  
- Text Justification:  center/right/left  (HTML float left/right)  
- Text Color        :  #white...,hexadecimal value (#0xFFAC09 #FFAC09 )  
- Background Color  :  ##white...,hexadecimal value (##0xFFAC09 ##FFAC09)  
- Border color      :  |red  |black ...  
- Block             :  Apply the style for the full width (HTML display=block)  
- Block width       :  <>50%  ( Block width 50% )  
- Block padding     :  >10% ( Padding Left 10%)   <20%  ( Padding Right 20%)  
- .Myclass          :  Apply a HTML-CSS  class 'Myclass'  
If alias is unknown, the alias is supposed to be a font family  
```  

On Xwriter, HTML alias are partially hidden : Use Ctrl+Space to view/hide alias  
Some Examples : [TestAlias.md](test/TestAlias.md)  
Color Description: https://en.wikipedia.org/wiki/Web_colors  


## Archive .mdz

Markdock introduce a new file format '.mdz' to share your markdown files  
it's basically the markdown file + images included in the file.  

Markdock archive is a ZIP file container with :  

1.  At least one main Markdock file with extension '.md' at the root  
If several '.md' files exist, ' readme.md/main.md ' are searched in priority ( No Case sensitive )  
⚠  if readme.md/main.md don't exist,  the first .md file found at the root is loaded : Be sure to have only one markdown file in this case  
2.  All the images are placed in a unique sub-folder 'img'  in the archive. Absolute path are converted to a relative path ( as 'img/MyImage.jpg' ) in the root file  
3.  Inside markdock files, all objects **should** have relative path ( xx  or  ./xx  or  xx/yy )  

To generate an archive, Go to  ` toolbar > ⊙ > Save as `   and  give a name as   '<FileName\>.mdz'  
To open .mdz archive on Xwriter, Open the archive file as a normal file.  

__Warning__:  Only images are saved in the archive  

You can also build a complete archive with docs/images/objects inside : Compress the directory with ZIP and rename the ZIP file as xxx.mdz ( Be sure to use 'relative' path in your documents )  
Open this archive as a regular file on Xwriter **BUT** only change done at the root file .md will be saved  


## Archive encrypted .mdZ

This is a ZIP encrypted archive described on previous chapter.  
To generate an archive, Go to  ` toolbar > ⊙ > Save as `   and  give a name as   '<FileName\>.mdZ'  
( extension as .mdZ and not .mdz )  


##  Pandoc compatibility

Pandoc use also an extended markdown syntax ( example: `  [Text]{.attributes} ` )  
You can use pandoc syntax inside Xwriter with the following restrictions :  
1.  For 'fenced_divs' extention, always use `:::{ attributes }` without spaces between ` ::: ` and ` { `  


## References

1. [ GitHub Markup Reference](https://gist.github.com/ChrisTollefson/a3af6d902a74a0afd1c2d79aadc9bb3f#file-0-github-markup-reference-readme-md)  
2.  [Markdown Guide](https://www.markdownguide.org/basic-syntax)  
3.  [Cheat_Sheet](https://www.markdownguide.org/cheat-sheet)  
4.  [Github Flavor Markdown (GFM) Cheat sheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet)  
5.  [GitHub Markdown Formatting](https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)  
6.  [Gitlab_Advanced_Markdown](https://docs.gitlab.com/ee/user/markdown.html)  
