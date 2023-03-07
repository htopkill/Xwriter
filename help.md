
#  Xwriter  V0.4.2    

Use 'Escape' or 'F1' to exit Help

   [Introduction](#introduction)
   [Essential ShortKeys](#essential-shortkeys)
   [Editing Shortkeys](#editing-shortkeys)
   [Formatting Shortkeys](#formatting-shortkeys)
   [Markdock syntax](#markdock-syntax)
   [Table](#table)
   [Menu tools ▣](#menu-tools)
   [Left Pane](#left-pane)
   [Bookmark](#bookmark)
   [Spell](#spell)
   [Export to HTML/PDF](#export-to-htmlpdf)
   [Export to Other format](#export-to-other-format)
   [Pandoc filters](#pandoc-filters)
   [Archive .mdz](#archive-mdz)
   [HTML Alias](#html-alias)
   [Shortcode](#shortcode)
   [Metadata](#metadata)
   [Compare Files](#compare-files)
   [Force New lines / trailing spaces](#force-new-lines-trailing-spaces)


##  Introduction

*  To view/hide markdown symbols, use shortkey 'Ctrl-Space'
*  The text is formatted each time you enter a new line (or with 'Ctrl-r' )
*  Markdown files must have extension .md or .mdz/.mdZ for archive
*  Code syntax is highlighted when mouse hover the code

## Essential ShortKeys

 MAIN SHORTKEYS |  DESCRIPTION
|---------------|----------------------------------------------|
 Esc            |  Clear message, Exit buffer (Help, Unicode symbol )
 Ctrl-Space     |  View/Hide  markdown symbols/Metadata  (Try it Now !)
 Ctrl-r         |  Reformat (Re-Apply syntax formatting to all document)
 Ctrl-Return    |  Remove markdown symbols/tags to the selection


## Editing Shortkeys

    SHORTKEYS         |          -                |         -
|---------------------|---------------------------|--------------------|
 Ctrl o: Open         | Ctrl s: Save              | Ctrl q: Quit
 Ctrl O: Recent files | Ctrl g: Goto line         | Ctrl+-: Zoom +/-
 Ctrl S: SaveAs       | Ctrl f: Find/Replace      | Ctrl w: Wrap line
 Ctrl x: Cut          | Ctrl c: Copy              | Ctrl v: Paste
 Ctrl A: Select All   | Ctrl z: Undo              | Ctrl Z: Redo
 Ctrl left: Next Word | Ctrl right: Prev. word    | Ctrl Up: Page Up
 Ctrl Down: Page Down | Ctrl a: Line start        | Ctrl e: Line End          
 Ctrl <: Width +/-    | Ctrl B: Bookmark          | Ctrl t: Switch Theme
 Ctrl T: Table Content| Ctrl r: Reformat          | Ctrl p: Print/Preview
 Ctrl U: Unicode char | Ctrl I: Get Info          | 
 F1    : Help         | F2    : Spell             | F3: Spell language
 F4    : Conjugate Fr |                           | 


##  Formatting Shortkeys

  SHORTKEY FORMATTING  |          -             |         -
|----------------------|------------------------|------------------------|
 Ctrl b: Bold          | Ctrl i: Italic         | Ctrl u: Underline
 Cltr h: Heading       | Ctrl m: Mark/Highlight | Ctrl k: Superscript
 Ctrl j: Justification | Ctrl l: Big Font       | Ctrl Tab: Indent Paragraph
 Ctrl C: Code (one line:CodeInline, multiple lines: CodeBlock) |



## Markdock syntax

Based on [markdown syntax](doc/markdown cheatsheet.md)
Advanced Help for markdock format : [Markdock](markdock.md)
A lot of [Example/Test](./test) 

 ITEM         |                       SYNTAX
|-------------|-------------------------------------------------------------|
 Title        | # Document Title + 2 trailing spaces
 Heading      | # Heading1    ## Heading2    ###(###) Heading3-6
 Main         | \_italic\_    \*\*Bold\*\*   \*\*\*Bold Italic\*\*\*
              | Warning : italic must be followed by space/EndOfLine
 Main         | \_\_Underline\_\_    \_\_\_BoldUnderline\_\_\_
              | <mark\>highlight</mark\>   ~~strikeout~\~
              | <sup\>subscript</sup>  <sub\>subscript</sub>  Horiz.Line: -\-\-
              | +\+Big Font+\+ 
 HTML alias   | 'Text'\{serif #red ...}   ( See section 'HTML alias')
 Quote        | > Block Quote     >> Block Quote Level 2
 List         | [0-2Tabs]+/-/*    [0-2Tabs]1. or 1)
 Code         | `CodeInline\`     \`\`\`[Language] Code Block \`\`\`
 URL          | http://google.com   [name]\(http://google.com)
 Image        | ![Name]\(/x/x.jpg) ![Name]\(x.jpg) ![Name]\(SubDir/x.jpg)
              | ![Name;100px]\(Path/xx.png) 
 FileLink     | [Name]\(Path/FileName)    No Path= Document Path
 HeaderLink   | [Name]\(#HeaderName)   HeaderName= "xxx-yyy-zzz"
 Comment      | <\!--  Text  --\>    Use Ctrl-space to view/hide
 Justify      | :: Fully-justify   ::: Center    :::: Right
              | Center Image  ::: ![Name]\(xx.jpg)+[any space/char]
 Indent       | \|+1tab Indent1   \|+2tab Indent2   \|+3tabs Intent3
 Page Break   | \{{pagebreak\}}
 Include file | {{include [Name]\(FilePath) }\} (Recommended)  
              | In a code block as \`\`\`include + list of files \`\`\`  


## Table

See [Markdock](markdock.md) , section 'Table'
1.  If the delimiter row begins with '|' , Table uses monospace font
2.  Double-Click on Table header to toogle line wrapping


## Menu tools ▣

*  Force New Line : Add 2 trailing spaces at each line. Force HTML new line
*  Display Web Image : Download Image with a link (http...)

 
## Left Pane

*  The left pane appears when you activate 'bookmark', 'recent files' , 'Table Of Content', 'Spell'...
*  Single-click on item : Load item, Keep left pane open ( usefull to preview/copy-paste...)
*  Double-click on item : Load item and close left pane
*  Click on left pane Top header : Close the left pane 


## Bookmark

*  On Toolbar, click '★'  to display bookmark List
*  Left pane buttons :
	**Add:** Bookmark current document    **Remove:** Remove selection      **Edit:** Edit Bookmark
*  To define a bookmark category : Edit Bookmark, add a line as { MyCategory }, Save the file (Ctrl-s)


## Spell

*  Install language packages: sudo apt install aspell-en  aspell-fr (for french...)
*  Spell check is not done inside Code Inline/Code Block
*  Set native language with "menu > Preferences" and use key 'F3' to toggle language ( Native <--> english )
*  F2: Start Spell check       Escape: Abort        F2: next/continue
*  Left pane buttons :
		**Add** Add to dictionary   **Ignore** Ignore until next restart   **Next** Continue
*  Replace word : Select a word on left pane
*  Start spell check at a position : select the position, then F2
*  Custom Dictionary : Edit file ~/.config/xwriter/dict.en.pws
(only english custom dictionary available)


## Export to HTML/PDF

The converter by default is [Pandoc](doc/pandoc-markdown.md).  If pandoc is not installed, the converter is [Lowdown](doc/lowdown.md)
Be sure to understand the limitation and syntax for the converter you use
*  Preview HTML : Ctrl+p
*  Export As HTML : Ctrl+S (SaveAs) and select 'HTML file'
( a file 'style.css' will be copied in the destination folder)
*  Print/Export As PDF  : Export as HTML, then use 'print' in your browser
Tip1 : If you select a text inside xwriter, only the selection will be exported to HTML
Tip2 : If you got an error, you can directly open the HTML file with top toolbar entry box


## Export to other format

Require application 'pandoc' installed
*  Edit export style:  Select Toolbar > ▣ > Edit Document style
*  Export a document:  Ctrl-S (SaveAs) and set filename with the appropriate extension (.docx/.odt/.pdf/.epub/.rtf/.xml)
*  Raw HTML inside document works only with :
		HTML, S5, Slidy, Slideous, DZSlides, EPUB, Emacs Org mode, Textile
*  Markdock syntax (center,underline...) works only with DOCX


##  Pandoc filters

1. Use pre-defined pandoc filters : [pantcl filters](doc/pantcl/)
pre-defined filters are disable by default at each start
Activate pre-defined filters in  Toolbar > ▣ > Enable pantcl filters
or
2. Write your own lua filters in ~/.pandoc/filters and enable these filters in Menu > Preferences

## Archive .mdz

*  Export .md document to Archive (.mdz) :  Menu > SaveAs > select 'markdown archive'
*  Export .md document to encrypted Archive (.mdZ) : Menu > SaveAs > select 'markdown Encrypt Archive'
*  Open/Save archive .mdz/.mdZ like any other file


## HTML Alias

Use 'Control-Space' to Display/Hide HTML alias on Xwriter
Works only when you export to HTML (and PDF with browser print menu)

Syntax: 'Text'{serif 1.2em #white ##grey |blue ...\} 

Alias Definition:  

*  Text Family:  serif/sans/mono = Serif/Sans/Monospace font  
*  Text Size  :  1.0em (100%/16px) 0.8em (=80%/11px) 1.2em (120%/19px) ...  
*  Text Color: #white,#red...,hexadecimal value (#0xFFAC09 #FFAC09 #ffac09)  
*  Background Color: ##white...,hexadecimal value (##0xFFAC09 ##FFAC09 ##ffac09)  
*  Border color : |black   |red
*  Text Justification:   center/right/left (float left/right)
*  block : Apply the style for the full line (HTML style display=block)  
*  .Myclass : Apply a HTML-CSS  class 'Myclass'  
*  block width:  <>50%  ( Block width 50% )  
*  Block padding:  >10% ( Padding Left )   <20%  ( Padding Right )  
If alias is unknown, the alias is supposed to be a font family 


## Shortcode

Shortcode can execute complex functions
Right now, there is only 2 shortcode :
1.  {{include  <file>}}   to include file before exporting
2.  {{pagebreak}}  to insert page break

## Metadata

See [markdock](markdock.md), section metadata for help
- Use 'Ctrl+Space' to Display/Hide metadata


## Compare Files

1.  Load the new file
2.  Select 'Menu > Compare File' and choose the old file
3.  You can save the output in a file with '.diff' extension and re-open this file later


##  Force New lines / trailing spaces

1. In Menu ▣ > ForceNewLine
Add 2 trailing spaces to lines in the document. 
Usefull if you want to export to a platform (github..) with pure markdown syntax
2. In Menu ▣ > Remove trailing spaces
Remove all trailing spaces in the document

