#!/usr/bin/wish
#  Add spell checking to xwriter
#  Check from cursor position, Return position of last word that have spell suggestion

set SpellMode normal;			# ultra(less suggestion),fast or normal(more suggestions)
set SpellStart 1.0;				# last cursor position checked with spell checker
set EnableToolbarSpell true;  # Add spell activation on toolbar
set SpellIgnoreList "";			# Reset Ignore List
set SpellLanguage $::CheckSpellLanguage;  # Use language defined in config file

proc init_spell {} {
		#-- check aspell installation
		if { [ catch { exec echo test | aspell  --lang=$::CheckSpellLanguage  -a } ] } {
			tk_messageBox -message " ERROR: aspell package for language '$::CheckSpellLanguage' not installed\n" -type ok -icon error; 
			return 1
		}
		#--  Init Spell
   	HideSyntax;   								# No Spelling on markdown syntax 
		CreateSpellList;							# Show Left Pane
		set ::status " Spell: $::SpellLanguage.  Esc: Abort"
		.fr.t see [.fr.t index 1.0 ];									# Scroll at line 1 
		#set ::SpellIgnoreList ""; 			# Reset ignore list for each check
		if { $::SpellLanguage eq "en" }	{ set ::CustomDic "dict.en.pws"
		} else { set ::CustomDic "" }
		return 0
}


proc check_spell { fromPosition } {
	.fr.t tag remove search 0.0 end;							# Remove all tags 'search'
	.fr.t tag remove sel 0.0 end;								# Remove all tags 'sel'
	.fr.tr delete [.fr.tr children {}];  					# Clear left pane list
	set pos $fromPosition;										# First position to search
	set SpellText [.fr.t get -displaychars $fromPosition "end-1c"]
	set TotalNumberWords [regexp -all {\w+} $SpellText ];  # AlphaNum words
  	set SearchWord {[a-zàáâãäåæçèéêëìíîïðñòóôõöùúûüýÿ\']+}
	#puts "DebugSpell: from: $fromPosition ----\n---- Ignore:$::SpellIgnoreList\n----\n$SpellText"
	#puts "DebugSpell: [regexp -all -inline {\w+} $SpellText ]  [regexp -all -inline $SearchWord $SpellText ]"

	#-- Search the first mispelled word, highlight it, propose suggestion and return position
	for { set i 0}  { $i < $TotalNumberWords } { incr i } {
		set ::status " Line: [ expr int([.fr.t index $pos]) ]"
		#--  Search next word with only letters
		set pos [.fr.t search -regexp -nocase -count length -- $SearchWord $pos];
		set word [ .fr.t get $pos $pos+${length}c ]
		set ListTag [.fr.t tag names $pos]
		#puts "DebugSpell: pos:$pos  <$word>     Tag: $ListTag   Ignore: $::SpellIgnoreList \n"
		#puts "DebugSpell_IgnoreList  [regexp -all -nocase $word $::SpellIgnoreList]"
		#--  Search next if: less than 3 chars OR ignore list OR inside code/URL/blockHTML
		if { 	[string length $word] <= 2 ||							\
				[string match "*Code*" $ListTag] ||					\
				[string match "*URL*" $ListTag]  ||					\
				[string match "*BlockHTML*" $ListTag] ||			\
				[regexp -all -nocase $word $::SpellIgnoreList ]  \
		} {
			set pos $pos+${length}c;  		# Next position to search another word
			continue
		}
		#-- Check word with aspell 
		set aspell [ split [exec echo $word | \
			aspell --lang=$::SpellLanguage --ignore-case --sug-mode $::SpellMode \
			--home-dir=[file normalize $::ConfPath] --personal=$::CustomDic  -a ] "\n" ]
		set aspell_r [ split [lindex $aspell 1] " " ];		 # Keep only aspell result second line
		set aspell_Status [lindex $aspell_r 0];	# *=Word OK, &=Word proposal, #=KO, no proposal
		#puts "DebugSpell: aspell status: <$aspell_Status>\n  $aspell\n\n"
		#-- Format aspell proposal if suggestions has been found
		if { $aspell_Status eq "" }	{ }
		if { $aspell_Status eq "#" } { .fr.tr insert {} end -id 0  -text "No Suggestions found" }
		if { $aspell_Status eq "&" } {  ;#  Word has suggestions
			#- Get aspell suggestions
			set aspell_ReplaceWith [lrange $aspell_r 4 100];   # Return first aspell results 
			#set ::status "Spell: $aspell_ReplaceWith";# Display spell proposal on top bar entry
			set WordSplit [split $aspell_ReplaceWith ","];		# Split to grab the first proposal
			#-- Display suggestions on left pane
			for {set i 0} {$i<10} {incr i 1} {
				set suggestion [string trim [lindex $WordSplit $i] ]
				.fr.tr insert {} end -id $i  -text $suggestion
			}
		}
		#-- Highlight incorrect word (with suggestions or not) 
		#   Propose new words in EntryStatus bar. Return position
		if { $aspell_Status ne "*" } {
			.fr.t mark set insert $pos
			.fr.t tag add sel $pos $pos+${length}c;	# Select text from pos to pos+nb char
			.fr.t tag add search $pos $pos+${length}c;	# Add tag search
			.fr.t see [.fr.t index $pos ]; # Scroll at position+x lines
			return  $pos+${length}c;     # Return cursor position for next spell check
		} else {
			set pos $pos+${length}c;  					# search another word
		}
   }; #end foreach
	TreeViewClose
   tk_messageBox -message "  Speel check Done  \n"
	return "1.0"
	.fr.t see 1.0;			# Scroll at first line

}

