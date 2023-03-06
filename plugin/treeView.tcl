#!/usr/bin/wish
#  Define/Init  Treeview (Left Pane). Used by plugin 'paneView'


#==  CREATE IMAGE USED AS 'CLOSE' ICON ON TREEVIEW
catch { image create photo img_close -file "$ScriptPath/img/close.xbm" }

#===  DEFINE TREEVIEW
#--  Define a temorary label to set appropriate RowHeight
label .test -text "M"  -font DefaultFont; # Created Only to set appropriate rowheight
ttk::style configure Treeview -rowheight [expr [winfo reqheight .test]+5] -font DefaultFont -movablecolumns yes
destroy .test;                         # Useless Now. Destroy it

#--  Define Heading Style and padding
ttk::style configure Heading -foreground black; # Define Heading Style
.fr.tr configure -padding {0 0 10 50}; 			# Clearance with Scrollbar/Bottom buttons

#-- Define 2 extra columns C2,C3 in addition to tree (column #0)
#.fr.tr configure -columns "C2 C3" -displaycolumns "" -show "tree headings"

#--  Define Tree Column #0 
.fr.tr column #0 -minwidth 20 -width 300 -anchor nw
.fr.tr heading #0 -text "" -anchor center  -image img_close -command { TreeViewClose }


#==  FRAME FOR 3 BUTTONS ON BOTTOM
frame .fr.tr.tb

#==  BUTTON  LEFT  
button .fr.tr.tb.b1 -bg white -relief flat \
      -command {
         if { $::PaneView eq "Bookmark" } {
  				#-- if window title =*mdz/*mdZ, File Name = archive name
   			if { [ string match "*.mdz*" [wm title . ] ] || [ string match "*.mdZ*" [wm title . ] ]} {
      			lassign [ split [wm title . ] ">" ] ArchiveName RootFileName
					set FileName [string trim $ArchiveName]
   			}
				#-- Update Treeview and Save Bookmarks
				.fr.tr insert {} 0 -id [file normalize $FileName] -text [file tail $FileName]
				SaveBookmarkList
			}
         if { $::PaneView eq "Spell" } { ; # Add word to custom dictionary
				set out [open "$::ConfPath/dict.en.pws" a+ ]
      		puts $out "[.fr.t get sel.first sel.last]";
				close $out
				set ::status " Add Dictionary: [.fr.t get sel.first sel.last]"
         	event generate .fr.t <F2>; # Continue spell check
			}
      }

#==  BUTTON  MIDDLE
button .fr.tr.tb.b2 -bg white -relief flat \
      -command {
         if { $::PaneView eq "Bookmark" } {
				.fr.tr delete [.fr.tr selection];  # Delete selected item on list
				SaveBookmarkList
			}
         if { $::PaneView eq "RecentFile" } {
				.fr.tr delete [.fr.tr selection];  # Delete selected item on list
				SaveRecentFileList
			}
         if { $::PaneView eq "Spell" } {
				set ::SpellIgnoreList "$::SpellIgnoreList[.fr.t get sel.first sel.last]|"
				set ::status " Spell Ignore: [.fr.t get sel.first sel.last]"
				event generate .fr.t <F2>; # Continue spell check
			}
}

#==  BUTTON  RIGHT
button .fr.tr.tb.b3  -bg white -relief flat \
      -command {
         if { $::PaneView eq "RecentFile" } {
				if { [tk_messageBox -message "Clear the list ?" -type yesno -icon question] eq no } { return }
				.fr.tr delete [.fr.tr children {}]
				TreeViewClose
			}
         if { $::PaneView eq "Spell" } { event generate .fr.t <F2> }
         if { $::PaneView eq "Bookmark" } {
				TreeViewClose;  # Close TreeView to save current bookmarks
				LoadFile ~/.config/xwriter/bookmark.md "NoBackup";
			}
		}

#==  EVENT: BINDING
bind .fr.tr <<TreeviewSelect>> TreeViewItemSelected;  # Item Selected
bind .fr.tr <Double-1> {;                             # Double-Click
	#--  Do nothing if bookmark AND not a file ( Double-click on Category/Node )
	if { $::PaneView eq "Bookmark" && ! [string match "\/*" [.fr.tr focus] ] } { return }
	#--  Close treeview. Do actions defined in TreeViewItemSelected
	TreeViewClose
	TreeViewItemSelected
}
bind .fr.tr <Up>  { ttk::treeview::Keynav %W up; break }
bind .fr.tr <Down>  { ttk::treeview::Keynav %W down; break }

#==  EVENT:  CLOSE TREEVIEW  ( Click on Heading / Double Click )
proc TreeViewClose {} {
	#puts "DebugTree List: [.fr.tr children {}  ]"
	#puts "DebugTree Item Selected: [.fr.tr focus] "
	if { $::PaneView eq "Bookmark" } {	SaveBookmarkList }
	if { $::PaneView eq "RecentFile" } {  SaveRecentFileList }
	if { $::PaneView eq "Spell" } {   ;# Reset Spell
		set SpellStart 1.0
		.fr.t tag remove search 0.0 end;          # Remove all tags 'search'
		.fr.t tag remove sel 0.0 end;             # Remove all tags 'sel'
		set ::status ""
	}
	packWidget "";
	set ::PaneView ""
}


#==    EVENT: ITEM IS SELECTED
proc TreeViewItemSelected {} {
      regsub -all {\{|\}} [ .fr.tr selection ] {} TextSelect
      #puts "DebugTreeSel1 : $TextSelect   View: $::PaneView   "
      #puts "DebugTreeSel2 : Id:[.fr.tr focus]  Values:[.fr.tr item [.fr.tr focus ]]"
      #puts "DebugTreeSel3 : Id:[.fr.tr focus]  Text : [.fr.tr item $TextSelect -text]"
      if { $TextSelect eq "" } { focus .fr.t; return }
		switch -- $::PaneView {
      	"TOC" 			{ .fr.t yview [.fr.t index $TextSelect ]; # View text as top of the window }
      	"RecentFile"	{ LoadFile $TextSelect "" }
      	"Bookmark" 		{;   # Open File only if valid file path
									if { [string match "\/*" $TextSelect] } {
										LoadFile $TextSelect "" }
								}
			"Spell"			{ ;#--  Delete selection and replace with selected word
									set w [.fr.tr item $TextSelect -text]; #Replace with
									.fr.t replace  sel.first  sel.last  $w
									.fr.t tag add search insert-[string length $w]c insert; # necessary to indicate a spell check is ongoing
									event generate .fr.t <F2>; # Continue spell check
								}
		}
      focus .fr.t 
}


