# TEST LINK  



## Test Links in Table Of Content

Generate here the Table of content from ` menu > INS > Table Of Contents ` and check :

1.  Links works in Xwriter
2.  Links works in browser


## Link HTTP

Direct Links :
	This is a https://duckduckgo.com and http://startpage.com  link
	https://tcl.tk/man/tcl8.5/tutorial/Tcl23a.html
	https://duckduckgo.com
	http://duckduckgo.com   http://startpage.com
Link-http-with<> : <http://duckduckgo.com>
Link-https-with<> : <https://duckduckgo.com>
Name-Link :     [Duck Duck Go](https://duckduckgo.com)       [Start page](https://www.startpage.com)
Name-http-Link :     [A link with name http](https://duckduckgo.com)
NoName Link:   [](https://duckduckgo.com) and [](https://www.startpage.com)

## Link File

Absolute Path	:  [My File](/etc/apt/sources.list)
Same Folder. NoPath	:  [Quick Test.md](QuickTest.md)
Same Folder. Path as "./"	:  [Quick Test.md](./QuickTest.md)
Up. Path as "../"	:  [help.md](../help.md)
Up Up. Path as "../../"	:  [bell](../../bell)
GenericFile/SameFolder : [GenericFile](test.txt)
Sub Folder		:  [Test File](obj/test.md)
GenericFile/SubFolder : [GenericFile](obj/test.txt)
NoNameLink **KO** but useless 	:  [](QuickTest.md) and [](obj/test.md)

## Not a link with escaped char

<http://duckduckgo.com\>   NOK
<https://duckduckgo.com\>	NOK
[Name]\(https://duckduckgo.com\)    NOK
[Name]\(FilePath)
[HeaderName]\(#ID)
`http://duckduckgo.com`


## Mix HTTP/File links

[DuckDuckGo](https://duckduckgo.com) and [QuickTest](QuickTest.md) and [StartPage](https://www.startpage.com)
[QuickTest](QuickTest.md) and [DuckDuckGo](https://duckduckgo.com) and [Test File](obj/test.md)

## Mix Link + Image

[QuickTest Link](QuickTest.md)   and image: ![test;100px](test2.png) 


## Link Header

click on this header link : [Link File](#link-file)  OK ?

###   With lot    of spaces
#### UPCASE   with   LOwer   case
#####  Special chars (test1) and test2
######  Special/chars ! \ rep(la)ce-with 1 hypens ?

## 2. Header with Number

