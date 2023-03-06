 
# Xwriter V0.4.2  

 
### Update Instruction 

If you have previously installed **xwriter** :   
-  Update your configuration file ( ~/.config/xwriter/config ) with :  [config.diff](config.diff)
-  Update your personnal theme ( ~/.config/xwriter/theme.tcl )  with : [theme diff](theme.tcl.diff)

###  Obsolete

Syntax {{HTML alias}} Text {}  is no more supported. Use ` 'Text'{HTML alias} `

### What's New

-  EXPERIMENTAL :  Add pantcl filters (  [Documentation](doc/pantcl/) )
-  Improve Table of content if document start directly with a heading2
-  The toolbar 'c#' button insert a code block if no text selected
-  Code highlighting :  Add vlang (alias v)

###  FIX
-  Slow downloading of Web image with large documents
-  Freeze when importing some URL : Introduce a counter with timeout
-  No more system notification when downloading image. Only message in toolbar entry
-  Image justification (center..) not working if the image is the only element in the line
-  Pandoc Error if more than one option as "--optionX" defined in Preference file
-  No display for web image as 'http....xxx.png?yyy'
-  HTML export may fail with pandoc+header beginning with number ( pandoc limitation )
-  Some Web image not downloaded ( change curl command line )
-  Font family for all text (header...) updated only after restart and not in real-time
-  Wrong  italic parsing in some cases
-  Useless div/span syntax when importing a document
