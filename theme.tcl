#   SAVE and RESTART  to apply change

#  spacing1 :  Extra space to leave above a line
#  spacing2 :  If text line wraps, space to leave between the display lines that make up the text line
#  spacing3 :  Extra space to leave below the line
#  lmargin1 :  Left-margin for the first wrapped line
#  lmargin2 :  Left-margin except first wrapped line
#  relief values : flat, solid, raised, sunken, ridge, groove

#===   THEME  DEFAULT
proc SetTheme_Default {} {
  	.fr.t configure					-font TextFont   -foreground #000000   -background #FEFEFE
	.fr configure					-bg  "#FEFEFE";		# Background color if view = portrait
	.fr.t tag configure sel			-background "#FFEFD5";  		# Selection
	.fr.t tag configure search		-background  "#FFEFD5";
	.fr.t tag configure syntax		-foreground red;	# Markdown symbols
	.fr.t tag configure bold		-font TextFontBold  -foreground black
	.fr.t tag configure italics		-font TextFontItalic   -foreground black
	.fr.t tag configure BoldItalics		-font  TextFontItalicBold
	.fr.t tag configure underline		-underline true 
	.fr.t tag configure highlight		-foreground brown   -background #f7f0f2
	.fr.t tag configure monospace		-font MonospaceFont -foreground black
	.fr.t tag configure BigFont		-font TextFontBig
	.fr.t tag configure BigFontBold	-font TextFontBigBold
	.fr.t tag configure overstrike		-overstrike true
	.fr.t tag configure left				-justify left
	.fr.t tag configure center			-justify center
	.fr.t tag configure right			-justify right
	.fr.t tag configure superscript		-offset 11  -font TextFontSmall
	.fr.t tag configure subscript		-offset -9 -font TextFontSmall
	.fr.t tag configure foonote		-offset 11  -font TextFontSmall  -foreground "#1168cc"
	.fr.t tag configure heading1	-foreground brown -spacing3 0.2c -font FontHeading1
	.fr.t tag configure heading2	-foreground "#4e9a06" -spacing3 0.2c -font FontHeading2
	.fr.t tag configure heading3	-foreground black -underline 1 -spacing3 0.2c  -font FontHeading3
	.fr.t tag configure heading4	-foreground black  -spacing3 0.2c -font FontHeading4
	.fr.t tag configure heading5	-foreground black  -underline 1 -spacing3 0.2c -font FontHeading5
	.fr.t tag configure heading6	-foreground black -spacing3 0.2c -font FontHeading6
	.fr.t tag configure title			-justify center -foreground brown -font TextFontTitle
	.fr.t tag configure indent1		-lmargin2 [expr 1*$::TabWidth]
	.fr.t tag configure indent2		-lmargin2 [expr 2*$::TabWidth]
	.fr.t tag configure indent3		-lmargin2 [expr 3*$::TabWidth]
	.fr.t tag configure listBullet	-foreground black  -font TextFontBold
	.fr.t tag configure list0			-lmargin2 [expr 0*$::TabWidth+2*$::SpaceWidth]  -spacing1 [expr 2*$::LineHeight] ;  # 0 Tabs
	.fr.t tag configure list1			-lmargin2 [expr 1*$::TabWidth+2*$::SpaceWidth]  -spacing1 [expr 2*$::LineHeight];  # 1 Tabs
	.fr.t tag configure list2			-lmargin2 [expr 2*$::TabWidth+2*$::SpaceWidth]  -spacing1 [expr 2*$::LineHeight];  # 2 Tabs
	.fr.t tag configure list3			-lmargin2 [expr 3*$::TabWidth+2*$::SpaceWidth]  -spacing1 [expr 2*$::LineHeight];  # 3 Tabs
	.fr.t tag configure listNum0		-lmargin2 [expr 0*$::TabWidth+2*$::SpaceWidth]  -spacing1 [expr 2*$::LineHeight];  # 0 Tabs
	.fr.t tag configure listNum1		-lmargin2 [expr 1*$::TabWidth+2*$::SpaceWidth]  -spacing1 [expr 2*$::LineHeight];  # 1 Tabs
	.fr.t tag configure listNum2		-lmargin2 [expr 2*$::TabWidth+2*$::SpaceWidth]  -spacing1 [expr 2*$::LineHeight] ;  # 2 Tabs
	.fr.t tag configure listNum3		-lmargin2 [expr 3*$::TabWidth+2*$::SpaceWidth]  -spacing1 [expr 2*$::LineHeight] ;  # 3 Tabs
	.fr.t tag configure URL				-foreground  "#1168cc"
	.fr.t tag configure CodeInline		-foreground "#008800" -background "#f6f6f6" 
	.fr.t tag configure CodeBlock		-relief solid -borderwidth 1 -foreground black -background "#f6f6f6"  -font MonospaceFont -spacing1 0 -spacing2 0 -spacing3 0 -lmargin1 1c -lmargin2 1c
	.fr.t tag configure BlockQuote	-font TextFontItalic -foreground grey30 -lmargin1 [expr 1*$::TabWidth]  -lmargin2  [expr 1*$::TabWidth] 
	.fr.t tag configure BlockQuote2	-font TextFontItalic -foreground grey30  -lmargin1 [expr 2*$::TabWidth]   -lmargin2 [expr 2*$::TabWidth]
	.fr.t tag configure BlockHTML		-relief ridge -borderwidth 1  -background "#f4f4f4"
	.fr.t tag configure TableHeader	-relief sunken -borderwidth 1 -font MonospaceFont  -background LightSteelBlue -foreground black
	.fr.t tag configure Table			-font MonospaceFont
	.fr.t tag configure PageBreak		-foreground red  -underline 1  -justify right
	.fr.t tag configure ShortCode		-foreground grey
	.fr.t tag configure Comment		-foreground "#ff8900"
	.fr.t tag configure TrailingSpace	-bgstipple gray12  -background grey40; # gray12,25,50,75
	.fr.t tag configure DefinitionListTerm		-font TextFontItalicBold -foreground black
	.fr.t tag configure DefinitionList			-lmargin2 [expr 1*$::TabWidth]
	.fr.t tag configure TableOfContent		-font TextFontSmall 	-foreground grey90
	.fr.t tag configure ModificationAdded	-foreground green -background "#fdfef1" 
	.fr.t tag configure ModificationDeleted	-foreground brown -background "#fdfef1" 
	#.fr.t tag configure border 	-bgstipple "@$::ScriptPath/img/gray50.xbm" -foreground grey70

	#--   TREEVIEW (Left Pane.  See plugin: PaneView.tcl)
	ttk::style configure Treeview	-background white -fieldbackground white -foreground black
	.fr.tr tag configure BookmarkCategory  -font DefaultFontBold -foreground brown

	#--   CODE BLOCK  ( see below )
	SetTheme_GenericCode

	#--  TEXT WIDGET  CONFIG
  	.fr.t configure	-font TextFont	\
								-insertbackground black -highlightcolor black  \
								-spacing1 $::LineHeight   -spacing2 $::LineHeight -spacing3 0 \
								-padx 30
}


