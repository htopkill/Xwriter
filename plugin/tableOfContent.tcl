#!/usr/bin/wish
#  Manage Table Of content in left pane view or inside the document


#==   REGENERATE TABLE OF CONTENT INSIDE DOCUMENT
#   Experimental
proc  Update_TableOfContent {} {
	#foreach { start end } [.fr.t tag ranges TOC] {
	#}
   #   .fr.t mark set insert "$TOCpos lineend"; # place insert cursor at TOC position
   #   CreateTOC "insert"
}


#===  CREATE  TOC/TableOfContent  
#  Mode= 'display' (view TOC on left pane) or 'insert' (insert TOC on document)
proc CreateTOC { Mode } {

	#--  Init Left Pane view to display the Table of content 
	if { $Mode eq "display" } {
		set ::PaneView "TOC"
		packWidget "LeftPane"
		.fr.tr heading #0 -text "Table of Contents" -anchor center; # anchor w/e/center
		#-- No pane menu, so Draw Empty buttons to define pane width
		if {![info exists TableContentWidth]} {set ::TableContentWidth 25}
		.fr.tr.tb.b1 configure -text ""
		.fr.tr.tb.b2 configure -text [string repeat "  " $::TableContentWidth]
		.fr.tr.tb.b3 configure -text ""
	}

	#-- Get Text Buffer with all tag values. Search Heading tag
	set TOClist ""    ;#  Init TOC list
	set Offset 1  		;#  TOC begin at heading2 unless a heading1 is found
	foreach {key value index} [.fr.t dump 1.0 end] {
		if { $key eq "tagon"} {
			#puts "DebugPaneView: key:$key  value:$value  index:$index "
			if { [ string match "heading\[1-6\]" "$value" ] } {
				set TextWithoutSymbol "[.fr.t get $index "$index lineend" ]"
				set TextWithSymbol "[.fr.t get "$index linestart" "$index lineend" ]"
				if { [ string match "heading1" "$value" ] } { set Offset 0 }
				set Indent [ expr [string first " " $TextWithSymbol] -1 -$Offset ]
				#puts "DebugTOC: $Indent: $TextWithoutSymbol [Header2Id $TextWithoutSymbol] $index"
				#-- Set anchor at header position. Used by TOC inside document
				.fr.t mark set [ Header2Id $TextWithoutSymbol] $index
				#-- Build TOC
				if { "$Mode" eq "insert" || "$Mode" eq "display"} {
					#--  Build TOC to display on left pane
					set TextWithIndent [ string repeat " " [expr 3*$Indent]]$TextWithoutSymbol
					if { ! [.fr.tr exist $index] } { .fr.tr insert {} end -id $index -text $TextWithIndent -values $TextWithSymbol }
					#-- Build TOC  to insert directly in document as [HeaderName](#HeaderID)
					lappend TOClist "[ string repeat "\t" $Indent]-  \[$TextWithoutSymbol\](#[Header2Id $TextWithoutSymbol])"
				}
			}
		}
	}

	#---  Insert the table of content in the document (Menu>ins>TableOfContent)
	if { "$Mode" eq "insert" } {
		#puts "DebugPaneView: TOClist: $TOClist"
		#.fr.t insert insert "{{" syntax "Table Of Content"  TOC  "}}" syntax
		foreach line $TOClist  {
			.fr.t insert insert "\n$line" TOC
			ParseLine [GetCurrentLine] $line
		}
		.fr.t insert insert "\n"
	}
	#if { $TOClist eq "" } { set ::status " Warning: No headings found" }



}



#===   CONVERT HEADER NAME TO HEADER ID  ( Used by procedure 'CreateTOC' after )
proc Header2Id { HeaderName } {
	set Format "hyphen"
	set HeaderName [ string trim $HeaderName ];				# Remove Leading/Trailing spaces
	#--  1st Option:  Replace with hyphens (source: gitlab)
	if { $Format eq "hyphen" } {
   	set HeaderName [string tolower $HeaderName ];		# lower case
		set HeaderName [string map { / "" } $HeaderName];	# Replace some chars
   	regsub -all {[^a-z0-9\-]} $HeaderName {-} HeaderName; # Non-word text = hyphen
   	regsub -all {\s+} $HeaderName {-} HeaderName;		# All spaces convert to hyphens.
   	regsub -all {[-]+} $HeaderName {-} HeaderName;		# More than 2 hyphens: one hyphen
   	regsub -all {[-]$} $HeaderName {} HeaderName;		# Trailing hyphen remove
   	#regsub -all {[^\w-]} $HeaderName {} HeaderName; # Non-word text except hyphen removed.
	}
   #-- ToDo: If header ID already exist, append an incrementing number (starting at 1)
   return $HeaderName
}


