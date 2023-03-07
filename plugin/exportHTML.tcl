#!/usr/bin/wish
#    Convert Markdock to HTML. Use export.css as style-sheet file
#    Convert line-by-line (prevent reformating in code block), then Convert all


#==  REFORMAT TEXT:  markdock syntax > pure markdown/HTML  syntax
# WARNING: use <span> (lowdown converter don't convert markdown inside <div>, <p>...)

proc Convert2Markdown { SourceFile  DestFile } {

	#==  INIT
	set TempFile [open /tmp/export.md w ];
	set CodeBlock false;								# Used to disable format inside CodeBlock

	#== GET TEXT TO EXPORT ( Selection or Entire text if no selection )
	if { [.fr.t tag ranges sel] ne "" } {
 		set Data [.fr.t get [.fr.t index sel.first] [.fr.t index sel.last] ]; # Get selection
	} else { set Data [.fr.t get 1.0 "end-1c"] }

	#==  INCLUDE FILES ( if {{include ...}} or ```include ...``` )
	set Data [ IncludeFiles $Data ]

   #--  Replace list symbol '•' with '*'
	regsub -all -line  {^(\s*)(?:•)(.*?)} $Data {\1*\2} Data

	#--  Replace ```dot with ```.dot  (ERROR with pantcl filters)
   regsub -all -lineanchor {^```dot} $Data {```.dot} Data

	#-- CONVERT markdock>markdown LINE-BY-LINE EXCEPT CODEBLOCK/CODEINLINE
	set lines [split $Data "\n"];					# Array with each line of file
	foreach line $lines {

		#--  Evaluate if inside codeblock
		if { [ regexp {(^```)(.*?)$} $line ] } {
			if { ! $CodeBlock } { set CodeBlock true } else { set CodeBlock false }
		}

		if { ! $CodeBlock } {


		   #--  Replace list beginning with TABS by spaces 
			#    ( better with pandoc parsing for list if no empty line before list )
			regsub -all -line  {^\t(\*|-|\+|•)(\s+)} $line {   \1\2} line
			regsub -all -line  {^\t\t(\*|-|\+|•)(\s+)} $line {      \1\2} line
			regsub -all -line  {^\t\t\t(\*|-|\+|•)(\s+)} $line {         \1\2} line
			regsub -all -line  {^\t(\d+\)|\d+\.)(\s+)} $line {   \1\2} line
			regsub -all -line  {^\t\t(\d+\)|\d+\.)(\s+)} $line {      \1\2} line
			regsub -all -line  {^\t\t\t(\d+\)|\d+\.)(\s+)} $line {         \1\2} line

			#--  Replace line with only  "\" or 2 spaces  with HTML break-line <br />
			regsub -all -lineanchor {^\\\s*$} $line {<br />} line
			regsub -all -lineanchor {^ {2,}$} $line {<br />} line

			#--  Replace '[' with invisible char before 'subst'
			regsub -all -lineanchor {\[} $line "\u3164" line;# Replace '[' with invisible char to prevent error with 'subst'

			#-- Generate Header for i=1-6   <hi id="HeaderID generator"> xx  </hi>
			if { !($::PandocMissing) } {
				#--  pandoc ONLY : Add a tab character \x09 (pandoc bug with header beginning with number (1.xx)
				regsub -all -lineanchor {(^#{1,6} )(.+?)$} $line \
						{<h[expr [string last "#" {\1}] +1] \
						 	id="[Header2Id {\2}]">\x09 \2</h[expr [string last "#" {\1}] +1]>} line
			} else {
				#--  NOT pandoc ONLY  ( lowdown )
				regsub -all -lineanchor {(^#{1,6} )(.+?)$} $line \
						{<h[expr [string last "#" {\1}] +1] \
						 	id="[Header2Id {\2}]">\2</h[expr [string last "#" {\1}] +1]>} line
			}
 			catch { set line [subst  -nobackslashes -novariables $line] }

			#--  Restore Invisible char with '[' after 'subst'
			regsub -all -lineanchor "\u3164" $line {[} line;  # Replace Invisible char with '['

			#--  Replace Header1 with 2 trailing spaces with H1/class=title (cf CSS )
			regsub -all -lineanchor {<h1(.*?)>(.*?)  </h1>} $line {<h1 \1 class="Title">\2</h1>} line

			#-- Other stuffs
			#regsub -all -lineanchor {([^^]`)(.+?)(`)} $line {<code>\2</code>} line
			regsub -all -lineanchor {(^::::\s+)(.*?)$} $line {<span class="right">\2</span>} line
			regsub -all -lineanchor {(^:::\s+)([^\{].*?)$} $line {<span class="center">\2</span>} line
			regsub -all -lineanchor {(^::\s+)(.*?)$} $line {<span class="fulljustify">\2</span>} line

			#--   NOT IN CODE INLINE
			if { ! [ regexp {(`)(.+?)(`)} $line ] } {;   # Not in  Code Inline

				#--  Replace '[' with invisible char before 'subst'
				regsub -all -lineanchor {\[} $line "\u3164" line

				#--  Define ReferencePath for image
				if { $DestFile ne "/tmp/preview.html" } { set ReferencePath ""
				} else { set ReferencePath $SourceFile }
				#puts "DebugExportHTML : Dest:$DestFile  Source:$SourceFile  RefImage:$ReferencePath"

				#--  Replace ![name;100px](xx) with <img src="xx" width="100px"></img>
				if { [
					regsub -all -lineanchor {(\!\u3164)(.*?)(\]\()(.+?)(\))} $line \
						{<img  src="[GetAbsolutePath {\4} $ReferencePath]" \
							width="[lindex [split {\2} ";"] 1]"></img>} line ] } {
						catch { set line [subst  -nobackslashes -novariables $line]
					}
				}

				#--  Restore Invisible char with '[' after 'subst'
				regsub -all -lineanchor "\u3164" $line {[} line

				#--  Reformat some inline syntax
				regsub -all -lineanchor {\{\{(PageBreak|pagebreak)\}\}} $line {<div style='page-break-after: always;'></div>} line; #PDF page break
				regsub -all -lineanchor {(___)(\S.*?\S)(___)} $line {<b><u>\2</u></b>} line; #BoldUnderline
				regsub -all -lineanchor {(__)(\S.*?\S)(__)} $line {<u>\2</u>} line; #Underline
				regsub -all -lineanchor {(\+\+)(\S.*?\S)(\+\+)} $line {<span style='font-size:1.2em;'>\2</span>} line; #BigFont

				#--  Replace 'space+Tab' and '5spaces'  with &emsp; or CSS tag 'tab'
				#regsub -all -lineanchor {(?!(^|\S))\t} $line { \&emsp; } line
				regsub -all -lineanchor { \t} $line { \&emsp; } line
				#regsub -all -lineanchor { \t} $line {<tab/>} line

			}; # Endif  Not Code Inline


		}; #  Endif Not In CodeBlock

		# puts "DebugExport: $line"
		append DataNew "$line\n";   # Will be used after to format globally

	};  # End foreach line

	#==  SUBSITUTE TEXT GLOBALLY ( Shortcode )
	regsub -all -lineanchor {\[} $DataNew "\u3164" DataNew;# Replace '[' with invisible char to prevent error with 'subst'
		#--  Reformat HTML Alias WITHOUT newline ( 'Text'{alias list} ) )
		if { [ regsub -all -lineanchor {'([^'\n]+?)'\{(.+?)\}} \
				$DataNew {<span [format_ShortCode {\2}]>[string trim {\1}]</span>} DataNew ] } {
		}
		#--  Reformat HTML Alias WITH newline  ( 'Text\nText'{alias list} ) )
		if { [ regsub -all -lineanchor {'([^']*?\n[^']*?)'\{(.+?)\}} \
				$DataNew {<div [format_ShortCode {\2}]>[string trim {\1}]</div>} DataNew ] } {
		}
	catch { set DataNew [subst -nobackslashes -novariables $DataNew] }
	regsub -all -lineanchor "\u3164" $DataNew {[} DataNew;  # Replace Invisible char with '['

	#--  Reformat indented paragraphs
	regsub -all -lineanchor {(^\|\t)([^\t].*?)(^\s*$)} $DataNew {<span class="indent1">\2</span>} DataNew
	regsub -all -lineanchor {(^\|\t\t)([^\t].*?)(^\s*$)} $DataNew {<span class="indent2">\2</span>} DataNew
	regsub -all -lineanchor {(^\|\t\t\t)(.*?)(^\s*$)} $DataNew {<span class="indent3">\2</span>} DataNew

	#--  Reformat ". text" as pre-format paragraphs
	#regsub -all -lineanchor {(^\. )(.*?)(^\s*$)} $DataNew {<pre>\2</pre>} DataNew

	#==  SAVE FILE
   puts -nonewline $TempFile $DataNew
   close $TempFile;

	#--  No Pandoc ? : Remove metadata '---' lines. Multi-markdown metadata only
	if { ($::PandocMissing) && !($::LowdownMissing) } {
		if  { [ string match "---*" [.fr.t get 1.0 "1.0 lineend" ] ] } {
			set EndMetadata [expr int ([.fr.t search -elide -regex {^-{3,}.*?} 3.0 50.0 ]) ]
			catch { exec sed -i "1d;${EndMetadata}d" /tmp/export.md }
		} else {
			# Add empty first line: prevent text with colon to be formatted as medatada
			catch { exec sed  -i "1i \n" /tmp/export.md }
		}
	}

}


#==  EXECUTE THIRD-PARTY CONVERTER  (Define in Menu>Preference)
proc ExportAsHTML { FileName } {

	#--  Convert Markock to Markdown	
	Convert2Markdown $::FileName  $FileName;   # SourceFile  DestinationFile

	#--  Init Convert Markdown to HTML
	set FileCSS style.css
	file delete -force $FileName

	#--  Begin Conversion with lowdown if pandoc not installed
	if { ($::PandocMissing) && !($::LowdownMissing) } {
		#  --html-hardwrap:  Hard-wrap paragraph content by outputting line breaks
		#  --html-no-owasp: used to simplify  Table of Content building
		catch { exec lowdown  --html-no-skiphtml --html-no-escapehtml \
						--html-hardwrap  --parse-no-codeindent  --html-no-owasp \
						-s -m "css=$FileCSS" -Thtml /tmp/export.md > $FileName \
				} ErrorVar
		#puts "DebugExportHTML (lowdown) Done "
	} else { set ErrorVar " Install application lowdown or pandoc " }

	#--  Begin Conversion with pandoc
	if !($::PandocMissing) {
		#--  Enable pantcl filters  ( Menu > Tools > Enable pantcl filters )
		if { $::pantclfilter } { set PantclFilters " --filter $::ScriptPath/plugin/pantcl.tapp"
		} else { set PantclFilters  "" }
		#--  Execute Pandoc program
		# Get Extentions : pandoc --list-extensions=markdown
		#  --metadata=title:     Do not use metadata 
		catch { eval exec pandoc --standalone \
						--from markdown+hard_line_breaks+autolink_bare_uris+lists_without_preceding_blankline$::PandocExtensions \
						--to  html5 \
						--css=$FileCSS \
						"$::PandocOptions" \
						$PantclFilters \
						/tmp/export.md -o  $FileName } ErrorVar
	}; # End pandoc exec

   #-- If Error found after conversion, stop here
   if { $ErrorVar ne "" } { puts "== PANDOC Message ==\n $ErrorVar" }
   if { ! [file exists $FileName] } {
      tk_messageBox -message "ERROR : \n$ErrorVar" -type ok -icon error
      return
   }

	#==  COPY CSS FILE 
	catch { exec cp "$::ConfPath/export.css" "[file dirname $FileName]/$FileCSS" }

	#==  DISPLAY MESSAGE/HTML
	set ::status " Open: $FileName"
	.fr.t mark set insert 1.0;  # Avoid a bug if insert cursor is on hidden text
	catch { exec $::BrowserViewer $FileName >& /dev/null &  }
}



#==  INCLUDE FILES
#  Include files when exporting with {{include..}} or ```include...```
proc IncludeFiles { Data } {
	regsub -all -lineanchor {\[} $Data "\u3164" Data;# Replace '[' with invisible char to prevent error with 'subst'
	#--  Include file with ```include ....```
	if { [ regsub -all -lineanchor {(```include\n)(.+?)(```)} \
		$Data {[ConcateneFiles {\2}]} Data ] } {
	}
	#--  Include file with {{include [xx](path)}}
	if { [ regsub -all -lineanchor {(\{\{include.*?\()(.+?)(\).*?\}\})} \
		$Data {[ConcateneFiles {\2}]} Data ] } {
	}
	catch { set Data [subst -nobackslashes -novariables $Data] }
	regsub -all -lineanchor "\u3164" $Data {[} Data;  # Replace Invisible char with '['
	return $Data
}


