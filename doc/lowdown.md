
# LOWDOWN  

::: A markdown to HTML/LATEX/ODT/PDF/ROFF  converter
::: https://kristaps.bsd.lv/lowdown



- [Limitations](#limitations)
- [Description](#description)
- [Block Elements](#block-elements)
	- [Paragraphs and Line Breaks](#paragraphs-and-line-breaks)
	- [Headers](#headers)
	- [Block Quotes](#block-quotes)
	- [Lists](#lists)
	- [Definition Lists](#definition-lists)
	- [Code Blocks](#code-blocks)
	- [Horizontal Rules](#horizontal-rules)
	- [Metadata](#metadata)
	- [Mathematics](#mathematics)
	- [Tables](#tables)
	- [Footnote Definition](#footnote-definition)
	- [HTML Blocks](#html-blocks)
- [Span Elements](#span-elements)
	- [Emphasis](#emphasis)
	- [Links](#links)
	- [Automatic Links](#automatic-links)
	- [Images](#images)
	- [Code](#code)
	- [Footnote Reference](#footnote-reference)
	- [Superscripts](#superscripts)
- [HTML Content](#html-content)
- [Escapes](#escapes)
- [Typography](#typography)
- [Standards](#standards)



# Limitations

lowdown is lighter than ` pandoc `, but less powerfull and more strict.

1.  lowdown requires a blank line before/after each block elements as header/codeblock/list...
2.  lowdown recognize 'new-line' as a  'hard line break' **ONLY** in paragraph : If you need a 'new-line' in a list or other block elements, you need  '2 trailing spaces' or ` <br> `  at the end of the line
3.  lowdown do not parse markdown inside HTML block elements as `<div>...`
To bypass this limitation, you can encapsulate your block elements in `span`  ( example `<span><div>....</div></span>`) but it's recommended to use ` pandoc ` converter instead
4.  lowdown cannot export document to docx/epub/odt... with the debian stable  version  0.8.2


# Description

Markdown is a simple, plain-text formatting language.  “Plain-text” in this
     case means the document input looks similar to the output, less the formatting
     niceties (boxed tables, italics, clickable links, etc.)  provided by the output
     medium.  For example:

           # How to be a Picard fan

           ## Introduction

           In order to develop fandom skills one must first and foremost
           know *whom* one idolises. Therefore: **who is Captain Picard**?

           1. Picard was named the \*Best Star Trek Captain\*, according
           to a [5-week poll](poll.html).

               > Picard continued his winning ways in the final week,
               > with fans naming him the most inspiring captain.

           2. Picard is handsome. ![Picard](image.jpg)
           3. Picard knows how to code: `make engage`

           ---------------------------------

           ## Picard Fandom

           Here's why everyone wants to be a fan...

     This example consists of a series of block elements: section header, sub-sec‐
     tion header, paragraph, set of list elements, horizontal rule, then another
     sub-section header.  Each block element contains span elements: normal text,
     emphasised text (bold and italised), an image, a link, and a span of code.

     This document describes the Markdown syntax accepted by lowdown(1).


# Block Elements

A block element starts on a new line and extends to the next blank line or block element.  
A block element contains span elements.

##   Paragraphs and Line Breaks

     A paragraph is made up of one or more lines of text possibly containing span
     elements.  Paragraphs are separated by blank lines.

     To insert a hard line break (i.e., a line-break in the input that is reproduced
     in the output), insert two spaces at the end of the line.  If commonmark input
     parsing is enabled, this may also be effected by escaping the newline:

           Darmok and Jalad...\
           at Tanagra.

## Headers

     There are two styles of headers: underlined (“setext”) and hash-marked (“atx”).
     For underlined headers, underline the given word using equal signs (“=”) for
     first-level headers and dashes (“-”) for second-level headers.

           This is an underlined header 1
           ==============================

     For hash-marked headers, use the corresponding number of hash characters to the
     corresponding level of header, up to 6 levels, at the start of the line sepa‐
     rated by one space followed by the header.

           ## This is a hash-marked header 2

     If commonmark input parsing is enabled, the space is required after the hash-
     marks in any hash-marked header.

##   Block Quotes

     Block quoted sections are invoked with a single right-angle bracket (“>”) fol‐
     lowed by a space at the start of each line and between paragraphs.

           > The Prime Directive is not just a set of rules;
           > it is a philosophy... and a very correct one.
           >
           > (It goes on for a few paragraphs).

     Block quotes may also have a non-multiline invocation: you need only invoke the
     right-angle bracket at the start of a paragraph and omit it entirely between
     paragraphs.

           > You cannot explain away a wantonly immoral act because
           you think it is connected to some higher purpose.

           > Here is another paragraph about Picard wisdom.

     Consecutive blockquotes as above will be merged as paragraphs within a single
     block quote on output, even if styles (non-multiline and otherwise) are mixed.

     Block quotes may be nested within other block quotes, as may any other block
     elements such as headers, ordered/unordered lists, and code blocks.

           > ### hash-marked header 3
           >
           > > I'd be delighted to offer any advice
           > > I have on understanding women.
           > > When I have some, I'll let you know.
           >
           > 1.  advice list item 1
           > 2.  advice list item 2
           >
           > Here's the code to implement JLP's advice:

           >     yes | read engage

##   Lists

     Lists may be specified as ordered (numbered) or unordered.  Ordered lists are
     invoked as numbers followed by periods (e.g., “1.”) and rendered in a similar
     format.  Note: it does not matter which order or which numbers you use in your
     ordered lists, as all ordered lists start at one.

           1. Make.
           2. It.
           1. So. (Not 1. again!)

     If commonmark input parsing is enabled, list items may alternatively terminate
     with the right parenthesis:

           1) Live long
           2) Prosper

     To prevent lists erroneously started by a paragraph beginning with a number and
     period, use a backslash before the period.

           1987. The year TNG premiered.

           1987\. The year TNG premiered.

     Unordered lists, on the other hand, can be invoked using either asterisk (“*”),
     pluses (“+”), or hyphens (“-”), and can be a mix of all three styles.  Regard‐
     less the style, list items are rendered the same way.

           - Earl Grey tea.
           * Shakespeare.
           + Exotic fish.

     All nested block elements need a new line break, otherwise they will be ren‐
     dered on the same line as the list item on output.  To insert paragraphs into a
     list item, indent each paragraph with either four spaces or one tab.

           - First list item

               Courage can be an emotion too.

               Things are only impossible until they're not.
           + Second list item
           + Third list item

     To insert block quotes into a list item, indent the block quote with four spa‐
     ces or one tab prior to the right-angle bracket (“>”).

           * List item 1
           * List item 2

                > I am Locutus of Borg.

                > That is the cutest of Borg.

     Code blocks need to be indented twice (two tabs or eight leading spaces): once
     for being recognised within the list item, another for the code block itself.

           * Here is a list item for an indented code block:

                   alias path='echo -e ${PATH//:/\n}'

     To make list elements occur in tight sequence — like a grocery list — don't
     have an empty line between the items.

           - Phaser
           - Communicator

     On the other hand, if you want to render lists separated by white-space, use
     the following syntax:

           - A phaser is a type of weapon.

           - A communicator keeps Riker in contact with Troi.

     This applies to ordered and unordered list types.

##   Definition Lists

     Definition lists are a PHP Markdown Extra extension.  They're similar to lists
     except in having key and value pairs, with keys being preceded by a blank line:

           Best understated characters:

           *Quark*
           : Armin Shimerman

           *Weyoun*
           : Jeffrey Combs

     Keys consist of a single line and may contain inline elements.  Like other
     lists, values may consist of arbitrary nested blocks.  There may be multiple
     consecutive values per key.  If the key and value are separated by a blank
     line, the list is emitted as if it contained block elements (usually output as
     spacing between key-value pairs).

##   Code Blocks

Code blocks consist of pre-formatted text, such as source code.  
Each code block contains opaque/literal text.  This means that new lines and white spaces are retained, they're not formatted in any way, and any text inside the code block is not interpreted.  
To invoke a code block, create a line break then indent each line with four spaces or one tab.

           Here is a paragraph about Bridge protocol

               Here is a code block for the command "Engage"

Within a code block, text is escaped given the output format.  Therefore, characters that would normally need to be escaped in other text processing languages such as ampersands (“&”) do not need to be escaped.

Here is how you start the program xterm:

               xterm &

##   Horizontal Rules

     A horizontal rule is a line that goes across an output page.  These are invoked
     with three or more asterisks (“*”), hyphens (“-”), or underscores (“_”) on
     their own line.  Spaces between these characters are disregarded.

```
           ***
           * * *
           ---

  - - -
           ___
           _ _ _
           ___________________________
```
___

##   Metadata

     Documents can include metadata that is not part of the main text.  The syntax
     loosely follows the "Multimarkdown" specification.

     The metadata block begins on the document's first line and continues until the
     first blank line.  It consists of one or more key-value pairs, with keys and
     values separated by a colon, and pairs separated by a newline.  A key (and fol‐
     lowing value) must exist on the line beginning the metadata pair, but the value
     may span multiple lines.

           Title: Captain's log
           Author: Captain J-L Picard
           Summary: As part of an exchange program, we're taking
            aboard a Klingon officer to return the recent visit
            of Commander Riker to the cruiser Pagh.
           Stardate: 43917.4

     If there are multiple lines of text in a metadata value, subsequent lines
     should (but need not) be offset with whitespace.  Otherwise, they must not have
     a colon in the value, else they will be construed as a subsequent pair's key.

     End each line with two spaces to ensure linebreaks are rendered on output for
     non-conforming Markdown renderers.  Moreover, beginning a document with a regu‐
     lar sentence containing a colon might invoke metadata.  To escape this, add one
     blank line to the beginning of the document.

     Metadata keys must consist of alphanumeric ASCII characters, the hyphen ("-"),
     or the underscore ("_").  They must have at least one character and are
     stripped of white-space and converted to lower case.

     Metadata values are opaque text: Markdown statements (e.g., italics, entities,
     etc.) are copied as-is.  The values will have leading white-space stripped,
     i.e., space following the colon.

     If multiple metadata keys resolve to the same name, the last invocation is re‐
     tained.  This check happens after canonicalising the name by stripping spaces,
     converting to lower-case, and substituting unknown characters.

     Metadata values may be pasted into a document by referencing the [%key], such
     as using the above example, again with the caveat that Markdown annotations
     (italics, etc.) are copied verbatim:

           Stardate: 43917.4

           It's currently stardate [%stardate].

##   Mathematics

     Mathematics support is an extension of Markdown.  The extension only describes
     how the math blocks begin and end: the contained equations are usually in LaTeX
     and implemented in the front-end (e.g., HTML).  There are two types: inline and
     block.  Both may occur anywhere in a text stream.  Inline equations are ren‐
     dered as part of the text; block equations are rendered on their own.

           This is an inline $f(x)$ function.
           This is a block $$f(x)$$ function.
           This is also an inline \\(f(x)\\) function.
           This is also a block \\[f(x)\\] function.

##   Tables

     Tables are a GFM (GitHub-flavoured Markdown) extension of the basic syntax.
     They consist of a table header and body, and columns may be left, right, or
     centre justified.

           | Officer         | Rank                 |
           | --------------: | -------------------- |
           | Jean-Luc Picard | Captain              |
           | Worf            | Lieutenant Commander |
           | Data            | Lieutenant Commander |
           | William Riker   | Commander            |

     The table header must be followed by a line of hyphens with at least three hy‐
     phen/colons per column.  Columns are separated by vertical bars.  The colon in‐
     dicates alignment: a colon at the beginning means left justified; at the right
     for right justified, and both for centred.

     The leading and trailing column separator is superfluous.  Table data is not
     necessary, but the table header is.  The minimum table structure for the above
     is:

           Officer | Rank
           --:|---
           Jean-Luc Picard | Captain

     Table columns may contain arbitrary span elements.

##   Footnote Definition

     Footnotes are a MMD (Multimarkdown) extension of the basic syntax.  Footnote
     definitions may occur anywhere in the text (except within blocks) and are
     “pointed to” by a Footnote Reference.  They consist of the footnote name (in
     square brackets, preceded by the caret), a colon, then everything remaining in
     the block is the footnote content.

           [^pt]:
               Klingon insult, meaning something like "weirdo," deriving from
               the verb "to be weird" (**taQ**), with and [sic] you (plural)
               imperative prefix (**pe-**).

     Footnote contents may be on the same line as the colon.  The footnote name is
     rendered as a number.  If a footnote definition is not referred to, it is not
     printed.

##   HTML Blocks

Embedded HTML is discouraged, as it inhibits formatting into non-HTML output, but is still accepted.
Blocks of HTML must begin with a recognised HTML block-level element.

In the original Markdown, block-level elements were well-defined by HTML4.
HTML5 elements are also accepted, but as there is no concept of block-level in HTML5, these are non-canonical.
Accepted elements are :  ` <address>, <article>, <aside>, <blockquote>, <del>, <details>, <dialog>, <dd>, <div>, <dl>, <dt>, <fieldset>, <figcaption>, <figure>, <footer>, <form>, <h1>, <h2>, <h3>, <h4>, <h5>, <h6>, <header>, <hgroup>, <iframe>, <ins>, <li>, <main>, <math>, <nav>, <noscript>, <ol>, <p>, <pre>, <section>, <script>, <style>, <table>, <ul>, and self-closing <hr />. `


# Span Elements

     Span elements are inline elements (including normal text) within block ele‐
     ments, for example, a span of emphasised text or a hyperlink.  A span element
     cannot contain a block element, but can contain other span elements.

##   Emphasis

     There are two different styles of emphasis: strong, usually rendered as bold;
     and emphasis, usually rendered as italics.  This is confusing, so sometimes the
     former is referred to as a “double-emphasis” while the latter is a
     “single-emphasis”.

     Text surrounded by a single asterisk (“*”) or underscore (“_”), the single-em‐
     phasis variant, is traditionally rendered with italics.

           *Captain Picard*
           _Captain Picard_

     Text surrounded by a double asterisk (“**”) or underscore (“__”), the double-
     emphasis variant, is traditionally rendered as bold.

           **Jean-Luc Picard**
           __Jean-Luc Picard__

     Emphasis may occur within the middle of a word:

           En*ter*prise

     In order to produce a literal asterisk (“*”) or underscore (“_”) simply sur‐
     round the character by white space.

           The ship * USS Enterprise * will not be emphasized

     Two additional types of double-emphasis are the strike-through and highlight.
     These are produced by pairs of tilde and equal characters, respectively:

           ~~Kirk~~Picard is the best ==captain==.

     The highlight variant may be enabled in lowdown(1) with highlight parsing en‐
     abled.  It's disabled by default because if used at the beginning of a line it
     may be erroneously interpreted as a section.

##   Links

     There are two types of links: inline and reference.  In both cases, the linked
     text is denoted by square brackets (“[]”).  An inline link uses parentheses
     (“()”) containing the URL immediately following the linked text in square
     brackets to invoke the link.

           [text to link](https://bsd.lv)

     Local references may be absolute or relative paths:

           [Picard](/Picard)

     A reference link, on the other hand, keeps the URL outside of the text — usu‐
     ally in the footnotes.  Define a reference link anywhere in a document by a ti‐
     tle in square brackets (“[]”) followed a colon (“:”) followed by the corre‐
     sponding URL or path:

           [link1]: https://www.bsd.lv/picard.jpg

     The definition must be on its own line.

     Reference the link anywhere in your text using [text to the link] and the same
     [link title], both in square brackets (“[]”) next to each other:

           Text about [Captain Picard][link1].

     References need not follow the definition: both may appear anywhere in relation
     to the other.

##   Automatic Links

     Automatic links are links to URLs or emails addresses that do not require text
     to links; rather, the full link or email address is inferred from the text.  To
     invoke an automatic link, surround the link or email address with angle brack‐
     ets (“<>”), for example:

           <https://bsd.lv/>
           <kristaps@localhost>

##   Images

     The image syntax resembles the links syntax.  The key difference is that images require an exclamation mark (“!”) before the text to link surrounded by square brackets (“[ ]”).

           ` ![Image text](imageurl.jpg) `

     Just like with links, there are both inline and reference image links.

     The inline style consists of an exclamation mark (“!”) followed by the alter‐
     nate text (which may be empty) surrounded by square brackets “([ ])” followed by
     the URL or the path in parentheses “(())”.  The parentheses may also contain
     optional dimensions (widthx[height]) starting with an equal sign or a quoted
     (single or double quotes) title in any order after the URL or path.  These di‐
     mensions are pixel sizes.

           ![Picard](https://bsd.lv/picard.jpg =250x250 'Engage!') 

     Width and height in units other than pixels may be provided as extended image
     attributes; however, these must be recognised by the output media (for example,
     HTML may recognise "rem", but LaTeX will not).  Percentage widths are always
     recognised.  These follow PHP Markdown Extra syntax:

           ![Picard](https://bsd.lv/picard.jpg){width=20%}

     The open brace must immediately following the closing parenthesis, and key-
     value pairs are separated by spaces.  Recognised values are "width" and
     "height".  If either are provided, they override set pixel dimensions.

     The reference style definition consists of an image identifier surrounded by
     square brackets “([])” followed by a colon “(:)” followed by an image URL or
     path to image and optional title attribute in double quotation marks.

            [image1]: https://bsd.lv/picard.jpg "Picture of Picard"

     Invoking the image reference is as follows:

           A picture of the captain: ![Captain Picard][image1]

     As with regular reference links, the definition and references may occur any‐
     where in relation to each other.

##   Code

     In addition to code blocks, inline code spans may be specified within para‐
     graphs or other block or span elements.  To invoke a span of code, surround the
     code using backtick quotes (“`”).

           I need your IP address to scp you Picard pics.
           Use the `ifconfig iwm0` command.

     To include literal backticks (“`”) within a code of span, surround the code us‐
     ing multiple backticks (“(``”).

           ``Here is a span of code with `backticks` inside it.``

     If you have a literal backtick at the start or end of the span of code, leave a
     space between the literal backtick and the delimiting backticks.

           `` `So many backticks.` ``

##   Footnote Reference

     Footnotes are a MMD (Multimarkdown) extension of the basic syntax.  Footnote
     references point into a block-level Footnote Definition.  They consist of the
     footnote name in square brackets, preceded by the caret.

           P'tahk[^pt], tell me who you are, or I will kill you right here!

     The footnote name is rendered as a number.  There may only be one footnote ref‐
     erence per definition.  If a footnote refers to an unknown definition, it is
     printed as-is.

## Superscripts

     Uses the caret (“^”) to start a superscript.  The superscripted material con‐
     tinues to white-space or, if starting with an open parenthesis, the close
     parenthesis.

           Though a great book, Q^2 (Q^(squared)) isn't Star Trek canon.


#   HTML Content

     While block-level HTML must begin with a recognised block-level HTML element,
     span-level HTML need only begin and end with angle brackets, and not contain a
     hyperlink.

     Thus, <p>, <Leonard Nimoy>, and <span class="foo"> are all accepted.  Even mal‐
     formed content, such as <span class="foo> is accepted, so long as it begins and
     ends with angle brackets.


# Escapes

   Automatic Escapes
     Output is automatically escaped depending upon the medium.  For example, HTML
     output will properly escape angle brackets “(<)” and ampersands “(&)” to pro‐
     duce conformant HTML.  The same goes with man(7) output in escaping leading pe‐
     riods and so forth.

   Backslash Escapes
     Backslash escapes render literal characters that would otherwise invoke a par‐
     ticular block or span element.  For example, surrounding a phrase with single
     asterisks renders it as an emphasis:

           *Captain Picard*

     However, if you want to invoke those italics as literal characters, escape
     those asterisks using backslashes (“\”).

           \*Captain Picard\*

     The following characters may be escaped to produce literal text:

           *       asterisk
           \       backslash
           `       backtick
           {       curly brace
           !       exclamation mark
           #       hash mark
           -       minus sign
           (       parentheses
           .       period
           +       plus sign
           [       square bracket
           _       underscore


# Typography

lowdown(1) and other Markdown formatters often filter certain character sequences for easier reading.  This is sometimes called "smartypants" or just "smart formatting".

In lowdown(1), the following character sequences are converted to output-specific glyphs.  The table shows whether the sequences must be on word boundaries.

           (c)      copyright
           (r)      registered
           (tm)     trademark
           (sm)     service mark
           ...      ellipsis
           . . .    ellipsis
           ---      em-dash
           --       en-dash
           1/4      one-quarter      full word boundary
           1/4th    one-quarter      full word boundary
           3/4      three-quarters   full word boundary
           3/4th    three-quarters   full word boundary
           3/4ths   three-quarters   full word boundary
           1/2      one-half         full word boundary
           "        left-double      left word boundary
           "        right-double     right word boundary
           '        left-single      left word boundary
           '        right-single     right word boundary

Word boundaries are defined by white-space (including the end of blocks, such as paragraphs, or end of file) or punctuation.  Left word boundary refers to white-space or a left parenthesis or square bracket to the left of the sequence.  Right refers to white-space or punctuation to the right.

Smart quotes are not context aware: using a left or right quote depends upon the characters surrounding the quote, not whether a quote has already been used.


# Standards

The Markdown syntax accepted by lowdown(1) conforms to John Gruber's original Markdown implementation.  Extensions to the language are specifically noted.
They include:

     CommonMark: http://commonmark.org
     Multimarkdown: http://fletcherpenney.net/multimarkdown
     GFM: https://github.github.com/gfm

