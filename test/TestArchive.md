
# TEST ARCHIVE  


1. Load this file, Toolbar > SaveAs Archive
2. Load The new archive created
3. Make a change in the main file, insert new image
4. Save Archive and reload archive (from recent file menu). 
5. Check Archive is updated correctly with the new image
6. Enter text in bold and check that Ctrl-R (Reload file) update/format the file
7. Check that absolute path below are converted in relative path in .mdz file ( don't work with svg/webp images )
8. Load 2 different archives. Check Archive content
9. Create encrypted archive and check good/wrong password works as expected



__Absolute Path on same source folder/subfolder__
 ![Name](/home/myself/.bin/Xwriter/test/test1.jpg) 
 ![Name](/home/myself/.bin/Xwriter/test/obj/test3.jpg) 
![Name;200px](/home/myself/.bin/Xwriter/test/obj/test8.svg) 

__Absolute Path on different folder__

 ![Name;2](/usr/share/icons/hicolor/48x48/apps/gparted.png)

__Relative Path (Same Folder and subFolder)__

 ![Name](test2.png) 
 ![Name;200px](obj/test.png) 
 
![Name;200px](obj/test9.svg) 


__Image With HTTP link__
![ImagewithHTTP;0.5](https://www.freeiconspng.com/uploads/linux-icon-19.png)

