#   Manage Font  

#===   CREATE FONT FOR ALL THEME
# WARNING :  Do NOT change Font Size if you want to be compliant with 'Markdock' format
proc SetDefaultFont {} {
	set TextFontFamily				[ font actual TextFont -family ]
	set TextFontSize					[ font actual TextFont -size ]
	font create TextFontBold		-family "$TextFontFamily" -size "$TextFontSize" -weight bold
	font create TextFontItalic		-family "$TextFontFamily" -size "$TextFontSize" -slant italic
	font create TextFontItalicBold	-family "$TextFontFamily" -size "$TextFontSize" -slant italic -weight bold
	font create TextFontSmall		-family "$TextFontFamily" -size [expr $TextFontSize -2]; # sub/supscript
	font create TextFontBig			-family "$TextFontFamily" -size [expr $TextFontSize +2]
	font create TextFontBigBold	-family "$TextFontFamily" -size [expr $TextFontSize +4] -weight bold
	font create TextFontTitle		-family "$TextFontFamily" -size [expr $TextFontSize +10] -weight bold
	font create FontHeading1		-family "$TextFontFamily" -size [expr $TextFontSize +6] -weight bold
	font create FontHeading2		-family "$TextFontFamily" -size [expr $TextFontSize +4] -weight bold
	font create FontHeading3		-family "$TextFontFamily" -size [expr $TextFontSize +2] -weight bold
	font create FontHeading4		-family "$TextFontFamily" -size [expr $TextFontSize +0] -weight bold
	font create FontHeading5		-family "$TextFontFamily" -size [expr $TextFontSize -0]
	font create FontHeading6		-family "$TextFontFamily" -size [expr $TextFontSize -2]
}


#===   CHANGE/SAVE  FONT SIZE
#  Note : Update also font family if default font family has changed
proc ChangeFontSize { increment } {
   set TextFontFamily   [ font actual TextFont -family ]
   set MonospaceFontFamily   [ font actual MonospaceFont -family ]
	#-- Change Font size and Font Family except for monospace
	foreach fontName { \
		TextFont TextFontBold TextFontItalic TextFontItalicBold \
		TextFontTitle FontHeading1 FontHeading2 FontHeading3 FontHeading4 \
		FontHeading5 FontHeading6 TextFontBig TextFontSmall TextFontBigBold
	} {
			set fontSize [font actual $fontName -size]
			incr fontSize $increment
			font configure $fontName -size $fontSize -family $TextFontFamily
	}
	font configure MonospaceFont -size [expr ( [font actual MonospaceFont -size]+$increment)]
   set TextFontSize     [ font actual TextFont -size ]
   set MonospaceFontSize     [ font actual MonospaceFont -size ]
	if { $::GlobalTheme eq "terminal" } {
		set ::status " Font: $MonospaceFontFamily  $MonospaceFontSize"
	} else { set ::status " Font: $TextFontFamily  $TextFontSize" }

	#-- Save new font settings in user config file: require executable 'sed'
	catch {exec sed -i "s/.*TextFont.*/font create TextFont\t\t-family \"$TextFontFamily\" -size $TextFontSize/g"  [file normalize $::ConfFile]}
   catch {exec sed -i "s/.*MonospaceFont.*/font create MonospaceFont\t\t-family \"$MonospaceFontFamily\" -size $MonospaceFontSize/g"  [file normalize $::ConfFile]}
}

