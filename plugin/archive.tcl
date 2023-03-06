#!/usr/bin/wish
#  Create/Load/Save a markdown archive (.mdz) containing :
# 			main document + images
#   Require 7z executable (package: p7zip if no encryption, p7zip-full if encryption )


set password "";  					# default password for archive

#===  CREATE/SAVE ARCHIVE
#  ArchiveName= Path/xx.mdz    RootFileName: Markdown file name on archive root
proc SaveAsArchive { ArchiveName RootFileName } {

   #-- Check file name/extension
	if { [string match "* *" $ArchiveName] } {
		tk_messageBox -message " Archive Name with space not supported\n" -type ok -icon error;
		return
	}

	#--  Init
	set DestName [file rootname [file tail $ArchiveName]];  # Name without path/extension
	set ArchiveDir /tmp/$DestName

	#--  Create Archive folders if it's a new archive
	if { ! [ string match "$ArchiveDir*" $RootFileName ] } {
		#puts "DebugArchive: Create directory  $ArchiveDir"
		file delete -force $ArchiveDir; 	# Delete Old Archive Folder if exist
		file mkdir $ArchiveDir	"$ArchiveDir/img"
	}

	#-- Get Text buffer
	set TextDump [.fr.t get 1.0 "end-1c"]

	#--  List items with tag 'ImagePath'
   foreach { start end } [.fr.t tag ranges ImagePath] {
		set ImageName  [.fr.t get $start $end]
		#-- Define Absolute Image Path to copy image in archive after
		if { ! [string match "http*" $ImageName] } {
			set ImagePath [GetAbsolutePath  $ImageName  $::FileName]
		} else { set ImagePath [ GetCacheName $ImageName ] }
		#puts "DebugArchive : $start $end  $ImageName\n Path: $ImagePath"
		#--  Copy Image in archive folder,  Modify Path to Image in Document
		if {[ file  exists  $ImagePath ]} {
			#--  Copy Image in /tmp/ArchiveName/img folder, Modify path in document
			set ImageDest "img/[file tail $ImagePath]"
			#puts "DebugArchive:  Copy $ImagePath to $ArchiveDir/img"
			file copy -force $ImagePath "$ArchiveDir/img";  #Save Img on temp folder
			#--  Modify Image Path in the document
			#puts "DebugArchive:  Rename  $ImageName to $ImageDest"
			regsub -all "$ImageName"  $TextDump "$ImageDest" TextDump; # convert path
		}
	};  # end foreach

	#-- Copy markdown file with new relative path in archive folder
	set DestName "[file rootname [file tail $RootFileName]].md";  # Name without path/extension+md
   set outfile [open  "$ArchiveDir/$DestName"  w ]
	#puts "DebugArchive:  Save RootFile $DestName in ArchivePath: $ArchiveDir"
   puts -nonewline $outfile $TextDump
	close $outfile;

	#-- Delete archive folders and build archive file now
	#puts "DebugArchive:  $ArchiveName / $::password"
	if { [ file extension $ArchiveName ] eq ".mdZ" } {
		set Cmd7zipPassword "-p$::password"   ; # For 7zip "-p$::password -mhe=on"
		set CmdZipPassword "--password $::password"   ;  # For zip
		#set ArchiveName "[file root $ArchiveName].mdZ"
	} else { set Cmd7zipPassword ""; set CmdZipPassword "" }

	file delete $ArchiveName

	#--  ZIP folders using 7zip or zip
	# zip:  exec sh -c "cd $ArchiveDir; zip $CmdPassword -r  $ArchiveName ."
	# 7zip: exec 7z a $Cmd7zipPassword  $ArchiveName "$ArchiveDir/*"
	#puts "DebugArchive : Pass:$CmdZipPassword/$Cmd7zipPassword  Name:$ArchiveName  Dir:$ArchiveDir"
	if { ! [catch { exec sh -c "cd $ArchiveDir; zip $CmdZipPassword -r  $ArchiveName ." } ] }  {
		set ::status " Archive saved: [file tail $ArchiveName]"
	} else {
      tk_messageBox -title ERROR  -message " Error: Archive not saved\n" -type ok -icon error
	}

	#file delete -force $ArchiveDir; # Delete temp folder used to store archive files
}


#===  DECOMPRESS  ARCHIVE AND LOAD FILES
proc LoadArchive { ArchiveName } {
	#--  Check file Name
	if { [string match "* *" $ArchiveName] } {
		tk_messageBox -message " Archive Name with space not supported\n" -type ok -icon error;
		return
	}
	set DestName [file rootname [file tail $ArchiveName]];  # Name without extension
   set DestDir /tmp/$DestName
	#puts "DebugArchive: $ArchiveName \n $DestName \n $DestDir"
	file delete -force $DestDir; # Delete Old Archive Folder if exist

	#-- If encrypted archive, ask password
	if { [file extension $ArchiveName] eq ".mdZ"} {
		set ::password [ dialog_password .password ];  # Open dialog window
		if { $::password ne "" } { set CmdPassword "-p$::password" }
	}  else { set CmdPassword "" }

	#-- Extract archive 
   #  with 7zip:  exec 7z x -y $CmdPassword -o$DestDir  $ArchiveName
   #  with unzip:  exec  unzip -P $::password $ArchiveName -d $DestDir
   if { ! [catch { exec  unzip -P $::password $ArchiveName -d $DestDir  }] } {
		#-- Search .md files: select readme.md/main.md or first .md file found
		set ListFile [glob -directory "$DestDir" -- "*.md"]; # search .md file
		set SourceFile [lsearch -inline -nocase -regexp $ListFile (readme.md|main.md)]
		if { $SourceFile eq "" } { set SourceFile [lindex $ListFile 0] }
		#puts "DebugArchive:\n  List: $ListFile \n Selected: $SourceFile "
		#-- Load File
		LoadFile  $SourceFile "NoBackup"
		wm title . "$ArchiveName  > $SourceFile" ; # Window title used to save archive
   	#--  Add Archive Name to recent List
      set outfile [open "$::ConfPath/recent.md" a+ ]
      puts  -nonewline $outfile "{$ArchiveName} "
      close $outfile
	} else {
      tk_messageBox -title ERROR -message " Error: Loading Archive failed \n" -type ok -icon error
	}
	#-- Keep FilePath for next file open action
	set ::FilePath [ file dirname $ArchiveName ]
}



#===  SAVE AS ENCRYPTED ARCHIVE
proc SaveAsEncryptedArchive { ArchiveName RootFileName } {
		set ::password [ dialog_password .password ];  # Open dialog window
		#puts "DebugSaveEncrypted : $::password"
      SaveAsArchive  $ArchiveName $RootFileName
}
