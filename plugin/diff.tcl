#   COMPARE FILES USING :
# - Linux diff command  ( Ignore spaces differences )
# - or  internal tcl procedure ( but output spaces difference )

#===    Main Proc to compare the files
proc CompareFile {} {
   set NewFile $::FileName
   after idle ForceWindowSize;                 # Force OpenFile window size
   set OldFile [ tk_getOpenFile -initialdir $::FilePath -title " Choose old file "]
   if { $NewFile ne "" && $OldFile ne "" } {
		#--  Using linux diff command ( ignore spaces )
		set DiffFile "$::env(HOME)/.cache/xwriter/[file tail $NewFile].diff"
		#--  Run diff with Option -U 1000 : display 1000 lines of context
		catch { exec diff -U 1000 -isBb $OldFile $NewFile > $DiffFile }
		LoadFile $DiffFile ""
		#--  Using Internal diff command ( not ignoring spaces )
      #filediff $OldFile $NewFile
      #set ::FileName "";  wm title . Untitled
   }
}


# Internal tcl procedure ( output spaces difference )
# Source:   https://wiki.tcl-lang.org/page/Another+diff+in+tcl
# Syntax:   filediff <OldFile> <NewFile> <cmdEqual> <cmdAdd> <cmdDel>
proc filediff {file1 file2 {cmdEqual {cmdEqual}} {cmdAdd {cmdAdd}} {cmdDel {cmdDel}}} {
        set sourcefid1 [open $file1 r]
        set sourcefid2 [open $file2 r]
			set  LineNumber 1
        set found 1
        while {![eof $sourcefid1] && ![eof $sourcefid2]} {
                set lastmark [tell $sourcefid2] ;# Position in <file2> before reading the next line
                gets $sourcefid1 line1
                gets $sourcefid2 line2

                if {$line1 eq $line2} {
                        $cmdEqual $line1
                        continue
                }

                # Lines with only whitespace are also equal
                if {[regexp -- {^\s*$} $line1] && [regexp -- {^\s*$} $line2]} {
                        $cmdEqual {}
                        continue
                }

                # From here both lines are unequal

                set state 0
                while {[regexp -- {^\s*$} $line1]} {
                        # If unequal then directly state empty lines in <file1> as deleted.
                        $cmdDel $line1
                        if {![eof $sourcefid1]} {
                                gets $sourcefid1 line1
                                if {$line1 eq $line2} {
                                        $cmdEqual $line1
                                        set state 1
                                        break
                                }
                        } else {
                                break
                        }
                }
                if {$state} {
                        continue
                }

                # Remember position in <file2> and look forward
                set mark2  [tell $sourcefid2]
                set mark2a $lastmark
                set found 0
                while {![eof $sourcefid2]} {
                        gets $sourcefid2 line2
                        if {$line1 ne $line2} {
                                set mark2a $mark2
                                set mark2 [tell $sourcefid2]
                        } else {
                                # Found a matching line. Everything up to the line before are new lines
                                seek $sourcefid2 $lastmark
                                while {[tell $sourcefid2] <= $mark2a} {
                                        gets $sourcefid2 line2
                                        $cmdAdd $line2
                                }
                                gets $sourcefid2 line2
                                $cmdEqual $line2
                                set found 1
                                break
                        }
                }
                if {!$found} {
                        # No matching line found in <file2>. Line must be deleted
                        $cmdDel $line1
                        seek $sourcefid2 $lastmark
                }
        }
        # Output the rest of <file1> as deleted
        while {![eof $sourcefid1]} {
                gets $sourcefid1 line1
                $cmdDel $line1
        }

        # Output the rest of <file2> as added
        while {![eof $sourcefid2]} {
                gets $sourcefid2 line2
                $cmdAdd $line2
        }
        close $sourcefid2
        close $sourcefid1
        return
}

proc cmdEqual {txt} {
      global n
		.fr.t insert end "   " syntax "$txt\n"
		update
}

proc cmdAdd {txt} {
		global n
		.fr.t insert end "+  $txt\n" ModificationAdded;
		update
}

proc cmdDel {txt} {
		global n
		.fr.t insert end "–  $txt\n" ModificationDeleted;
		update
}


