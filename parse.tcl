#!/usr/bin/wish
# Parse markdown files and set tags (bold,...)
#  1. ParseBlock : Parse block of lines ( Requiring forward/backward search)
#	2. ParseLine :  Parse one line ( Generic parsing for bold,underline...)
#  3. Image parsing
#	4. ParseAll : Parse all the document with regexp (slow)
#  TIP: Use https://jex.im/regulex/ to visualize regexp

#===   PARSE  LINE  REQUIRING FORWARD/BACKWARD SEARCH
proc ParseBlock { RowNum Row ListTag} {
   set PreviousLine [expr $RowNum - 1]
	#puts "DebugParseBlock: $RowNum  Tag:$ListTag"
	switch -regex $Row {
		{^```}	{;  #----   FENCED CODE BLOCK WITH "```"
						if { ! [string match "*syntax*"  $ListTag ] } {; #Not a previous ``` already tagged
							set EndBlock [.fr.t search -- "```" $RowNum.end end]
							if { $EndBlock ne "" } { ;#-- Valid Code Block
								.fr.t tag add syntax  $RowNum.0 $RowNum.end
								.fr.t tag add CodeBlock $RowNum.0+1l  $EndBlock
								.fr.t tag add syntax "$EndBlock linestart" "$EndBlock lineend"
							}
						}
					}
		{^ {4}[^ -\+•]}	{;  #----   INDENTED CODE BLOCK WITH 4 spaces
							#set EndBlock [.fr.t search -regexp {^[ ]{0,3}\S} $RowNum.end end]; #less than 4 spaces followed by non-space char
							#puts "DebugCode $RowNum --> $EndBlock"
							#if { $EndBlock ne "" } {
							#	.fr.t tag add CodeBlock $RowNum.0  "$EndBlock-1l linestart"
							#}
					}
		{^\t*(?:\*|-|\+|•)\s+} { ; #-- LIST Unordered  with Spaces/Tabs and *,-,+
							regexp -indices {\S} $Row Range; # Position non-whitespace
							set ID [lindex $Range 0]
				   		set EndList [.fr.t search -regexp {^\s*(?:\*|-|\+|•)\s+|^\s*$|^```} $RowNum.end end]
							if { $EndList eq "" } { set EndList $RowNum.end+1c }
							#puts "-DebugList($RowNum)  list$ID  End:$EndList $Row"
							.fr.t tag add list$ID  $RowNum.0 $EndList-1c
						}
		{^\t*(\d+\)|\d+\.)\s+}	{  ;#---  LIST Ordered  0-2Tab and XX. XX)
							regexp -indices {[0-9]+\.|[0-9]+\)} $Row Range;  # Range Position Bullet
							set ID [lindex $Range 0]
							set EndList [.fr.t search -regexp {^[\t]{0,2}(\d+\)|\d+\.)\s+|^\s*$|^```} $RowNum.end end]
							if { $EndList eq "" } { set EndList $RowNum.end+1c }
							.fr.t tag add listNum$ID  $RowNum.0 $EndList-1c
						}
		{^\|\t+?}	{  ;#---  PARAGRAPH INDENT (|+Tabs+Text)
							regexp -indices {[^\|]\S} $Row Range
							set ID [lindex $Range 0]
				   		set EndBlock [.fr.t search -regexp {^\|\t+?|^\s*$|^```} $RowNum.end end]
							if { $EndBlock eq "" } { set EndBlock $RowNum.end+1c }
							.fr.t tag add indent$ID  $RowNum.0 $EndBlock-1c
						}
		{^-{3,}$}	{	; #--   HORIZONTAL RULE
							DisplayHorizontalRule  $RowNum  $Row
							#if {[.fr.t get $PreviousLine.0 $PreviousLine.end ] ne "" } {
							#	set ListTag [.fr.t tag names $PreviousLine.0]; # Get Tags
							#	if { [string match "*metadata*" $ListTag ] } {continue}; # metadata block detected
							#	.fr.t tag add heading2 $PreviousLine.0  $PreviousLine.end
							#}
						}
		{^:\s+.*?}	{	; #--   DEFINITION LIST
							.fr.t tag add DefinitionListTerm  $PreviousLine.0 $PreviousLine.end
							.fr.t tag add syntax $RowNum.0  $RowNum.1
				   		set EndBlock [.fr.t search -regexp {^\s*$} $RowNum.end end]
							.fr.t tag add DefinitionList $RowNum.2  $EndBlock
						}
		{^\|.*?-{3,}.*?\|}	{ ; #--  TABLE
									.fr.t tag add TableHeader $PreviousLine.0  $PreviousLine.end+1c
									.fr.t tag add syntax $RowNum.0  $RowNum.end+1c
									.fr.t tag add monospace $RowNum.0  $RowNum.end+1c
									set EndTable [.fr.t search -regexp {^\s*$|^```} $RowNum.end end]
									.fr.t tag add Table  $RowNum.0 $EndTable-1c
								}
		default    { return 1;  # Continue Block Parsing  }
	};  # end switch
	return 0;  # Stop Block Parsing
}


#====     PARSE A LINE IN MARKDOWN
proc ParseLine { RowNum Row } {
	if { $Row eq "" } { return };  # Nothing to do if empty line

	#--  Inside Code Block: Code Highlighting / Stop Line Parsing
	set ListTag [.fr.t tag names $RowNum.0]; # Get Tags
	regexp -lineanchor {^(```)(.*?)$} $Row s0 s1 ::CodeLanguage; # set language
	if { [string match "*CodeBlock*"  $ListTag ] } {
		#-- Uncomment for Code highlight when loading file
		#FormatCodeBlock [string trim $::CodeLanguage]  $RowNum  $Row
		return
	}

	#--  Replace list beginning with '*' with '•'
	if { [regsub -all -line {^(\s*)(?:\*)(\s+.*?)} $Row {\1•\2} Row] } {
		.fr.t replace $RowNum.0 "$RowNum.0 lineend"  $Row
	}

	#--   PARSE  BLOCK
	set C 0;  # Continue Block Parsing if C=1
	#--  Parse lines requiring forward/backward search
	if [ ParseBlock $RowNum $Row $ListTag] { set C 1 }
	#puts "DebugParse($RowNum-$C)  $Row"

	#--  Continue Block Parsing   (syntax)(Text To Tag)(syntax)
	# \S \s (no)whitespace \y wordBoundary .*? .+? :AnyThing with 0/1+ char until next match  \1 Repeat group1(First ())
	if $C { set C [ TagReg title {^(#\s+)(.*?)  $} $Row $RowNum ] }
	if $C { set C [ TagReg heading1 {^(#\s+)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg heading2 {^(##\s+)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg heading3 {^(###\s+)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg heading4 {^(####\s+)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg heading5 {^(#####\s+)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg heading6 {^(######\s+)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg BlockQuote2 {^(\s*>>\s*)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg BlockQuote {^(\s*>\s*)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg fulljustify {^(::\s+)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg center {^(:::\s+)([^\{].*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg center {(<center>)(.+?)(</center>)} $Row $RowNum ] }
	if $C { set C [ TagReg right {^(::::\s+)(.*?)$} $Row $RowNum ] }
	if $C { set C [ TagReg PageBreak {^(\{\{)(pagebreak|PageBreak)(\}\})$} $Row $RowNum ] }
	#if $C { set C [ TagReg indent1 {^()(\|\t[^\t]*?)()$} $Row $RowNum ] }
	#if $C { set C [ TagReg indent2 {^()(\|\t\t[^\t]*?)()$} $Row $RowNum ] }
	#if $C { set C [ TagReg indent3 {^()(\|\t\t\t.*?)()$} $Row $RowNum ] }
	if $C { set C [ TagReg TableOfContent {^(\[ TOC \]: \#\s+\()(.*?)(\))$}	$Row $RowNum ] }

	#--  Parse Line
	TagReg listBullet	   {^()\s*(\*|-|\+|•)\s+()} $Row $RowNum
	TagReg listBullet	   {^()\s*(\d+\)|\d+\.)\s+()} $Row  $RowNum
	TagReg ShortCode		{(?:')({)([^\\]*?)(})}	$Row $RowNum;  # End of shortcode block
	TagRegS TrailingSpace { {2,}$}	$Row $RowNum; # At least 2 trailing spaces
	TagReg foonote			{(\[\^)(.+?)(\])}		$Row $RowNum
	#TagRegS TaskDone		{\[[xX]\]}	$Row $RowNum
	#TagReg linkref		{^\s*\[(.+?)\]:\s+(\S+)}	$Row $RowNum
	TagReg italics       {(\y_)((?=\S)[^_]*?[^\\])(_)(?=( |$))} $Row $RowNum;
	TagReg italics       {(\*)((?=\S)[^\*]*?[^\\])(\*)(?=( |$))} $Row $RowNum;
	TagReg italics			{(<i>)(.*?)(</i>)}			$Row $RowNum
	TagReg bold				{(\*\*)((?=\S).*?\S)(\*\*)}	$Row $RowNum
	TagReg bold				{(<b>)(.*?)(</b>)}			$Row $RowNum
	TagReg bold				{(___)((?=\S).*?\S)(___)}	$Row $RowNum;  # For Bold Underline
	TagReg BoldItalics	{(\*\*\*)((?=\S).*?\S)(\*\*\*)}	$Row $RowNum
	TagReg underline		{(__)((?=\S).*?\S)(__)}		$Row $RowNum
	TagReg underline		{(<u>)(.*?)(</u>)}			$Row $RowNum
	TagReg overstrike    {(~~)((?=\S).*?\S)(~~)}  	$Row $RowNum
	TagReg highlight     {(<mark>)(.*?)(</mark>)}	$Row $RowNum
	TagReg superscript	{(<sup>)(.*?)(</sup>)}		$Row $RowNum;
	TagReg superscript	{(\^)(.*?)(\^)}		$Row $RowNum;
	TagReg subscript		{(<sub>)(.*?)(</sub>)}		$Row $RowNum;
	TagReg BigFont			{(\+\+)((?=\S).*?\S)(\+\+)}			$Row  $RowNum
	TagReg URL				{(\[)([^\[\]]+?)(\]\(.+?\))}	$Row $RowNum; # [Name](Pathfile..)
	TagReg URL				{(\[\]\()(.+?)(\))}			$Row $RowNum; # [](http or file)
	TagReg URL				{(<)(http.+?[^\\])(>)}		$Row $RowNum; # <http..>
	TagRegS URL			   {(www|http:|https:)+[^\s]+[\w]} $Row $RowNum; # http..
	TagReg  Comment		{(<!)(--.*?--)(>)}			$Row $RowNum
	TagReg  BlockHTML		{(<kbd>)(.*?)(</kbd>)}		$Row $RowNum
	TagReg  EscapeChar	{(\\)([`_':"~=<>#\!\{\}\-\*\+\|\^\[\]\(\)\\])()}	$Row $RowNum
	TagReg CodeInline {(`)((?!\{)[^`]*?[^\\`])(`)(?!\{)} $Row $RowNum;  	#  Regexp CodeInline

	#--  Parse Image : MUST BE DONE LAST ( Introduce offset in text position )
	DisplayImage  $RowNum  $Row;   								# Display/Tag  Image

};   # End ParseLine


#===    PARSE ALL THE DOCUMENT ( vs line-by-line before )
proc ParseAll { RowNum  Text } {
		#  Empty Line : ^\s*$
		#TagReg BlockHTML	{^()(<div[^\\]*?>.*?</div>\n)()}	$Text $RowNum
		#TagReg DefinitionList {^(:\s+?)(.*?)()\n\n}	$Text $RowNum
		#--  Parse Metadata just for the first 20 lines 
		TagReg metadata {^(---)(\n.*?:.*?)(---)$} [.fr.t get 1.0 30.0] $RowNum
}


#===  GENERIC REGEX TO TAG TEXT  ( Pattern = <syntax>Text<syntax> )
#   For shortcode, the pattern is reverse : <Text>syntax<Text>
proc TagReg { tag pattern Text RowNum } {
	set RegIndice [regexp -indices -all -inline -lineanchor $pattern $Text ]
	if { $RegIndice eq "" } { return 1 }
	#if { $RegIndice ne "" } { puts "DEBUGtag ($RowNum)  $tag $pattern  $RegIndice\n"}
	#if { $tag eq "bold" } { puts "DEBUGtag ($RowNum)  $tag $pattern  $RegIndice\n"}
	set ReverseTag 0
	if { $tag eq "ShortCode" || $tag eq "Comment" } { set ReverseTag 1 }
	foreach elt  $RegIndice {
     	lassign [split $elt " "] x0 x1
		set start $RowNum.0+${x0}c
		set end  $RowNum.0+${x1}c+1c
		incr i 1;
		#-- TEST WHOLE TEXT  ( i=1,5.. / group0 )
		if { ! [expr ($i+3)%4] } { set InsideCode [InsideCode $RowNum $x0 $x1] }
		#--  TAG  SYNTAX ( i=2,4.. / group1 )
		if { ! $InsideCode && ! [expr $i%2] && $x1>=$x0 }	{
			if { ! $ReverseTag } { .fr.t tag add syntax $start $end
			} else  { .fr.t tag add $tag $start $end }
		}
		#--  TAG  TEXT  ( i=3,7.. / group2 )
		if { ! $InsideCode && ! [expr ($i+1)%4] && $x1>=$x0 } {
			if { $tag eq "CodeInline" } { RemoveAllTag $start $end }
			if { ! $ReverseTag } { .fr.t tag add $tag $start  $end
			} else { .fr.t tag add syntax $start $end }
		}
		#--   TAG URL PATH NAME
		if { ! $InsideCode && $tag eq "URL" && ! [expr $i%4] && $x1>=$x0 } {
			.fr.t tag add URLpath  $RowNum.0+${x0}c+2c $RowNum.0+${x1}c
		}
	}
	return 0
}

#===  GENERIC REGEX TO TAG TEXT without syntax  ( NO  <syntax> TextToTag <syntax> )
proc TagRegS { tag pattern Row RowNum } {
	set RegIndice [regexp -indices -all -inline -lineanchor $pattern $Row]
	foreach elt  $RegIndice {
     	lassign [split $elt " "] x0 x1
		if { $tag eq "CodeInline" } {
			RemoveAllTag "$RowNum.0+${x0}c" "$RowNum.0+${x1}c+1c"
		}
		.fr.t tag add $tag $RowNum.0+${x0}c $RowNum.0+${x1}c+1c
	}
}

#===  RETURN 1 IF INSIDE CodeInline, CodeBlock
proc InsideCode { RowNum  start end } {
	set ListTag1 [ .fr.t tag names $RowNum.0+${start}c ]
	set ListTag2 [ .fr.t tag names $RowNum.0+${end}c ]
	if { [string match "*Code*" $ListTag1 ] } {return 1}
	if { [string match "*Code*" $ListTag2 ] } {return 1}
	return 0
}


#===    DISPLAY/TAG  Horizontal Rule
proc DisplayHorizontalRule { RowNum Row } {
	set NextTag [string last "-" $Row]
	.fr.t tag add syntax $RowNum.0 $RowNum.$NextTag+1c
	frame .fr.t.horizRule$RowNum;
	.fr.t.horizRule$RowNum configure -background grey -height 2 -width 3000
	.fr.t window create $RowNum.$NextTag+1c -window .fr.t.horizRule$RowNum
}

#===    DISPLAY/TAG  IMAGE(S)  FOR A LINE
proc DisplayImage { RowNum Row } {
	set i 0
	set ListImage {};  # Init Image List to display
	set pattern {(!\[)(.*?)(\]\()(.+?)(\))}; # ![Name;OptionalWidth](Path)
	foreach elt  [regexp -indices -all -inline $pattern $Row] {
		incr i 1;  # Syntax(i=2,4,6,8...)  Name(i=3,9...)  Path(i=5,11..)
     	lassign [split $elt " "] x0 x1
		#puts "DebugParseImg $i. ($elt) [.fr.t get $RowNum.[lindex $elt 0] $RowNum.[lindex $elt 1]+1c ]"
		#-- Remove Tag URL ( issue when clicking with ![Name;100px](xx) )
		.fr.t tag remove URL $RowNum.$x0 $RowNum.$x1+1c
		.fr.t tag remove URLpath $RowNum.$x0 $RowNum.$x1+1c
		#--  Tag/Get Image Name, width and Path
		if { ! [expr $i%2] }	{ .fr.t tag add syntax $RowNum.$x0 $RowNum.$x1+1c }
		if { ! [expr ($i+3)%6] } {;  # Name of Image + Width
			.fr.t tag add syntax $RowNum.$x0 $RowNum.$x1+1c
			set ImageName [.fr.t get $RowNum.$x0 $RowNum.$x1+1c]
			set ImageWidth [lindex [split $ImageName ";"] 1]
			#puts "DebugParseImg1: Name:$ImageName   Width:$ImageWidth"
		}
		if { ! [expr ($i+1)%6] } {;   # Path/URL of image : Add to the list
			.fr.t tag add syntax $RowNum.$x0 $RowNum.$x1+1c
			.fr.t tag add ImagePath $RowNum.$x0 $RowNum.$x1+1c
			set ImagePath [.fr.t get $RowNum.$x0 $RowNum.$x1+1c]
			set ListImage [ linsert $ListImage 0 $ImagePath $RowNum.$x1+2c $ImageWidth ]
			#puts "DebugParseImg2:\n  Path:$ImagePath\n  ListImage:$ListImage"
		}
	};  # End foreach elt

	#==  DISPLAY IMAGE in REVERSE order  (Display image introduce an offset on position indice)
	foreach {ImagePath Pos ImageWidth} $ListImage {
		#puts "DebugParseImg3: $ImagePath  Pos:$Pos   Width:$ImageWidth"
		if { $ImagePath ne "" } { InsertImage $ImagePath $Pos $ImageWidth }
	}
	#--  Add a space at EndOfLine if line contain only the image
	#  This space is just used to justify image (center...)
	if { $ListImage ne "" && [ .fr.t get $Pos+1c $Pos+2c ] eq "\n" } {
		.fr.t insert $Pos+1c " "
	}

};  # End Display Image
