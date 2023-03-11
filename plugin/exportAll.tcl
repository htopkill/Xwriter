#!/usr/bin/wish
#    Convert Markdock to Any PANDOC supported format
#  http://pandoc.org/demos.html   and   	https://pandoc.org/MANUAL.html
#  RAW HTML inside a document is exported only with markdown/epub/html format


#==  DEFINE AVAILABLE OUTPUT TYPE
if !($::PandocMissing) {
	set ::PandocOutputTypes {
		{{PDF} {.pdf} }
		{{Open Document Text} {.odt} }
		{{Microsoft Word} {.docx} }
		{{Epub} {.epub} }
		{{Rich Text Document} {.rtf} }
	}
}

#==   WRITE OUTPUT FILE WITH PANDOC
proc ExportWithPandoc { FileName } {

	if ($::PandocMissing) { set ::status " ERROR: Install pandoc before"; return }
	set FileExtention [ file extension $FileName ]

	#-- Define Output Format
	set format  [ string map { .odt odt .docx docx .epub epub } $FileExtention ]

   #-- Get Text to export
	set TempFile [open /tmp/export.md w ];
	set Data [ .fr.t get 1.0 "end-1c" ]
   set CodeBlock false;               # Used to disable format inside Code

   #==  INCLUDE FILES
	set Data [ IncludeFiles $Data ]

	##--  Reformat markdock --> docx/odt

   #-- Convert markdock> pandoc syntax except if in CodeBlock (```) or in CodeInline
   set lines [split $Data "\n"];      # Array with each line of file
   foreach line $lines {
		#puts "DebugExport:   $line"

	   #--  Replace ```tcl/dot with ```.tcl/.dot ( prevent pantcl filters evaluation)
		regsub -all -lineanchor {^```tcl} $Data {```.tcl} Data
		regsub -all -lineanchor {^```dot} $Data {```.dot} Data

      #--  Evaluate if inside codeblock
      if { [ regexp {(^```)(.*?)$} $line ] } {
         if { ! $CodeBlock } { set CodeBlock true } else { set CodeBlock false }
      }

      if { ! $CodeBlock } {

			#--  Replace line with 2 spaces with a real new line
			if { [ regexp -all -lineanchor {^ {2,}$} $line ] } {
				append DataNew "\\\n";   # "\" is newline in markdown
			}

         #--  Replace Header1 with 2 trailing spaces with style=Title
         regsub -all -lineanchor {^(#\s+)(.*?)  $} $line {<div custom-style="Title">\2</div>} line

			#--  Replace PageBreak
         if { [ regexp {\{\{(PageBreak|pagebreak)\}\}} $line ] } {
				regsub -all -lineanchor {\{\{(PageBreak|pagebreak)\}\}} $line {} line
				switch $format {
					"epub"	{ append DataNew "<div style='page-break-after: always;'></div>" }
					"docx"	{ append DataNew "```{=openxml}\n<w:p><w:r><w:br w:type='page'/></w:r></w:p>\n```\n" }
					"latex"	{ append DataNew "\\newpage{}" }
				}
			};  #endif  pagebreak


			#--  Replace Text Justification with docx/odt style
 			regsub -all -lineanchor {(^::::\s+)(.*?)$} $line {<div custom-style="Right">\2</div>} line
         regsub -all -lineanchor {(^:::\s+)([^\{].*?)$} $line {<div custom-style="Center">\2</div>} line
         regsub -all -lineanchor {(^::\s+)(.*?)$} $line {<div custom-style="FullJustify">\2</div>} line

        #--   NOT IN CODE INLINE
         if { ! [ regexp {(`)(.+?)(`)} $line ] } {;   # Not in  Code Inline

				#--  Reformat some inline syntax
				regsub -all -lineanchor {(___)(\S.*?\S)(___)} $line {<span custom-style="Underline">**\2**</span>} line; #BoldUnderline
				regsub -all -lineanchor {(__)(\S.*?\S)(__)} $line {<span custom-style="Underline">\2</span>} line; #Underline
				#regsub -all -lineanchor {(\+\+\*\*)(\S.*?\S)(\*\*\+\+)} $line {<span style='font-size:1.2em;'><b>\2</b></span>} line; #BigFontBold
				#regsub -all -lineanchor {(\*\*\+\+)(\S.*?\S)(\+\+\*\*)} $line {<span style='font-size:1.2em;'><b>\2</b></span>} line; #BigFontBold
				#regsub -all -lineanchor {(\+\+)(\S.*?\S)(\+\+)} $line {<span style='font-size:1.2em;'>\2</span>} line; #BigFont
				regsub -all -lineanchor {(<mark>)(.*?)(</mark>)} $line {<span custom-style="Highlight">\2</span>} line
				regsub -all -lineanchor {(<sup>)(.*?)(</sup>)} $line {<span custom-style="Superscript">\2</span>} line
				regsub -all -lineanchor {(<sub>)(.*?)(</sub>)} $line {<span custom-style="Subscript">\2</span>} line

				#--  Replace Special Tabs 'space+tab' with 4 spaces
         	if { [ regexp -all -lineanchor { \t} $line ] } {
					switch $format {
						"docx" - "odt"	{ regsub -all -lineanchor { \t} $line { \&emsp; } line }
						"latex"	{ append DataNew "\hspace*{4}" }
					}
				};  #endif  pagebreak
			};  # Endif Not in codeinline

      # puts "DebugExport: $line"
		};   # End Not In CodeBlock

		append DataNew "$line\n";   # Will be used after to format globally

	};  # End foreach line


   ##--  Replace list symbol '•'  with symbol '*'
	regsub -all -line  {^(\s*)(?:•)(.*?)} $DataNew {\1*\2} DataNew

   #--  Reformat indented paragraphs
   regsub -all -lineanchor {(^\|\t)([^\t].*?)(^\s*$)} $DataNew {<div custom-style="Indent1">\2</div>} DataNew
   regsub -all -lineanchor {(^\|\t\t)([^\t].*?)(^\s*$)} $DataNew {<div custom-style="Indent2">\2</div>} DataNew
   regsub -all -lineanchor {(^\|\t\t\t)(.*?)(^\s*$)} $DataNew {<div custom-style="Indent3">\2</div>} DataNew

   #--  Save File
   puts -nonewline $TempFile $DataNew
   close $TempFile;

	#--  Save Text in file
   #puts -nonewline $TempFile $Data
   #close $TempFile

	#--  Set Custom-Reference document
	set  Style "$::ConfPath/style$FileExtention"

   #--  Enable pantcl filters  ( Menu > Tools > Enable pantcl filters )
	if { $::pantclfilter } { set PantclFilters " --filter $::ScriptPath/plugin/pantcl.tapp"
	} else { set PantclFilters  "" }

	#-- Export To File
	file delete -force $FileName;		# Delete output file before conversion 
	#puts "DebugExport:  format=$format  style=$Style"
	# Get Extentions : pandoc --list-extensions=markdown
	# --columns= column widths for plain text tables
	# 		( must be very low as table width will be too large otherwise )
   catch { eval exec pandoc -s \
							--columns=2 \
							--resource-path=[file dirname $FileName] \
							--from markdown+hard_line_breaks+autolink_bare_uris+lists_without_preceding_blankline$::PandocExtensions \
 							"$::PandocOptions" \
							$PantclFilters \
							/tmp/export.md -o $FileName \
			} ErrorVar
	#--  Display Final Message
	if { [file exists $FileName] } {
			tk_messageBox -message " Export to format [string toupper $format] done  \n" -type ok -icon info
	} else {
		tk_messageBox -message "WARNING / ERROR \n\n  $ErrorVar" -type ok -icon error
	}
	if { $ErrorVar ne "" } { puts "== PANDOC Warning  ($FileName)\n $ErrorVar" }
}

