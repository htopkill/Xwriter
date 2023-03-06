
# TEST IMAGE  

## MARKDOWN SYNTAX

With Name ![Name](test1.jpg)

With No Name ![](test1.jpg)

On sub-folder. Warning: Preview will not display ![](obj/test.png)

On same folder. Warning: Preview will not display  ![SameFolder](test1.jpg) 

## IMAGE AND WIDTH

**WARNING** : Different Zoom on same image **NOK**

Zoom1 ![Name;200px](obj/test.jpg) 
 Zoom 0.5 ![Name;100px](obj/test2.jpg) 
 Zoom 2  ![Name;400px](obj/test3.jpg) 

## SUPPORTED FORMAT
 
JPG ![Name](obj/test.jpg)  
PNG ![Name](obj/test.png) 
BMP ![Name](obj/test.bmp) 

GIF ![Name;200px](obj/test.gif)   No animation:  Only a fix picture is displayed

TIF ![Name](obj/test.tif) 
XBM (On LIGHT Theme ONLY) ![Name](obj/test.xbm) 
TGA ![Name](obj/test.tga) 

 SVG  (text displayed ? background color follow theme ?)  ![Name;200px](obj/test8.svg) 
 SVG  (check text is displayed+Zoomx2)  ![Name;200px](obj/test10.svg) 

WEBP (converted in PNG)  ![Name](obj/test.webp) 
 ![Name](obj/test.jp2) Image JP2000  : **NOK**

## TEST ZOOM ON SUPPORTED FORMAT
OK

##  2 IMAGE ON SAME LINE

Image1  ![Name](obj/test.jpg)  and Image 2    ![Name](obj/test.png)  

## TEXT FORMATING BEFORE/AFTER IMAGE: OK


**Bold** before ![Name](obj/test.jpg) and **after image** OK, work with __underline__ ...


##  IMAGE JUSTIFICATION 
**WARNING**: Always include 1 space or any characters after image path 
Syntax Center : ` :::[Spaces/Tabs] + ![Name](ImagePath) + 1space/Any characters `

::: ![Center Justification](test2.png) 

:::: ![Right Justification](test1.jpg) 


## WEB IMAGE
Text **before** ![ImagewithHTTP](https://www.freeiconspng.com/uploads/linux-icon-19.png) __Text__ after
To Test:
1. Empty Image cache in folder ~/.cache/xwriter and reopen document 
2. Check Image display an 'error' icon and check message when mouse hover the error icon
3. Check Image display after enable 'Display web image' from menu + a notification during downloading
4. Image display without download if document is re-open  ( Image downloaded on cache folder )


## HTML1   with width/height
<img src="test1.jpg" alt="Error"  width="150" height="150"></img>

lowdown, pandoc, github, codeberg: OK

## HTML1   with only width
<img src="test1.jpg" alt="Error"  width="150"></img>

codeberg, github, pandoc:, lowdown:  OK

##  HTML2
<img src="test1.jpg" alt="NoImage" style="width:150px;height:75px;"></img>

lowdown, pandoc, github: OK       codeberg NOK: display in full size


##  Markdown PHP extra in pixel

lowdown/pandoc OK      codeberg,github NOK : display in full zize


![NoImage](test1.jpg){width=150px height=150px}

##  Markdown PHP extra in pixel/ only width

lowdown/pandoc OK      codeberg,github NOK : display in full zize


![NoImage](test1.jpg){width=150px}


##  Markdown PHP extra in % of page width

![NoImage](test1.jpg){width=50% height=50%}

lowdown/pandoc OK     codeberg,github NOK but display in full zize

