#!/usr/bin/wish
#   Format shortcode for HTML export

set EnableToolbarShortCode true;   # Define if toolbar manage ShortCode

proc format_ShortCode { pattern } {
	set style "";
	set class "";
	set AddPadding false
	set AddPrewrap false
	set AddBlock false
	set pattern [string map { ; " " , " "} $pattern];  # " " as a separator
	foreach item $pattern {
		switch -glob $item {
			"serif"	{ append style "font-family: serif;" }
			"sans" - "sans-serif"  	{ append style "font-family: sans-serif;" }
			"mono" - "monospace"		{ append style "font-family: monospace;" }
			"prewrap"	{ set AddPrewrap true }
			"*.*em"	{ append style "font-size: $item;" }
			"##0x*"	{ append style "background-color: [string map {"#0x" ""} $item];" 
							set AddPadding true
						}
			"##*"		{; #  Check if color is format as ##FFFFFF
							if { [ regexp -all {[0-9A-Fa-f]{6}} $item] } {
								append style "background-color: [string map {"##" "#"} $item];"
							} else {
								append style "background-color: [string map {"##" ""} $item];"
							}
							set AddPadding true
						}
			"#0x*"	{ append style "color: [string map {"0x" ""} $item];" }
			"#*"		{; #  Check if color is format as ##FFFFFF
							if { [ regexp -all {[0-9A-Fa-f]{6}} $item] } {
								append style "color: $item;"
							} else {
								append style "color: [string map {"#" ""} $item];" }
							}
			"|*"		{ append style "border: 1px solid [string map {"|" ""} $item]; \
												border-radius: 5px; "
							set AddPadding true; set AddBlock true
						}
			"center"		{ 	append style "text-align: center; width: 100%; white-space: normal;"
								set AddBlock true
							}
			"right"		{ append style "float: right;"}
			"left"		{ append style "float: left;"}
			"block"		{ set AddBlock true }
			"<>*"			{ append style "width: [string map {"<>" ""} $item];"
								set AddBlock true
							}
			">*"			{ 	append style "margin-left: [string map {">" ""} $item];"
								set AddBlock true
							}
			"<*"			{ 	append style "float: right;margin-right: [string map {"<" ""} $item];"
								set AddBlock true
							}
			".*"			{ append class "[string map {"." ""} $item]" }
			default		{ append style "font-family: $item;" }
		}; # end switch
	};  # end foreach item


	if { $AddBlock } { append style "display: inline-block;" }

	#--  Prewrap: Works with 'center' only if it's the last item in 'style' list
	if { $AddPrewrap } { append style "white-space: pre-wrap;" }

	#--  Add minimum padding ( usefull with backgroud color/border )
	if { $AddPadding } { append style "padding-left: 10px; padding-right: 10px; " }

	#puts "DebugShort: $pattern   <$list0>   <$class>  <$style>"

	if  { $class ne "" } {  return " class='$class' style='$style'"
	} else  {  return " style='$style'" }

}
