#!/usr/bin/env tclsh
# Edit/Preview graphiz diagram. Require graphiz package
# Usage: tclsh  diagram.tcl  <dotfile>
# Adapted from dotcanvas.tcl ( Dr. Detlef Groth Vers <210903.0823> )

package require Tk
package provide dotcanvas 0.2.0

namespace eval dotcanvas {

    variable fname ""
    variable fstatus ""
    variable _cwf
    variable w

    proc wcanvas {w file {mtime -}} {
        variable _cwf
        set checkinterval 1000 ;# modify as needed
        if {$mtime eq "-"} {
            if [info exists _cwf] {after cancel $_cwf}
            set file [file join [pwd] $file]
            [namespace current]::wcanvas $w $file [file mtime $file]
        } else {
            set newtime [file mtime $file]
            if {$newtime != $mtime} {
                [namespace current]::canvasupdate $w $file
                [namespace current]::wcanvas $w $file
            } else {set _cwf [after $checkinterval [info level 0]]}
        }
    }

    proc canvasupdate {path file} {
        variable fname
        variable fstatus
        variable w
        set w $path
        set fname $file
        if {$fname eq ""} {  $w delete all; return ; }
        [namespace current]::dot2file
    }

    proc dotcanvas {path {dotfile ""}} {
        variable fname
        set fname $dotfile
        canvas $path -background white -width 1200 -height 800 -borderwidth 10 -relief flat
        bind all <Control-s> [namespace current]::saveGraph
        [namespace current]::wcanvas $path $dotfile
        [namespace current]::canvasupdate $path $dotfile
        return $path
    }

    proc dot2file {{outfile ""}} {
        variable fname
        variable w
        variable fstatus
        if {$outfile eq ""} {  set ext tk
        } else {  set ext [string range [file extension $outfile] 1 end]
					}
        if {[catch {
             set res [exec dot -Ttk $fname]
             set c $w
             $c delete all
             eval $res
             set fstatus "File [file tail $fname] is ok   - Use <Control-s> to save the Graph"
             if {$ext ne "tk"} {
                 exec dot -T$ext $fname -o $outfile
                 set fstatus "File [file tail $outfile] saved "
             }
         }]} {
                $w configure -background salmon
                update
                after 1000
                set fstatus [regsub {.+dot:(.+)\n +while.+} $::errorInfo "\\1"]
                $w configure -background white
        }
    }

    proc saveGraph {{filename ""}} {
        variable fname
        if {$filename eq ""} {
            set types {
                {{Png Files}       {.png}         }
                {{Pdf Files}       {.pdf}         }
                {{Svg Files}       {.svg}         }
                {{Jpeg Files}       {.jpg}         }
                {{All Files}        *             }
            }
            set savefile [tk_getSaveFile -filetypes $types -initialdir [file dirname $fname] -initialfile [file rootname $fname].png]
            if {$savefile != ""} {  set filename $savefile  }
        }
        if {$filename eq ""} {  return  }
        [namespace current]::dot2file $filename
    }

};  # End Namespace


#==  MAIN 
if { $argv0 eq [info script] && [file exists [lindex $argv 0]] } {

	if { [auto_execok dot] ne "" }  {			;# graphviz/dot program installed
		source $::env(HOME)/.config/xwriter/config;  # Load user config
		#--  Set Font for dialog box ( Used with crtl-s/Save )
		foreach TkFont { TkDefaultFont TkTextFont TkTooltipFont  TkFixedFont TkIconFont  TkMenuFont \
   		TkHeadingFont TkCaptionFont TkSmallCaptionFont } \
   			{ font configure $TkFont -family [ font actual DefaultFont -family ] \
													-size [ font actual DefaultFont -size ] }
		#--  Draw Widget
		dotcanvas::dotcanvas .c [lindex $argv 0]
   	ttk::label .l -textvariable  ::dotcanvas::fstatus  -font DefaultFont
		pack .c -fill both -expand true  -padx 5 -pady 5 -ipadx 5 -ipady 5
   	pack .l -side top -fill x -expand false -padx 5 -pady 5

	} else {
   	tk_messageBox -title "Error" -icon error -message "GraphViz application not found" -type ok
	}
}

