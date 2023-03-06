#!/usr/bin/wish
#		- Define mouse Event

#package require tooltip;        # For hint display when mouse over button
#namespace import tooltip::*;    # Import Namespace tooltip

#--  MOUSE  SINGLE-CLICK
bind .fr.t <1> {}

#--  MOUSE MOOVE
bind .fr.t <Motion> {}

#--  DOUBLE-CLICK  ( select )
bind .fr.t <Double-Button-1>  {}

#--  WHEN SELECTION CHANGE ( Warning: also used with 'search' function )
bind .fr.t <<Selection>> {}


#=====     MOUSE EVENT FOR CODEBLOCK
.fr.t tag bind CodeBlock <Enter> {
   set pos [.fr.t index @%x,%y];    #Debug: set ::status " %x %y"
   set Tags [ .fr.t tag names $pos ];  # Return Tags for the position
   #--  Code Highlighting if inside CodeBlock
   if { [ string match "*CodeBlock*" $Tags ] } {
		set BeginBlock [lindex [ .fr.t tag prevrange syntax $pos] 0 ]
		set EndBlock [lindex [ .fr.t tag nextrange syntax $pos] 0 ]
		if { $BeginBlock ne "" && $EndBlock ne "" } {
			set CodeLanguage [string map {"`" "" " " ""} [.fr.t get $BeginBlock "$BeginBlock lineend"]  ]
			for { set i [expr int ($BeginBlock)+1] }  {$i < [expr int ($EndBlock)]} {incr i } { 
        		#puts "DebugFormat: $CodeLanguage $i: [.fr.t get $i.0 "$i.0 lineend"]"
				catch { FormatCodeBlock $CodeLanguage  $i  [.fr.t get $i.0 "$i.0 lineend"] }
			}
		}
	};   # endif  match codeblock
}
.fr.t tag bind CodeBlock <Leave> {}

#=====     MOUSE EVENT FOR TABLE
#   Toogle word wrap if Double-click on table header
.fr.t tag bind TableHeader <Double-Button-1> { event generate .fr.t <Control-w> }
.fr.t tag bind TableHeader <Enter> { set ::status "DoubleClick: Toogle line wrap" }
.fr.t tag bind TableHeader <Leave> { set ::status "" }

#=====     MOUSE EVENT FOR URL

#--  Define Action when click on URL
.fr.t tag bind URL <Button-1> { openURL %x %y };  # Open URL defined after

#--  Define Action when mouse hover URL
# Display URL on status entry
.fr.t tag bind URL <Enter> {
	if { [ focus ] ne ".fr.t" } { return };   # Do Nothing if not if text widget
	.fr.t configure -cursor hand1
	set pos [.fr.t index @%x,%y];   # ForDebug:  set ::status " %x %y"
   set TextTag [.fr.t tag nextrange URLpath  $pos  "$pos lineend"]
   if { $TextTag ne "" } {
		set Text [string map { "https://" "↳" "http://" "↳" } [eval .fr.t get $TextTag] ]
		set ::status "$Text"
	}
}

#--  Define Action when mouse no more on URL
.fr.t tag bind URL <Leave> {
	if { [ focus ] ne ".fr.t" } { return };   # Do Nothing if not in text widget
	.fr.t configure -cursor xterm; set ::status ""
}



#=====     MOUSE EVENT FOR IMAGE

#--  Define tootip message when mouse hover error icon
#tooltip .fr.t -tag TagImageError "To enable http image, Menu > ▣ > Display Web Image"

#-- Define Action when mouse hover image
#   TagImage set in plugin/image.tcl
.fr.t tag bind TagImage <Enter> {
	if { [ focus ] ne ".fr.t" } { return };   # Do Nothing if not in text widget
	.fr.t configure -cursor hand1
}

#-- Define Action when mouse exit image
.fr.t tag bind TagImage <Leave> {
	if { [ focus ] ne ".fr.t" } { return };   # Do Nothing if not in text widget
	.fr.t configure -cursor xterm;
}

