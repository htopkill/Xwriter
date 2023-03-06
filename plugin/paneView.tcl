#!/usr/bin/wish
# Display Left Pane view for : 
#  - Bookmark, Recent File, Spell proposal

set PaneView "";         # Pane Name (Bookmark,Recent..). Do not change ("")

#===   CREATE RecentFile List
proc CreateRecentFileList {} {
	set ::PaneView "RecentFile";
	packWidget "LeftPane"
	.fr.tr heading #0 -text "Recent Files" -anchor center; # anchor w/e/center
	.fr.tr.tb.b1 configure -text "          "
	tooltip .fr.tr.tb.b1 ""
	.fr.tr.tb.b2 configure -text "   Remove  "
	tooltip .fr.tr.tb.b2 " Remove selection from list "
	.fr.tr.tb.b3 configure -text "    Clear  "
	tooltip .fr.tr.tb.b3 " Clear all the list "
   set infile [open  "$::ConfPath/recent.md" "RDONLY CREAT" ];
   set List0 [read $infile];
	set List1 [ UpdateList "init" 40 ]; # only last 40 items on the list
	#-- Add file to temporary list : remove duplicates/non-existing files
	foreach item $List0 {
			if { [file exists $item] } {
				set List1 [ UpdateList $List1 [file normalize $item] ]
			}
	}
	#--  Update left pane with list item
	foreach item $List1 {
		if { $item ne "" } {.fr.tr insert {} end -id $item -text [file tail $item] }
	}
	close $infile
}

#===   SAVE RECENT LIST
proc SaveRecentFileList {} {
	if { [.fr.tr focus] ne "" } {.fr.tr move [.fr.tr focus] {} 0}; # Move last selected to list start
	set outfile [open "$::ConfPath/recent.md" w ]
	puts $outfile [ lreverse [.fr.tr children {} ] ]
	close $outfile
}

#===   CREATE BOOKMARK LIST
proc CreateBookmarkList {} {
	set ::PaneView "Bookmark";
	packWidget "LeftPane"
	.fr.tr heading #0 -text "Bookmark" -anchor center; # anchor w/e/center
	.fr.tr.tb.b1 configure -text "   Add    "
	tooltip .fr.tr.tb.b1 " Add document to bookmark list "
	.fr.tr.tb.b2 configure -text "  Remove  "
	tooltip .fr.tr.tb.b2 " Remove selection from bookmark list "
	.fr.tr.tb.b3 configure -text "   Edit   "
	tooltip .fr.tr.tb.b3 " Edit bookmark list ( To Add a node, use { MyNode } ) "
   set infile [open  "$::ConfPath/bookmark.md" "RDONLY CREAT" ];
   set List0 [read $infile]
	#-- Insert/Define item 
		# if item not a path ("/*") then special colors (Tag BookCategory in theme.tcl)
	set LastCategory ""
	foreach item $List0 {
		#puts "DebugPaneView: $item"
		if { ! [string match "\/*" $item] } {
			#--  This is a bookmark category
			.fr.tr insert {} end -id $item -text [file tail $item] -tags "BookmarkCategory" -open 1
			set LastCategory $item
		} else {
			#--  This is an item inside a bookmark category
			#.fr.tr insert {} end -id $item -text [file tail $item]
			.fr.tr insert $LastCategory end -id $item -text [file tail $item]
		}
	}
	close $infile

}

#==  SAVE BOOKMARK LIST
proc SaveBookmarkList {} {
	set outfile [open "$::ConfPath/bookmark.md" w ]
	puts [.fr.tr item {} -values ]
	foreach parent [.fr.tr children {} ] {
		puts $outfile "{$parent}";   # Save bookmark category
		foreach item [.fr.tr children $parent ] {
			puts $outfile "{$item}";	# Save file path
		}
	}
	close $outfile
}

#===   CREATE SPELL LIST
proc CreateSpellList {} {
	set ::PaneView "Spell"
	packWidget "LeftPane";  									# Redraw layout
	.fr.tr heading #0 -text "Spell  [string toupper $::SpellLanguage]" -anchor center; # anchor w/e/center
	.fr.tr.tb.b1 configure -text " Add Dict "
	tooltip .fr.tr.tb.b1 "Add to dictionnary"
	.fr.tr.tb.b2 configure -text " Ignore "
	tooltip .fr.tr.tb.b2 "Ignore until\nnext restart"
	.fr.tr.tb.b3 configure -text "  Next  "
	tooltip .fr.tr.tb.b3 ""
}


#===   UPDATE A LIST  ( Remove duplicate, New at top)
proc UpdateList { liste item } {
	if { $liste eq "init" } { return [ string repeat "{} " $item ] }; # Init List
	set swap [lsearch $liste $item]
	if {$swap!=-1} {;										# Item already exists,clean list
		set liste [lreplace $liste $swap $swap];	# Delete old location  
		set liste [linsert $liste 0 $item];			# Insert New item to top
		return $liste
	}
	set liste [linsert $liste 0 $item]; 			# Insert new item at the top
	return [lrange $liste 0 end-1]; 					# Delete the last one
}