#===    THEME   DARK
proc SetTheme_Dark {} {
	SetTheme_Default ; 						# Load Default Theme before
	.fr configure 								-bg black;	# Color of background when page view = 'portrait'
	.fr.t configure								-font TextFont  -insertbackground white -highlightcolor grey40
	.fr.t configure								-foreground grey80  -background  "#101010"
	.fr.t tag configure syntax					-foreground magenta
	foreach it { sel  search }					{.fr.t tag configure $it -background "#888033" }
	.fr.t tag configure highlight				-foreground "#DD0000"   -background grey10
	foreach it { BlockQuote BlockQuote2 }	{  .fr.t tag configure $it -foreground grey60 }
	.fr.t tag configure URL						-foreground "#00BBBB"
	.fr.t tag configure foonote				-foreground "#00BBBB"
	.fr.t tag configure TableHeader			-background grey40 -foreground white;
	.fr.t tag configure TrailingSpace			-bgstipple gray12  -background grey50; # 12,25,50,75
	.fr.t tag configure title						-foreground "#B6B600"
 	.fr.t tag configure bold						-foreground white
	.fr.t tag configure italics					-foreground white
	.fr.t tag configure heading1				-foreground "#B6B600"
	.fr.t tag configure heading2				-foreground "#EB9000"
	.fr.t tag configure heading3				-foreground "#EEEEEE"
	foreach it { heading4 heading5 heading6}	{.fr.t tag configure $it -foreground white  }
 	.fr.t tag configure listBullet				-foreground "#EEEEEE"
	.fr.t tag configure CodeInline				-foreground "#00CC00" -background grey0
	.fr.t tag configure CodeBlock				-foreground grey80 -background grey0  -relief raised -borderwidth 1
	.fr.t tag configure DefinitionListTerm		-font TextFontItalicBold -foreground "#DDDDDD"
	.fr.t tag configure CodeBlock				-relief sunken -borderwidth 1
	.fr.t tag configure BlockHTML				-relief ridge -borderwidth 1 -background grey10
	.fr.t tag configure ModificationAdded	-foreground "#00CC00" -background  grey10 
	.fr.t tag configure ModificationDeleted	-foreground "#FC54FC" -background  grey10 

	#--  Theme for code 
	SetTheme_GenericCode_Dark;

	#-- Change Treeview style (Left Pane.  Cf plugin PaneView.tcl)
	ttk::style configure Treeview				-background black -fieldbackground black -foreground "#00BBBB"
	.fr.tr tag configure BookmarkCategory		-foreground grey70

}



#===  THEME   TERMINAL
proc SetTheme_Terminal {} {
	SetTheme_Dark;						# Load Dark Theme
	.fr configure -bg black;					# Color of background when page view = 'portrait'
	.fr.t configure	-foreground grey80	-background  black
	.fr.t configure -font MonospaceFont	-spacing1 0  -spacing2 0  -padx 10
}


#===   THEME   Default/Light for  CODE
#   See above 'CodeBlock'  for background color definition inside block of code 
proc SetTheme_GenericCode {} {
	.fr.t tag configure Code_Comment		-foreground brown
	.fr.t tag configure Code_Function		-foreground "#0000FF"; # blue
	.fr.t tag configure Code_Variable		-foreground "#008800"
	.fr.t tag configure Code_String			-foreground "#AA0000"
	.fr.t tag configure Code_SpecialChar		-foreground brown
	.fr.t tag configure Code_Command			-foreground "#0000CC"
	.fr.t tag configure Code_SubCommand		-foreground magenta
}

#===   THEME  DARK  for  CODE
proc SetTheme_GenericCode_Dark {} {
	.fr.t tag configure Code_Comment		-foreground "#00AAAA";  # Cyan
	.fr.t tag configure Code_Function      		-foreground "#00FFFF";  # Cyan light
	.fr.t tag configure Code_Variable		-foreground "#FC54FC";  # purple
	.fr.t tag configure Code_String			-foreground "#DDDD00";  # yellow  
	.fr.t tag configure Code_SpecialChar		-foreground "#00DD00";  # green
	.fr.t tag configure Code_Command		-foreground "#00CC00";  # green
	.fr.t tag configure Code_SubCommand		-foreground lightgreen;	# or blue #0087D7
}
