#!/usr/bin/wish
#    Convert Document/URL to markdown


#==   CONVERT ANY DOCUMENT TO MARKDOWN
proc ImportDocument {} {
   if !($::PandocMissing) {
      after idle ForceWindowSize;                # Force OpenFile window size
      set FileName [ tk_getOpenFile -initialdir $::FilePath ]
      if { $FileName eq "" } { return }
		# --wrap=none: Don't wrap after default max column width=72 (pandoc --columns)
      # Get Extentions : pandoc --list-extensions=markdown
		file mkdir "$::env(HOME)/Documents/pandoc"
      eval exec pandoc \
					--wrap none \
					--extract-media "$::env(HOME)/Documents/pandoc" \
					 $::PandocOptions \
					--to gfm-raw_html  \
					$FileName -o "$::env(HOME)/Documents/pandoc/temp.md"
      LoadFile $::env(HOME)/Documents/pandoc/temp.md ""
   } else { set ::status " application Pandoc is missing " }
}


#==   IMPORT HYPERLINK
proc ImportURL { PathLink } {
   if !($::PandocMissing) {

		#--  Check URL validity
		if { [ CheckURL $PathLink ] eq 1 } {
			tk_messageBox -message " ERROR: Timeout/Header error    \n   Only 'http(s)://...' link allowed \n Retry later\n" -type ok -icon error
			return
		}
		#-- Convert Document
		set ::ImportFile /tmp/pandoc/ImportURL.md
		set ImportDir /tmp/pandoc
		file delete $::ImportFile; file mkdir $ImportDir
		#--  Start a timeout
		countdown 60;   # Init a timeout at xx seconds
      #-- Start Pandoc  (Get Extentions : pandoc --list-extensions=markdown)
		#						--wrap=none: Don't wrap after default max column width=72 (pandoc --columns)
   	eval exec pandoc \
					--wrap none \
					--extract-media $ImportDir  \
					--from html  \
					$::PandocOptions \
					--to gfm-raw_html  \
					$PathLink -o $::ImportFile &
   } else { set ::status " application Pandoc is missing " }
}


#==  CHECK  URL HEADER validity (4xx/5xx=error)
proc CheckURL { URL } {
		set status 0
      catch { set status [ exec  curl -Is --connect-timeout 8  $URL | head -n 1 ] }
		update
		if {  [string match "HTTP* 4*" $status] || [string match "HTTP* 5*" $status] || $status eq 0 } {
			#puts "Invalid URL: $URL    Status: $status"
			return 1
		}
		return 0
}

#==   TIMEOUT  COUNTER
#   Init a counter. Exit if timeout reached or pandoc output file exist
proc countdown {{cnt}} {
	.fr.tb.entry configure -background "#FFE4B5"
	#--  End of Timeout
	if { $cnt <= 0 || [file exist $::ImportFile] } {
		set ::status ""
		.fr.tb.entry configure -background white
		#set PandocPID [ exec ps -eo pid,comm | grep pandoc ]
		#catch { exec kill -9 $PandocPID }; # kill pandoc
		if { [file exist $::ImportFile] } {
			LoadFile $::ImportFile ""
		} else {
			tk_messageBox -message " Process aborted ( Timeout ) \n" -type ok -icon error
		}
		return
	} else { set ::status " Wait $cnt seconds ..." }
	#-- Continue timeout	
	incr cnt -1
	after 1000 [list countdown $cnt ]
}
