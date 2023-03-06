#!/usr/bin/wish
#  Backup/Restore  a text buffer.
#  Manage ExtraView to switch between Text Buffer

set EnableToolbarExtraView true; # Define if toolbar manage Extra Views (buffer)

#===   INIT  EXTRA VIEW
proc InitExtraView { Name } {
   if { $Name eq "Reset" } {
		if { $::FileName in [list $::ScriptPath/help.md $::ConfPath/symbol.md $::ScriptPath/emoji.md ConjugateFr] } {
      	text:restore .fr.t  $::BackupText;   # Restore Text Buffer
		}
	}
   if { $Name eq "Help" || $Name eq "SpecialChar"|| $Name eq "Emoji" } {
		set ::BackupText [ text:save {.fr.t} ];   # Save Text Buffer
		if { $Name eq "Help" }        { LoadFile $::ScriptPath/help.md "NoBackup" }
		if { $Name eq "SpecialChar" } { LoadFile  $::ConfPath/symbol.md "NoBackup" }
		if { $Name eq "Emoji" } { LoadFile $::ScriptPath/emoji.md "NoBackup" }
	}
   if { $Name eq "Conjugate" } {
		#puts "DEBUG conjugate\n   [ exec french-conjugator $::ConjugateVerb]"
		set ::BackupText [ text:save {.fr.t} ];   # Save Text Buffer
		set ::FileName ConjugateFr;					# Used for 'InitExtraView Reset'
		.fr.t replace 1.0 end  "Type ESC to exit \n\n"
		.fr.t insert end [ exec french-conjugator $::ConjugateVerb  ]
	}

}


#===   SAVE TEXT BUFFER  ( Save text with all tags, mark, position... )
proc text:save {w} {
	set save "";							#  Init Buffer to save
	foreach {key value index} [$w dump -all 1.0 end-1c] {
		#puts "DebugSave: $index $key $value"
		switch $key  {
   		mark {     ;# add attributes of a mark
         			lappend save $key $value $index
                   set exec "$w mark gravity $value [$w mark gravity $value]"
                   lappend save exec $exec {}
               }
 			image  {      ;# add attributes of an image
                set exec "\$w image create $index"
                foreach k {-align -image -name -padx -pady} {
                    set v [$w image cget $index $k]
                    if {$v != ""} { append exec " $k \{$v\}" }
                }
                lappend save exec $exec {}
            }
 			window  {     ; # add attributes of a window
                lappend save $key $value $index
                set exec "$w window configure $index"
                foreach k {-align -create -padx -pady -stretch} {
                    set v [$w window cget $index $k]
                    if {$v != ""} { append exec " $k \{$v\}" }
                }
                lappend save exec $exec {}
            }
        default { lappend save $key $value $index }
		};  #end switch
	};  #end foreach

	#--   Add Filename to the buffer to avoid error when restoring
	if { $::FileName ne "" } { lappend save metadata0 $::FileName 0.0 }

	#puts "DebugBufferSave: <$::FileName>\n$save"
   return $save
}


#===   RESTORE TEXT BUFFER
proc text:restore { w save } {
	$w delete 1.0 end;											# empty the text widget
	set InsertCursor 1.0; set CurrentPosition 1.0;		# Init cursor position
	#puts "DebugBufferRestore: <$::FileName>\n $save"
	set ::FileName ""; wm title . "Untitled"
	if { $save eq "" } { return  };				# Nothing to do, buffer is empty
   foreach {key value index} $save {
		#puts "DebugRestore: $index $key $value"
        switch $key  {
            exec     { eval $value }
            image    {  set Split [split $OldText ":"];  # Get Image Zoom
								InsertImage $value $index [lindex $Split 1];
								#puts "DebugImg:$value $index $OldText  [lindex $Split 1]" 
							}
            text     { $w insert $index $value; set OldText $value}
            mark     {  if {$value == "current"} { set CurrentPosition $index }
								if {$value == "insert"} { set InsertCursor $index }
                        $w mark set $value $index  }
            tagon    { set tag($value) $index }
            tagoff   { $w tag add $value $tag($value) $index }
            window   { if { [ string match "*horizRule*" $value ] } {
                    		frame $value;
                     	$value configure -background grey -height 2 -width 3000
								}
								$w window create $index -window $value
							}
				metadata0 { ;# puts "DebugMetaData: $value"
								set ::FileName $value;
								set ::status " [file tail $value]"
								wm title . $value
							}
        } ;# end switch
    } ;# end foreach
   $w mark set insert $InsertCursor;		# Restore Insert cursor
	$w mark set current $CurrentPosition;  # Restore special mark: Current Position
	$w see [$w index $CurrentPosition ];   # Scroll to previous saved position
	.fr.t edit reset;								# Reset Undo/Redo stack
}



