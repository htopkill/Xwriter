# LOAD/SAVE USER CONFIG FILE ( with a default config file as reference )
#  		Source  : https://wiki.tcl-lang.org/page/Config+File+Parser
# Name/Value as  "Name = Value  # Optional Inline comment"
# Comments as "# comment"
# Load setting with :  config:open default.cfg;  config:open  user.cfg
# Save setting with :  config:save user.cfg  default.cfg
# Each setting is an array element : $cfg_ID(name)  return value
# This process is robust and clean : 
# 	1. When loading, a corrupted user config file is non-critical
# 	2. When saving, the default config file is used as a clean 'template'
#  3. When updating default config, the user config file is updated accordingly


#==  OPEN CFG/INI FILE

proc config:open { fname } {
	global cfg
	if {[file exists $fname]} {set fp [open $fname r]} else {return 0}
	while {![eof $fp]} {
		set line [gets $fp]
		set line_pair [ split $line "#"];  # Grab name/value, remove inline comment
		set comment [lindex $line_pair 1]
		set pair [split [lindex $line_pair 0] =];  # name/value with a separator '='
   	set name [string trim [lindex $pair 0] ]
   	set value [string trim [lindex $pair 1] ]
		switch -regexp -- $line {
			"^#.*"			{; # Comment }
			"^$"				{; # Empty line }
			"^\\[.*\\]$"	{ set section [string map {"[" "" "]" ""} $name] }
			".*=.*"			{ set cfg($name) $value }
			default			{ puts "Warning: Undefined '$line' in file $fname " }
		}
		#puts "DebugCFG:  $name: $cfg($name)"
	}
	close $fp
	return 1
}


#==  SAVE CFG  FILE

proc config:save { fname default } {
	global cfg

	#--  Open config files
	set ref [open $default r];		# default config file
	set fp [open $fname w];			# new config file to write
	#--  For each line in default config file, write new value in destination file
	while {![eof $ref]} {
		set line [gets $ref]
		set line_pair [ split $line "#"];  # Grab name/value, remove inline comment
		set comment [lindex $line_pair 1]
		set pair [split [lindex $line_pair 0] =];  # name/value with a separator '='
   	set name [string trim [lindex $pair 0] ]
   	set value [string trim [lindex $pair 1] ]
		#puts "DebugCFG:  $name: $cfg($name)"
		#-- Save Key/Value/Comment in the new file
		switch -regexp $line {
			"^#.*"			{ puts $fp $line; #  Save comments  }
			"^$"				{ puts $fp $line; # Empty line }
			"^\\[.*\\]$"	{ 	puts $fp $name; #  Save section
									set section [string map {"[" "" "]" ""} $name]
								}
			".*=.*#.*"		{ puts $fp "$name = $cfg($name)\t\t\t# $comment" }
			".*=.*"			{ puts $fp "$name = $cfg($name)" }
			default			{ puts "Warning: Undefined '$line' in file $fname " }
		}; # end switch
	}
	close $fp
	close $ref
}

proc config:list { } {
	global cfg
	foreach index [array names cfg] { puts "   $index\t\t$cfg($index)" }
}

#==  DEMO
#config:open default.cfg
#config:open new.cfg
#config:save new.cfg default.cfg
#config:list