#-- Define Action when click on image
.fr.t tag bind TagImage <Button-1> {
	if { [ focus ] ne ".fr.t" } { return };   # Do Nothing if not in text widget
  	set pos [.fr.t index @%x,%y];   # ForDebug:  set ::status " %x %y"
  	set TextTag [.fr.t tag prevrange syntax  $pos  "$pos linestart"]
  	#if { $TextTag ne "" } { set ::status " [eval .fr.t get $TextTag]"}
}

#-- Define Action when hover on "Error image"
.fr.t tag bind TagImageError <Enter> {
	if { [ focus ] ne ".fr.t" } { return };   # Do Nothing if not in text widget
	#tk_messageBox -message "\n Image with http link are not downloaded by default  \n Enable with 'Toolbar > ▣ > Display Web Image' \n\n  Note: Image are stored in ~/.cache/xwriter" -type ok -icon info;
	set ::status " GoTo Menu ▣: Display Web Image"
}


#-- Define Action when mouse exit "Error image"
.fr.t tag bind TagImageError <Leave> {
	if { [ focus ] ne ".fr.t" } { return };   # Do Nothing if not in text widget
  	set ::status ""
}


#===    ACTION WHEN CLICK ON URL

proc openURL { xpos ypos } {
	set url ""; set urlPath "";
   #-- Get/Format URL
   set pos [.fr.t index @$xpos,$ypos]
   set range [.fr.t tag prevrange URL  $pos  [.fr.t index "$pos linestart"] ]
	set range2 [.fr.t tag nextrange URLpath  $pos [.fr.t index "$pos lineend"] ]
   if { $range ne "" } {set url [eval .fr.t get $range]} ;   # Get Text with tag "URL"
	if { $range2 ne ""} {set urlPath [ eval .fr.t get $range2 ]}; # Get Text with tag "URLpath"
   #puts "\nDebugClick1: Name: $url  Path: $urlPath"
  	#puts "DebugClick1: Pos:$pos  [.fr.t index "$pos linestart"]  [.fr.t index "$pos lineend"] "
	#-- URL is an header link with ID as "#xxx".  
	if { [ string match "#*" "$urlPath" ] } {
		catch { CreateTOC "" }; # Update/load TOC to generate header ID
		foreach {key value index} [.fr.t dump -mark 1.0 end] {
      	if { [ string match "#$value" $urlPath ]} {
				#puts "DebugShortcutID: $value $index"
				.fr.t yview [.fr.t index $index ];  # View #Id at top of window
				return
			}
		}
	}
	#-- If URL is a direct link , set path 
	if { [ string match "http*://*" "$url" ]} {
		set urlPath $url
   	#puts "DebugClick2: Name: $url  Path: $urlPath  Pos:$pos [.fr.t index "$pos lineend"] "
	}
	#--  Check if document is saved before opening another document
	if { ! [ string match "*http*" "$urlPath" ] &&  [.fr.t edit modified] } {
		if { [tk_messageBox -message " You try to open another document but \n your current document is not saved. Continue ?" \
					-type yesno -icon question] eq no } { return }
	}
   #--  Open URL
	set SourcePath [file dirname $::FileName ]
	set NormalizePath [file normalize $SourcePath/./$urlPath ]
   #puts "DebugClick3: Name: $url  urlPath: $urlPath   \n\t\tSourcePath: $SourcePath \n\t\tNormalizePath: $NormalizePath "
	switch -glob "$urlPath" {
		"http*" - "www.*"	- "*.html"	{  catch { exec $::BrowserViewer $urlPath & } }
		"/*.md" - "/*.diff"	{  LoadFile  $urlPath "";  }
		"/*" 						{  catch { exec $::FileViewer  $urlPath & } }
		"*.md" - "*.diff"		{	LoadFile  "$NormalizePath" ""; }
		default				{	catch { exec $::FileViewer  "$NormalizePath" & } }
	}
	.fr.t configure -cursor xterm;   # Style cursor = xterm
}
