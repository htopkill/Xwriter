#!/usr/bin/wish
#  Define Keyboard Shortcut
#  Note: Shortcut for treeview are defined in plugin/treeView.tcl
#   Add 'break' to Cancel/Unbind pre-defined keypressed of the tcl text widget
#   Some example: /usr/share/tcltk/tk8.6/text.tcl

#====  MOST-USED  SHORTCUT
bind . <F10>	{ Identify_Key_Pressed; break;   # For Debug }
#-- View/Hide Markdown Symbol
bind . <Control-space>	{
	set status " View markdown symbol:  $::HideSyntax ";
	set ::HideSyntax [expr {!$::HideSyntax}];
	if { ! $::HideSyntax } { ViewSyntax } else { HideSyntax }
	break;
}

#--  Change Theme
bind .fr.t  <Control-t> {;# Warning: use "bind ." do not work (change last 2 chars)!  ) 
	switch -glob $GlobalTheme {
		"default"	{	set ::GlobalTheme "dark"; SetTheme_Dark;
							set status " Theme: dark"; SetTabWidth "TextFont"
						}
		"dark"		{ set ::GlobalTheme "terminal"; SetTheme_Terminal;
							set status " Theme: terminal"; SetTabWidth "MonospaceFont"
						}
		"terminal"	{ set ::GlobalTheme "default"; SetTheme_Default;
							set status " Theme: default"; SetTabWidth "TextFont"
						}
		default		{  }
	}
	#-- Save theme in user config file: require executable 'sed'
	catch {exec sed -i "s/.*GlobalTheme.*/set GlobalTheme\t\t$::GlobalTheme; # Do not change. Overriden by app/g"  [file normalize $::ConfFile]}
	break;
}


#====  SHORTCUT ESSENTIAL
bind .fr.t <Control-Tab> {
	.fr.t insert "insert linestart" "|\t";   # Indent Paragraph
	#.fr.t insert insert "   " ;  # Insert 3 spaces 
	break;
}
bind . <Control-Up>	{ tk::TextSetCursor .fr.t [tk::TextScrollPages .fr.t -1]; break }
bind . <Control-Down>	{ tk::TextSetCursor .fr.t [tk::TextScrollPages .fr.t 1]; break }
bind . <Alt-space>	{ tk::TextSetCursor .fr.t [tk::TextScrollPages .fr.t 1]; break }
bind . <Home>			{ .fr.t see [.fr.t index 0.0 ] }
bind . <End>			{ .fr.t see [.fr.t index end ] }
bind . <Control-A>	{ .fr.t tag add sel 1.0 end }
bind . <Control-q>	{
	if { [.fr.t edit modified] } {
		if { [tk_messageBox -message "Document not saved. Quit ? \n" -type yesno -icon question] eq yes } {exit}
	} else { exit }
}
bind . <Control-s>	{
	if { $::FileName eq "$::ScriptPath/help.md" } {
		tk_messageBox -message "  This file is Read-Only   \n" -type ok -icon error; return
	}
	SaveFile $FileName ; break;
}
bind . <Control-S>	{ SaveFile ""; break; }
bind .fr.t <Control-o>	{ LoadFile "" ""; break;}
bind . <Control-O>	{ CreateRecentFileList; break; }
bind . <Control-r>	{ ReloadFile ; break;}
bind . <Control-P>	{ LoadFile "$::ConfPath/config" "NoBackup"; break; }
bind . <Escape>		{
	.fr.t tag remove sel 0.0 end; .fr.t tag remove search 0.0 end
	set SpellStart 1.0
	set ::status ""; .fr.tb.entry configure -background white -show ""
	.fr.t configure -cursor xterm
	bind .fr.t <y> {}; bind .fr.t <n> {};			# y/n Used by search. Reset if esc
	if { [ info exists EnableToolbarExtraView ] } { InitExtraView "Reset" }
}
bind . <Control-exclam>  { AskUser " "; break};  # Enter command on entry widget


#====  SHORTCUT  ADVANCED (goto, search...)

bind . <Control-g>  { AskUser " GoTo : "; break};
bind . <Control-f>  {
	set SearchMode [ dialog_FindReplace .dialog "" ];  # Open dialog window
	if { $SearchMode eq "" } { return };					#  Nothing to do
	lassign  $SearchMode  FindStr  ReplaceStr  ModeRegexp  ReplaceAll
	set LastSearch  [SearchStr $FindStr  $ReplaceStr  $ModeRegexp $ReplaceAll  1.0]
	#--  Interactive or automatic Find/Replace
	if { $ReplaceAll eq 0 } {
		#--  Interactive Find/Replace
		bind .fr.t <Control-n>  { set LastSearch	[SearchStr $FindStr $ReplaceStr $ModeRegexp  $ReplaceAll $LastSearch] ; break}
	} else {
		#--  Replace All occurences
		while { $::LastSearch ne 1.0 } {
			set ::LastSearch	[SearchStr $FindStr $ReplaceStr $ModeRegexp $ReplaceAll $::LastSearch]
		}
	}
	break
}
bind .fr.t <Control-n>  { break };			#  Reserved for Find/Replace
bind . <Control-w>  {
	if {$::wordWrap == "word"} {
		set ::wordWrap "none"; .fr.tb.buttonWrap config -relief flat
	} else {
		set ::wordWrap "word"; .fr.tb.buttonWrap config -relief solid
	}
   .fr.t configure -wrap $::wordWrap; set status " Line Wrap: $::wordWrap"; break
}
bind . <F1> {
	if { [ info exists EnableToolbarExtraView ] } {
		if { $::FileName ne "$::ScriptPath/help.md" } { InitExtraView "Help"
		} else { InitExtraView "Reset" }
	}
	break
}
bind .fr.t <Control-I>	{;    # Return Info about Position/Tags for text 
	if { [ .fr.t tag ranges sel ] ne "" } {
		set status " [.fr.t index sel.first] [GetTagSelection]"
	} else { set status " [.fr.t index insert] ([.fr.t count -lines 1.0 end ] lines)"}
	break;
}
bind . <Control-B>  {
			#clipboard clear
			#clipboard append "\[[file tail $::FileName]\]($::FileName)"
			CreateBookmarkList
		break;
}
bind .fr.t <Control-p>  {
	set outfile "/tmp/preview.html";   # or  "[file dirname $::FileName]/preview.html"
   ExportAsHTML $outfile
	break
}

#====  PAGE VIEW
bind . <Control-less>	{
	switch -glob $PageView {
		"portrait"	{ set ::PageView "large" ; }
		"large"		{ set ::PageView "portrait" }
		default		{ set ::PageView "large" }
	}
	set ::status " Page View : $::PageView "
	packWidget ""
   catch { exec sed -i "s/.*PageView.*/set PageView\t\t\t\t\t$::PageView; #(large,portrait)/g" [file normalize $::ConfFile] }
	break;
}

#====  FONT  (the procedure is required to get/set font change)

proc font_changed { font args } {
	set ::status " $font $args";
	set FontFamily [lindex $font 0]; set FontSize [lindex $font 1]
	set OldFontSize [font actual TextFont -size]
	#puts "DegubFont: Family: $FontFamily  NewSize: [expr $FontSize-$OldFontSize]"
	catch { font configure TextFont -family $FontFamily }
	catch { ChangeFontSize [expr $FontSize-$OldFontSize] }
	#-- Save new font settings in user config file: require executable 'sed'
	catch {exec sed -i "s/.*TextFont.*/font create TextFont\t\t-family \"$FontFamily\" -size $FontSize/g"  [file normalize $::ConfFile]}

}
bind . <F5> {
	if { [.fr.t tag ranges sel] ne "" }  { set ::status " Font choice is not for selection " };
	tk fontchooser configure -title "Select Font" -parent . \
			-font [.fr.t cget -font] -command { font_changed }
	tk fontchooser show
	#puts "\nAvailable Fonts:\n[lsort -dictionary [font families]]\n";
	break;
}
bind . <<TkFontchooserFontChanged>> { }

#===  OTHERS

bind . <Control-plus>	{  ChangeFontSize 1; break;  }
bind . <Control-minus>	{ ChangeFontSize -1 ; break; }
bind . <F2>	{
	#-- First Spell: cursor at 1.0/no text selected (spell check aborted by user )
   #   Note: Escape set also spell position at 1.0
	if { $SpellStart eq "1.0" || [.fr.t tag ranges search ] eq "" } {
		set SpellStart 1.0
		if { [ .fr.t tag ranges sel ] ne "" } { set SpellStart [.fr.t index sel.first] }
		if {[init_spell] eq 1} { set SpellStart 0}; # if Init return 1, Stop now
	}
	#--  Start next spell
	if { $SpellStart ne 0 } { set SpellStart [check_spell $SpellStart ] }
	break
}
bind . <F3>	{
	if { $::SpellLanguage ne "en" } { set SpellLanguage "en"} else {
		set SpellLanguage $::CheckSpellLanguage }
	set ::status " Spell Language: $::SpellLanguage"
	break;
}
bind . <F4>  { AskUser " French Verb to Conjugate : "; break}
bind . <Control-T>	{ CreateTOC "display"; break ; }

#====  FORMATING WORD  ( Ctrl+b=bold... )
bind .fr.t <Control-b>	{ ReplaceTag "Word" "bold" ""; break; }
bind .fr.t <Control-i>	{ ReplaceTag "Word" "italics" ""; break; }
bind .fr.t <Control-u>	{ ReplaceTag "Word" "underline" ""; break; }
bind .fr.t <Control-C>	{ InsertCodeBlock; break; }
bind .fr.t <Control-m>	{ ReplaceTag "Word" "highlight" ""; break }
bind .fr.t <Control-k>	{ ReplaceTag "Word" "superscript" ""; break; }
bind .fr.t <Control-l>	{ ReplaceTag "Word" "BigFont" ""; break; }
bind .fr.t <Control-U>	{ InitExtraView "SpecialChar"; break }
bind .fr.t <Control-dollar> {;  # Insert HTMLalias
	.fr.t insert insert "''{#red} "
	.fr.t mark set insert "insert-8c"
}

#====  FORMATING LINE  ( Ctrl+h=heading... )

bind .fr.t <Control-h>	{
  if { [ .fr.t tag ranges sel ] eq "" } { set ::status " Select a text !"; break; }
	switch -glob  [.fr.t tag name sel.first ] {
		*heading1*	{ ReplaceTag "Line" "heading2" "heading1"; set status " Heading2" }
		*heading2*	{ ReplaceTag "Line" "heading3" "heading2"; set status " Heading3" }
		*heading3*	{ ReplaceTag "Line" "heading4" "heading3"; set status " Heading4"	}
		*heading4*	{ ReplaceTag "Line" "heading5" "heading4"; set status " Heading5"	}
		*heading5*	{ ReplaceTag "Line" "heading6" "heading5"; set status " Heading6"	}
		*heading6*	{ ReplaceTag "Line" "" 			 "heading6"; set status ""	}
		default		{ ReplaceTag "Line" "heading1" ""; set status " Heading1" }
	}
	break
}
bind .fr.t <Control-j>			{
	if { [.fr.t tag ranges sel] eq "" } { set ::status " Select a text !"; break }
   switch -glob   [.fr.t tag name sel.first ] {
		*fill*      { ReplaceTag "Line" "center" "fill"; set ::status " Center" }
		#*indent1*   { ReplaceTag "Line" "indent2" "indent1"; set ::status " Paragraph Indent2" }
		#*indent2*   { ReplaceTag "Line" "indent3" "indent2"; set ::status " Paragraph Indent3"}
		#*indent3*   { ReplaceTag "Line" "center"  "indent3";set ::status " Justify Center"}
		*center*    { ReplaceTag "Line" "right"   "center"; set ::status " Justify Right"}
		*right*     { ReplaceTag "Line" ""        "right" ; set ::status ""}
		default     { ReplaceTag "Line" "fill" ""  ; set ::status " Fully-Justify"}
   }; break
}


#====  SPECIAL SHORTCUT   :  RETURN, DOUBLE-RETURN, DELETE ...

bind .fr.t <Control-Return>	{ RemoveSymbolAndTag sel.first sel.last; break;}
bind .fr.t <Return>	{
	#--  Reset Status entry each time you enter 'return'
	set ::status ""; .fr.tb.entry configure -background white -show ""
	set Text [.fr.t get "insert linestart" "insert" ]
	#--   Reformat text for markdown files
	if { [string toupper [file extension $::FileName]] eq ".MD" \
					|| [wm title . ] eq "Untitled" } {
		#--  Read Tags to know if there is something to do
		set Tags [ .fr.t tag names [.fr.t index "insert linestart"] ]
		if { [ string match "*CodeBlock*" $Tags ] } { return }; #Inside Codeblock, do nothing
		#--  Remove tags(keep markdown symbols) for the line and reformat in markdown
		catch { RemoveAllTag "insert linestart" "insert" }
		catch { ParseLine [ GetCurrentLine ] $Text }
	} else {
		#--  Syntax highlighting depending of Code Language
		FormatCodeBlock $::CodeLanguage  [ GetCurrentLine ] $Text
	}

}


#--  Double-Return   (if whithin a list/paragraph, delete/remove tags/line)
bind .fr.t <Double-Return>	{
	#puts "DebugDoubleReturn : [ .fr.t tag names [.fr.t index "insert-1c" ] ]"
	switch -glob  [ .fr.t tag names [.fr.t index "insert-1c" ] ] {
		*indent*	{ 	foreach TagI { indent1 indent2 indent3 } {
							.fr.t tag remove $TagI "insert"
						}
					}
		DefinitionList {  .fr.t tag remove DefinitionList "insert"
					}
		default {}
	}
}

bind .fr.t <Delete>	{ }

bind .fr.t <KeyPress> {}

bind .fr.t <space> {
	#--  Do stuff but only with catch to prevent possible fatal error
  	catch {
		#--  Real-time  Code highlighting if no markdown files
		if { [string toupper [file extension $::FileName]] ne ".MD" \
					&& [wm title . ] ne "Untitled" } {
			set Text [.fr.t get "insert linestart" "insert" ]
  			#puts "DebugHighlight: Syntax $::CodeLanguage [ GetCurrentLine ] $Text"
			FormatCodeBlock $::CodeLanguage  [ GetCurrentLine ] $Text
		}

	}
}

#===   IDENTIFY WHICH KEY IS PRESSED. USED FOR DEBUG
proc Identify_Key_Pressed {} {
	set ::status " Press Any Key ..."
	bind .fr.t <Key> {
		if { "%K" ne "Escape"} {set ::status " Key Pressed : %K"; break
		} else { bind .fr.t <Key> "" }
	}
}


#===   INSERT/FORMAT  CODE BLOCK
proc InsertCodeBlock {} {
	#--  Insert a code block if no text selected
	if { [.fr.t tag ranges sel] eq "" } {
		.fr.t insert insert "\n" normal "```language" "syntax" "\n\n" CodeBlock  "```" "syntax" "\n"
		.fr.t mark set insert "insert-2l linestart"
		ViewSyntax
	}
	#-- If at least one line selected ==> CodeBlock, else CodeInline
	if { [.fr.t tag ranges sel] ne "" } {
		set start [.fr.t index sel.first];  set end [.fr.t index sel.last]
		if { [ expr $end-$start ] >= 1 } {
			RemoveAllTag $start $end
			.fr.t tag add CodeBlock $start $end
			.fr.t insert $start-1l "```" "syntax"
			.fr.t insert $end "```" "syntax" "\n"
			ViewSyntax
		} else {
			ReplaceTag "Word" "CodeInline" "";
		}
	}
}
