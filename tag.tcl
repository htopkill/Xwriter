#!/usr/bin/wish
#		- Manage Tags (add/replace/remove tags)

#==   INIT TAG PRIORITY
proc Set_TagPriority {} {
	.fr.t tag raise syntax;			# Tag 'syntax' is always higher in priority Vs other tags
	.fr.t tag raise sel; 			# Tag 'sel' is always higher in priority Vs other tags
	.fr.t tag lower italics; 		# Tag 'italics' is always lower in priority Vs other tags
	.fr.t tag lower BlockQuote2; 	# Tag 'Blockquote' is always lower in priority Vs other tags
	.fr.t tag lower BlockQuote;	# Tag 'Blockquote' is always lower in priority Vs other tags
	.fr.t tag lower BlockHTML;
}


#===  REMOVE TAGS but keep markdown symbol ( used before reformat a line )
proc RemoveAllTag { start end }  {
	set TextWithoutTag  [ .fr.t get $start $end ]
	.fr.t replace $start $end  $TextWithoutTag
	#puts "DebugTag: start:$start  End:$end  Text:$TextWithoutTag"
}

#===  REMOVE  TAGS AND MARKDOWN SYMBOLS
proc RemoveSymbolAndTag { start end } {
	if { [.fr.t tag ranges sel] eq "" }  { return }; # No selection, stop
   HideSyntax
	set TextWithoutSyntax  [ .fr.t get -displaychars -- $start $end ]
	.fr.t replace $start  $end  $TextWithoutSyntax
}


#===  GET ALL TAGS FOR THE SELECTION
proc GetTagSelection { }  {
	if { [.fr.t tag ranges sel] eq "" } { return 1 };  # No Text selected: return 1
	set ListTag [.fr.t tag names sel.first]
	set StringLength [ string length [.fr.t get sel.first sel.last] ]
	# for each char in the text selected, get the tags for this char (sel.first+$ic)
	for {set i 0} {$i < $StringLength - 1} {incr i} {
		set CharTag [.fr.t tag names [.fr.t index sel.first]+[string cat $i c]  ]
		regsub -all {sel} $CharTag {} CharTag; # Remove tag 'sel' from the tag list
		if { ! [string match "*$CharTag*"  $ListTag ] } { append ListTag " $CharTag" }
	}
	regsub -all {sel} $ListTag {} ListTag; # Remove tag 'sel' from the tag list
	if { $ListTag eq "" } { return NoTag} else { return $ListTag }
}



#===  REPLACE TAGS/MARKDOWN SYMBOL ON TEXT SELECTION
#   Used by shortcut. Example: ReplaceTag "Word" "italics" "bold"

proc ReplaceTag { TagType TagNew TagRemove }  {
	if { [ .fr.t tag ranges sel ] eq "" } { set ::status " Select a text !"; return }

   #-- If several lines selected, abort
   if { [ expr [.fr.t index sel.last]-[.fr.t index sel.first] ] > 1 } {
		tk_messageBox -message " Format multiple lines not supported\n" -type ok -icon error; return
   }

	set ListTag [.fr.t tag names sel.first];			# Return Selection Tags
	regsub -all {sel} $ListTag {} ListTag;				# Remove Tag 'sel' to the list
	#puts "DebugTag  Type: $TagType  Add: $TagNew   Remove: $TagRemove"

	#--  Remove Symbols and Tag for line
   if { $TagType eq "Line" } {
      .fr.t tag remove $TagRemove "sel.first linestart" "sel.last lineend"
		set line [.fr.t get "sel.first linestart" "sel.first lineend"]
		if { [regexp -indices {^(:{1,4}|#{1,6})(\s+)} $line s0] } {
			.fr.t delete "sel.first linestart"  "sel.first linestart+[lindex $s0 1]c"
		}
   }

	#--  Add new Tag to selection
	#if { $TagNew eq "" } { return }; 			# Stop now if No Tag to add
	if { $TagNew ne ""  && $TagType eq "Line"} {
		.fr.t tag add $TagNew "sel.first linestart" "sel.first lineend"
	}
	if { $TagNew ne "" && $TagType eq "Word"} { .fr.t tag add $TagNew sel.first sel.last }

	#--  Write new mardown symbol
	switch -glob $TagNew {
		"bold" { .fr.t insert sel.first "**" syntax ; .fr.t insert sel.last "**" syntax }
		"italics" { .fr.t insert sel.first "_" syntax;	.fr.t insert sel.last "_" syntax " " }
		"underline" { .fr.t insert sel.first "__" syntax;	.fr.t insert sel.last "__" syntax }
		"overstrike" { .fr.t insert sel.first "~~" syntax;	.fr.t insert sel.last "~~" syntax }
		"highlight" { .fr.t insert sel.first "<mark>" syntax;	.fr.t insert sel.last "</mark>" syntax; .fr.t tag remove sel 0.0 end }
		"superscript" { .fr.t insert sel.first "<sup>" syntax; .fr.t insert sel.last "</sup>" syntax }
		"subscript" { .fr.t insert sel.first "<sub>" syntax; .fr.t insert sel.last "</sub>" syntax }
		"BigFont" { .fr.t insert sel.first "++" syntax;	.fr.t insert sel.last "++" syntax }
		"BigFontBold" { .fr.t insert sel.first "++**" syntax;	.fr.t insert sel.last "**++" syntax }
      "CodeInline" { .fr.t insert sel.first "`" syntax " " CodeInline; .fr.t insert sel.last " " CodeInline "`" syntax; .fr.t tag remove sel 0.0 end}
      "heading1" { .fr.t insert "sel.first linestart" "# " syntax }
      "heading2" { .fr.t insert "sel.first linestart" "## " syntax }
      "heading3" { .fr.t insert "sel.first linestart" "### " syntax }
      "heading4" { .fr.t insert "sel.first linestart" "#### " syntax }
      "heading5" { .fr.t insert "sel.first linestart" "##### " syntax }
      "heading6" { .fr.t insert "sel.first linestart" "###### " syntax }
      #"indent1"   {.fr.t insert "sel.first linestart" "|" syntax "\t" }
      #"indent2"   {.fr.t insert "sel.first linestart" "|" syntax "\t\t" }
      #"indent3"   {.fr.t insert "sel.first linestart" "|" syntax "\t\t\t" }
      "center"   { .fr.t insert "sel.first linestart" "::: " syntax }
      "right"    { .fr.t insert "sel.first linestart" ":::: " syntax }
		"fill"	{ .fr.t insert "sel.first linestart" ":: " syntax " "}
		default    {}
	}

};  # end replace Tag proc
