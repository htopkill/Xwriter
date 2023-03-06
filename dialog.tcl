#!/usr/bin/wish
#	 Additionnal Window/Dialog  functions


#==  CENTER THE WINDOW
proc CenterWindow { w } {
	#-- Event loop with widget hidden completely 
	# ( geometry managers needs to finish setting up the interior of the dialog ) 
	wm withdraw $w;					# Dont show window
	update idletasks;					# Determine window size
	#-- Center Now
	#puts "DebugCenterWindow: [winfo screenwidth .]x[winfo screenheight .]  window:[winfo width $w]x[winfo height $w]"
	set x [expr {([winfo screenwidth .]-[winfo width $w])/2}]
	set y [expr {([winfo screenheight .]-[winfo height $w])/2}]
	wm deiconify $w
	wm geometry  $w +$x+$y
	wm transient $w .
}


#===  FORCE SIZE of "Open File" dialog if window manager do not keep size
# Source: https://core.tcl-lang.org/tk/file?name=library/choosedir.tcl&ci=tip
proc ForceWindowSize { {count 0} } {
   if { $count > 10 } { return };   # probably not linux / timeout
   if { ! [info exists ::tk::dialog::file::__tk_filedialog] } {
      after 100 ::uiutils::ForceWindowSize [incr count]; return
   }
   #puts "DebugOpenFile: [wm attributes .__tk_filedialog] / [winfo class .__tk_filedialog]"
   #-- Display a window with a ratio from screen size
   set NewWidth [expr round([winfo screenwidth .]*1.8/3)]
   set NewHeight [expr round([winfo screenheight .]*2.5/3)]
   wm attributes .__tk_filedialog -type dialog
   wm minsize  .__tk_filedialog $NewWidth $NewHeight
}


#=====    LOGIN/PASSWORD  DIALOG
#--  Usage for login
#set password ""
#while {$password != "secret"} {
#    set userpass [dialog_password .login]
#    set password [lindex $userpass 1]
#}
# .t insert end "[lindex $userpass 0] logged in\n"
#--  Usage for password only
# .t insert end "[dialog_password .password]"

proc dialog_password {w {title "Access"}} {
	toplevel $w -borderwidth 10
	wm title $w $title
	if { $w eq ".login" } {
		label  $w.u -text " User name  "
		entry  $w.user -textvar _username
	}
	label  $w.p -text " Password  "
	entry  $w.pass -show * -textvar _password
	label  $w.dummy -text ""
	if { $w eq ".login" } {
		button $w.ok -text OK  -command {set _res [list $_username $_password]}
		grid   $w.u $w.user -         -sticky wns
		focus $w.user
	} else {
		ttk::button $w.ok -text OK  -command {set _res $_password }
		focus $w.pass
	}
	ttk::button $w.cancel -text Cancel -command {set _res {}}
	grid   $w.p $w.pass -         -sticky wns
	grid   $w.dummy x   x
	grid   x    $w.ok   $w.cancel -sticky news  -pady 20 -padx 10
	bind $w <Return> [list $w.ok invoke]
	bind $w <Escape> [list $w.cancel invoke]
	raise $w
	CenterWindow $w;  						# Display window in the center
	grab set $w
	vwait _res
	destroy $w
	if { $w eq ".login" } { unset ::_username }
	unset ::_password
	return $::_res
}


#====   FIND / REPLACE
proc dialog_FindReplace {w title} {
	toplevel $w -borderwidth 15
	wm title $w $title
	#-- Define items
	label  $w.u -text " Find      "
	entry  $w.find -textvar _find  -selectbackground "#DDDDDD"
	label  $w.p -text " Replace   "
	entry  $w.replace -textvar _replace  -selectbackground "#DDDDDD"
   checkbutton $w.regexpr -text "Regexp" -variable _regexp
   checkbutton $w.all -text "All"  -variable _all
	ttk::button $w.ok -text OK  -command {set _res [list $_find $_replace $_regexp $_all]}
	ttk::button $w.cancel -text Cancel -command {set _res {}}
	#--  Place everything now
	grid   $w.u $w.find - -sticky wns -pady 10
	grid   $w.p $w.replace -  -sticky wns -pady 10
	grid   $w.regexpr $w.all  -padx 20 -pady 10
	grid   x  $w.ok   $w.cancel -sticky news -pady 20 -padx 10
	#-- Set focus/cursor position/default state
	focus  $w.find
	$w.find selection range 0 end;	# Select the text
	$w.find icursor end;					# Cursor at the end of the text in entry box
	#$w.regexpr deselect;					# unselect regexp checkbutton
	#--  Define Key events and window settings
	bind $w <Return> [list $w.ok invoke]
	bind $w <Escape> [list $w.cancel invoke]
	raise $w
	CenterWindow $w;  						# Display window in the center
	grab set $w
	vwait _res
	destroy $w
	return $::_res
}


