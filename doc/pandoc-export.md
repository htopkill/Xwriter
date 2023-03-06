
# PANDOC  - ODT/DOCX  



There are basically 3 ways to customize docx output in Pandoc:

1. Customize default elements (like headings and blockquotes) by editing the reference doc.
2. Customize other elements (like hyperlinks, or default paragraph font), by editing those styles in the reference doc.
3. Add custom 'elements' (styles) by adding them to the reference doc.


##  1.  Customize default elements

In order to style your documents, you can't just use any template. You need to generate what pandoc calls a reference template, which is the template it uses when converting text files to word processor documents

Generate a reference doc  : ` pandoc -o custom-reference.docx --print-default-data-file reference.docx ` 
It will have a bunch of content, representing common Pandoc components like headings and blockquotes. In the Styles menu, find the style you want to change and edit it to be what you'd like
You can move custom-reference.docx to ~/.pandoc/reference.docx
By default, pandoc will search reference.docx and reference.odt files in ~/.local/share/pandoc and  ~/.pandoc directory
( A  reference.odt,  reference.docx,  epub.css,  templates,  slidy, slideous, or s5 directory placed in this directory will override pandoc's normal defaults )

You can define the reference files with command  ` pandoc -s --reference-doc  ~/.pandoc/reference.docx  .... `



##  2.  Customize other elements

There are more styles than the ones that appear in the reference document text and in the "Style gallery." For example, you can customize hyperlinks (e.g. color).

Generate a reference doc. 
Click the expand button in the Styles section to show the Styles pane

Styles overflow menu
Find the style you want, then edit it.

Also:
You can click an option in the dropdown beside each style to add it to the Style gallery, for easier editing. You can add text with that style to the document itself, if you'd like to preview what it will look like in context.


##  3.  Add custom styles

If you want to introduce custom elements beyond the default ones,  you can simply add custom styles to the reference document. For example, you can create a style for highlighted text or centered text, or a style for large code blocks.


In LibreOffice, open the ` Styles and Formatting ` sidebar (View -> Styles and Formatting (F11)),
At the sidebar header,  there are 5 styles categories :  
1.  Paragraph Styles.  
Pandoc markdown syntax is <div custom-style="MyStyle">text</div>
OR
::::: {custom-style="MyStyle"}
Text
:::::
2.  Character Styles.   
Pandoc markdown syntax is <span custom-style="MyStyle">text</span>
OR
 [Text]{custom-style="MyStyle"}
3.  Frame Styles,  List Styles and Tables Styles.


Click Paragraph or Character Styles at the sidebar header, then select any text in your document, then click ` New Style from Selection ` dropdown at the sidebar header and choose ` New Style `. 
Give it a name. It will be a default style, which you can now modify. Right click on it in the sidebar and choose Modify to do it. 
When you are finished, you will have to manually select all the text you want to change and select your newly created style in the sidebar
For Table, Click "Modify Table Style"
Save the document.

In the markdown file you will convert to docx, add divs and spans with the appropriate custom-style attribute whenever you want to consume it. 
Custom-style spans need character styles; divs need paragraph styles.

For example, if you have a **paragraph style** called Center and a **character style** called Highlighted text:

Normal text. <span custom-style="Highlighted text">This is highlighted</span>.
<div custom-style="Center"> Test **Center** Text 1 </div>
::::: {custom-style="Center"}
Test **Center** Text2
:::::
