# Test HTML Alias  


**IMPORTANT** : HTML alias are applied ONLY when you export to HTML ( and PDF with your browser 'print' menu ) 
Use ' Ctrl-p ' to test this document in HTML
Use ' Ctrl-Space ' to view/hide alias

If you use often the same text formatting : 
1.  Define a 'class' in 'Menu > ▣ > Edit HTML style'
2.  Use syntax:  'Text'\{.class}

## Test Menu > INS > Alias


##  Test Escape

'Not in Red'\{#red} 

##  Test Text Pre-wrap

⚠  Alias 'prewrap' for inline works only with **lowdown** converter

' Text with alias=prewrap keep all spaces/tabs:   After 3 spaces	After 1 Tab'{prewrap}

Alias 'prewrap' for text block works with **lowdown/pandoc** converter

' Block with empty line

end of block  '{#blue prewrap} 

## Test Family

This is a  'Sans Test'{sans} now
This is a  'Serif Test'{serif} now
This is a  'Monospace Test'{mono} now
This is a  'Sans Test'{sans-serif} now
This is a  'Monospace Test'{monospace} now

## Test Font Size

This is a test 'Font Size 1.4em Text'{1.4em} now

##  Test Color

This is a test 'Foreground green'{#green} now
This is a test 'Background grey'{##gray} now
This is a test 'Border blue'{|blue} now
this is 'yellow'{##yellow |black} test with 'red'{#red} text
This is a unicode symbol in red  '☆'{#red}

##  Test Color  HexaValue  0xFFFFFF

' 0x User-defined foreground color     #0x0000FF '{#0x0000FF}
' 0x User-defined background color   ##0x999999'{##0x999999}

##  Test Color  HexaValue  FFFFFF or ffffff

' User-defined foreground color #0000ff  '{#0000ff}
' User-defined foreground color #0000FF '{#0000FF}
' User-defined background color ##add8e6 '{##add8e6}
' User-defined background color ##ADD8E6 '{##ADD8E6}

Some Color example :
'white/black'{#white ##black}  'red'{#red}  'gray'{#gray}   'grey'{#grey}  'blue'{#blue}  'green'{#green}  'silver'{#silver} 'olive'{#olive}  'teal'{#teal}  'purple'{#purple}  'orange'{#orange}
https://en.wikipedia.org/wiki/Web_colors

## Test Justification

You can use "::: Text" and ":::: Text" to justify a full line in Center/Right
But HTML alias enable to combine Left/Center/Right justification on the same line :

Combine **left** text  'with **right** justification'{right}
:::          Combine **center** and 'Right **Text** on line'{right}

Justify several lines:

' line1 center
line2 center '{center}

 '![Name](test1.jpg)'{right} 
Text1 on left, image with HTML alias 'right'
Text2 on left, image on right
Text3 on left, image on right


## Test Class

'Use .class to assign CSS class to a text (here .center)'{.center}
'Use .class to assign CSS class to a text (here .right)'{.right}

## Test Block

'background grey full width'{##silver block}
'background grey full width, center'{##silver center}
'background grey full width, right'{##silver right}
  

'border black full width'{|black block} 
'border black full width, center'{|black center}
'border black full width, right'{|black right block}

## Test Markdown inside

'Blue/0.8em with _italic and **bold** inside alias_'{#blue 0.8em}

## Test Mix

'Serif/small/white/gray/red/Right justification'{serif 0.7em #white ##gray |red right}

Mix style ' serif/white/gray/red '{serif #white ##gray |red} on the ' red/green '{#red |green} also


## Multi-lines

Line before

'	This is a multi-lines block
	Text Red, border blue
	and block '{#red |blue block}
Line after

Line before

'	This is a multi-lines block
	Text blue, border red
	and NO block '{#blue |red}
Line after

## Multi-lines Right

Line before

'	This is a multi-lines block
Text Red, background silver,
and Right justification  '{#red ##silver right}
Line after


## Empty line inside block

'	This is a multi-lines block
Text Red, background silver, 

and Right justification  '{#blue}

##  Block width/padding

'Text width 50%'{##lightgrey  |black  <>50%} 
'Text padding RIGHT 50%'{##lightgrey |black >50%} 
'Text padding RIGHT 10% / width 50%'{##lightgrey |black >10% <>50%} 
'Text padding LEFT 50%'{##lightgrey |black <50%} 
'Text padding LEFT 20% / Width 50%'{##lightgrey |black <20% <>50%} 


##  Admonition

' ⚠️ **This is a warning admonition**
 Just an example of HTML alias power. 
But if you often use admonition, just define a CSS class and call this class in the alias
'{			##FFEFD5  |black  <>50%   >10%}

## Test Justification 3 columns

'Left1
 Left2      '{|black #red left <>10%} 

'Right1
 Right2    '{|black #blue right <>10%}

'Center1 
 Center2   '{|black #green center <>74%}
