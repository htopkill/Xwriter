---
title:			Test Metadata
subtitle:		Metadata are hidden. Use Ctrl-Space to view/hide metadata
author:			author1; author2
date:			10 Dec 2022
subject:		This is the subject ( HTML, EPUB, LaTeX, ConTeXt, and docx )
description:	This is a long description (ODT, docx and pptx metadata)
keywords:		markdock, xwriter, markdown, markup
---

#  Test  Metadata  

-  On Xwriter, Metadata are hidden if the document begins with a metadata block:  Use `Control-space` to view/hide metadata

Metadata depends on the converter you have installed :
	1.  If you have installed **pandoc** converter, you cant put YAML metadata block anywhere in the document ( ⚠  If you use horizontal rule and pandoc, be sure to **let a blank line before/after the horizontal rule** if it's not a metadata block )
	2.  If you NOT installed pandoc and use **lowdown** converter, put YAML metadata block always at the first line of the document


##   With PANDOC converter

**IMPORTANT**:
1.  Style to display metadata in HTML is defined with ' Toolbar > ▣ > Edit HTML styles > section METADATA '
2.  If you display Metadata in HTML, the first Header H1 is the Metadata ' title '
3.  Display Metadata in HTML is only supported with pandoc, not lowdown

Note :
metadata 'subtitle' is used in pandoc for  ( HTML, EPUB, LaTeX, ConTeXt, and docx )
metadate 'subject' is used in pandoc for   ODT, PDF, docx, EPUB, and pptx metadata )

Pandoc  supports 3 metadata definition :

### Pandoc title_block format
% title
% author(s) (separated by semicolons)
% date

### Pandoc Multimarkdown format
Title:    Markdock metadata Test
Author:   myself of course
Date:      2022-11-02
Summary: This is a test for Metadata.
Description: The metadata block begins on the document's first line and continues until the first blank line.  It consists of one or more key-value pairs, with keys and values separated by a colon, and pairs separated by a newline.


###  Pandoc YAML Block
```
---
title:   This is The Title
subject: This is the subject/subtitle
author:  This is the author
date:    04 Nov 2022
subtitle:     Same as subject ( HTML, EPUB, LaTeX, ConTeXt, and docx )
abstract:     This is the summary  (HTML, LaTeX, ConTeXt, AsciiDoc, and docx)
description:  This is the description (ODT, docx and pptx metadata)
keywords:     markdock, xwriter, markdown, markup
....    ( Any keys/value you may need )
---

```

Pandoc add the following lines on the HTML :

```
<head>
	<title>This is the title</title>
  <meta name="author" content="This is the author" />
  <meta name="dcterms.date" content="2022-11-04" />
  <meta name="keywords" content="mardock, xwriter, markdown, markup" />
</head>
And in the body ( visible in HTML )
	<header id="title-block-header">
		<h1 class="title">This is the title</h1>
		<p class="subtitle">This is the subtitle ...</p>
		<p class="author">This is the author ...</p>
		<p class="date">04 Nov 2022</p>
	</header>
```


##  With Lowdown converter

Begin file with:

Title:    Markdock metadata Test
Author:   myself of course
Copyright:     2017 Corporate
Date:      2022-11-02
Summary: This is a test for Metadata.
Description: The metadata block begins on the document's first line and continues until the first blank line.  It consists of one or more key-value pairs, with keys and values separated by a colon, and pairs separated by a newline.
Stardate: 43917.4
Tags: markdown  markdock  metadata


Lowdown will add the following lines to the HTML
```
<head>
	<title>Markdock metadata Test</title>
	<meta name="author" content="myself of course" />
	<meta name="copyright" content="2017 Corporate" />
	<meta name="date" scheme="YYYY-MM-DD" content="2022-11-02" />
</head>
```

In the document, you can call the metadata with [%...] :

- Title :          **[%title]**
- Author :         ***[%author]***
- Copyright :  [%copyright]
- Date :    [%date]
- Summary :       [%summary]
- Description :       [%description]
- Tags :     [%tags]
- Startdate :     [%stardate]
- Image :  [%image]

##  Pseudo-Metadata

This is a hack to define pseudo-medatada in a file. Uses link-reference.
[ Metadata   ]:: ( This is an example    )
Pro : link-reference are hidden in HTML/github and most editors.
Cons : No real medatada. Will not be used when exporting to another format (HTML,PDF...)

Syntax:
` <0-3spaces>[ Link label ]:<0+spaces/tabs>[ Link destination]<0+spaces/tabs>< Link Title optionnal > `

A link reference definition consists of a link label, optionally preceded by up to three spaces of indentation, followed by a colon (:), optional spaces or tabs (including up to one line ending), a link destination, optional spaces or tabs (including up to one line ending), and an optional link title, which if it is present must be separated from the link destination by spaces or tabs. No further character may occur.

A link reference defines a label which can be used in reference links and reference-style images elsewhere in the document. Link reference definitions can come either before or after the links that use them
https://spec.commonmark.org/0.30/#link-reference-definition

[ Title             ]:: (   This is the title                       )
[ Subject       ]:: (   This is the subject                 )
[ Author        ]:: (   Author1,  Author2                )
[ Date            ]:: (   08 Nov 2022                           )
[ Keywords  ]:: (   Markdock,  Markdown         )
[ Subtitle      ]:: (   This is the subtitle for HTML, docx, EPUB, LaTeX, ConTeXt )
[ Abstact      ]:: (   This is the summary  for HTML, docx, LaTeX, ConTeXt, AsciiDoc  )
[ Description  ]:: (   This is the description for  ODT, docx and pptx metadata )


---
key1:		Test Block metadata at the end of document  ( For Pandoc )
key2:		Key2 description
key3:		Key3 description
---
