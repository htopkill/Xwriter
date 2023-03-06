#!/usr/bin/wish
# Provide extra functions ( tool menu )
#  1. Add 2 trailing spaces to simulate new line
#	2. Remove trailing spaces
#  3. Concatene list of files ( as cat in unix )


#==  FORCE LINEBREAK  (Add 2 trailing space at End of line )
#    Exception: EmptyLine, Header,HorizRule, Table,more than 2 trailing spaces, ...
# ?? blockquote: |>{1,3} and list: {^([\t]{0,2}(?:\*|-|\+|\d+\)|\d+\.) )}

proc ForceLineBreak {} {
	set OldPosition [ .fr.t index current ]
	set Data  [split [.fr.t get 1.0 "end-1c" ] "\n"]
	.fr.t delete 1.0 end;
	foreach Row  $Data  {
		incr RowNum 1
		if { $Row ne "" && ![regexp { {2,}$} $Row ] && \
					![regexp {^(#{1,6} |\||-{3,})} $Row ] } {
			#puts "DebugParse: $RowNum  $Row"
   		.fr.t insert $RowNum.0 "$Row  \n"
		} else  { .fr.t insert $RowNum.0 "$Row\n" }
	}
	ReloadFile
	.fr.t see [.fr.t index $OldPosition ];     # scroll at Old position
	set ::status " Force newline: Done"
}

#==  REMOVE TRAILING SPACE
proc RemoveTrailingSpace {} {
	set OldPosition [ .fr.t index current ]
	set Data  [split [.fr.t get 1.0 "end-1c" ] "\n"]
	.fr.t delete 1.0 end;
	foreach Row $Data {
		#-- Remove trailing space EXCEPT empty line(2 spaces)/heading
		if { ![regexp {^ {2,}$} $Row ] &&  ![regexp {^#{1,6} } $Row ] } {
			.fr.t insert [incr RowNum 1].end "[string trimright $Row ]\n"
		} else { .fr.t insert [incr RowNum 1].end  "$Row\n" }
	}
	ReloadFile
	.fr.t see [.fr.t index $OldPosition ];     # scroll at Old position
	set ::status " Remove Spaces: Done"
}


#==  CONCATENE SEVERAL FILE IN ONE (# comment ignored)
proc ConcateneFiles { ListFiles } {
	#puts "DebugInclude: List: $ListFiles"
   foreach item [split $ListFiles "\n"] {
		#--  Check file path is not comment/empty. Append file content if exist
		if { ! [string match "#*" $item] && $item ne "" } {
      	set PathFile [GetAbsolutePath $item $::FileName]
      	#puts "DebugInclude: + <$PathFile>"
      	if { [file exists $PathFile] } { append result [fileutil::cat $PathFile ] }
		}
   }
   return $result
}

