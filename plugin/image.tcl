#!/usr/bin/wish
#  Draw image (png ,jpg ,bmp ,gif ,tif ,xbm ,tga, webp,svg )
#  Define the path to draw the image : 
#		if web image, PhotoPath = .cache/xwriter/image.jpg (downloaded in cache)
#		if svg/webp image, PhotoPath = /tmp/image.svg.png ( image convertion )
#		else PhotoPath = absolute path of image link in the document

#===   INIT
set ::CachePath "$::env(HOME)/.cache/xwriter";  # Cache where downloaded Image will be stored
file mkdir $::CachePath
#--  Define a tag for image ( required for tooltip )
.fr.t tag configure TagImage			-relief solid
.fr.t tag configure TagImageError	-relief solid


#=====   INSERT IMAGE  (Index = position as Line.Column)
proc InsertImage { ImagePath  Index  Width } {

	#--  Ask Image File if not defined
	set NewImage false
	if { $ImagePath eq "" } {
		after idle ForceWindowSize;  			# Force OpenFile Window Size
		set ImagePath [ tk_getOpenFile -initialdir $::FilePath ]
		if { $ImagePath eq "" } { return }
		set ::FilePath [ file dirname $ImagePath ];  # Keep last open directory
		#--  Instruction to insert the image makdown syntax later
		set NewImage true;
	}

	#--  Init
	set ImageName [file tail $ImagePath ];	# without path, with extention
	#set RelativePath [GetRelativePath $ImagePath $::FileName]

	#--  Download image with http link 
	if { [ string match "http*" "$ImagePath" ] } {
		set CacheName [GetCacheName $ImagePath]; # Build Image cache Name based on MD5
		if { $::ImageDownload && ![file exists $CacheName] } {
			#puts "DebugImage: Download WebImage $ImageName in $CacheName"
			#catch {exec wget -o /tmp/wget.log -N --timeout=5 -O $CacheName $ImagePath }
			catch {exec curl -Lk --connect-timeout 7 --retry 1  $ImagePath --output $CacheName }
		}
		if { [file exists $CacheName] && [file size $CacheName] ne 0 } {
			set PhotoPath $CacheName
		} else {  set PhotoPath "ERROR" }
	}

	#--  Set Photo path ( absolute path) from image path (if not http)
	if { ! [ string match "http*" "$ImagePath" ] } {
		set PhotoPath [GetAbsolutePath $ImagePath $::FileName]
	}


	#--  Convert SVG/WEBP image to png ( Require Package librsvg2-bin and webp )
	set ImageExtension [ file extension $PhotoPath ]
	#set FileType [fileutil::fileType $ImagePath]; # Don't work with some svg image
	#--  Check file extension or file type to convert with external application
	if { $ImageExtension eq ".webp" || $ImageExtension eq ".svg" } {
			set NewPath /tmp/$ImageName.png
			if { $ImageExtension eq ".webp" } {
				catch { exec dwebp $PhotoPath -o $NewPath }
			}
			if { $ImageExtension eq ".svg" } {
				catch { exec rsvg-convert --format png $PhotoPath --output $NewPath }
			}
			set PhotoPath $NewPath
			#puts "DebugImage: Convert  $ImagePath  to $PhotoPath"
	}

	#--  Create/Zoom image
	#puts "DebugImage: $Index  Image Path: $ImagePath  Width: <$Width>"
	#puts "DebugImage:    >>  Photo Path : $PhotoPath"
	if {  "$PhotoPath" ne "ERROR" } {
		catch {
			image create photo $ImagePath -file $PhotoPath
			if { [string match "*px" $Width ] }  { scaleImage $ImagePath $Width }
		}
	}

	#--  Set error image if necessary
	if { $PhotoPath eq "ERROR" } { set ImagePath ::tk::icons::error }

	#-- Insert Markdown syntax if new image ( Note: Add a space after image syntax for image justification bug )
	if { $NewImage } {
		set ::status " Image: [image width $ImagePath]x[image height $ImagePath]"
		.fr.t insert $Index " " normal "!\[Name\](" syntax "$ImagePath" "syntax ImagePath" ")" syntax " " normal
	}

	#-- Insert Image
	catch { .fr.t image create $Index -image $ImagePath -name $ImagePath -align center }

	#--  Debug : List All available images
   #foreach img [image names] { puts "DebugImage: InUse [image inuse $img]  $img" }

	#--  Add a Tag to image to assign event when Mouse hover or click on image
	# 			refer to file mouse.tcl for event
	if { $PhotoPath eq "ERROR" } { .fr.t tag add TagImageError $Index $Index+1c
	} else { .fr.t tag add TagImage $Index $Index+1c }

}


#====   RESCALE IMAGE WITH factor
# factor= 0.2, 0.25, 0.3, 0.5 (Shrink x5,4,3,2) or 2,3,4,5... (Zoom)
proc scaleImage {img width} {
	set width [ string map { "px" "" } $width ]
	set factor [ expr ( $width.0/[image width $img] ) ];  #.0 to have real number
	if {$factor < 1} { set mode -subsample; set factor [expr round(1./$factor)]
	} else  { set mode -zoom; set factor [expr round($factor)] }
	#puts "DebugImg: $img  Width:$width   zoom: $factor  Mode: $mode"
   set temp [image create photo];			# Create temp image
   $temp copy $img;   $img blank;  			# Copy source on temp image, blank source 
	$img copy $temp -shrink $mode $factor;	# Copy temp image on source with zoom
	image delete $temp;							# Delete temp image
}


#===   DISPLAY WEB  IMAGE
#--  Find All Web images and re-parse the line (will download image)
proc Display_Web_Image {} {
	if { $::ImageDownload && $::FileName ne "" } {
		foreach { start end } [.fr.t tag ranges ImagePath] {
			set ::status " Downloading Image ($start) ..."
			update;  					# Refresh UI to display status message
			RemoveAllTag "$start linestart"  "$start lineend"
			ParseLine [ expr int($start) ] [.fr.t get "$start linestart" "$end lineend"]
		}
		set ::status " Downloading Image: Done"
	}
}


#===  RETURN AN IMAGE CACHE PATH FOR WEB IMAGE
proc GetCacheName { ImagePath } {
	#--  Get Image Real extention ( remove useless text as .png?raw=true )
	regsub {(\?.*)} [ file extension $ImagePath ] {}  ImageExtension
	#-- Cache Name is build with Hash MD5 + Real extension
	return [string tolower "$::CachePath/[ md5::md5 -hex $ImagePath ]$ImageExtension" ]
}




