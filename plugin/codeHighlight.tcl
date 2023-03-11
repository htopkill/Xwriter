#!/usr/bin/wish
#  Highlight Code Syntax ( ! very very basic )
#  DO NOT USE for serious highlighting
#   \S \s (no)whitespace .* .+ :AnyThing with 0/1+ char  \y word boundary


#==  Define Tag Priority
proc Set_TagCodePriority {} {
	#  From lowest to highest priority
	.fr.t tag raise Code_SubCommand;		# As	echo , sh ... or -foo --foo
	.fr.t tag raise Code_Command;			# As  if while ....
	.fr.t tag raise Code_Function;		# As  [ ] { } proc func 
	.fr.t tag raise Code_Variable;		# As  $foo   ${foo} ....
	.fr.t tag raise Code_SpecialChar;	# As  ( ) ; ` \ < > ! = & |
	.fr.t tag raise Code_String;			# As  "foo"  'foo'
	.fr.t tag raise Code_Comment;			# As  # foo  /* foo */
}


#===  APPLY SYNTAX DEPENDING ON CODEBLOCK DETECTION
proc FormatCodeBlock { language RowNum Row } {
	#puts "DebugCode :  $language  $RowNum   $Row"
	switch -glob [string tolower $language] {
		cpp - "c++" { FormatSyntaxCPP $RowNum $Row }
		css - less - sass - scss - styl - stylus { FormatSyntaxCSS $RowNum $Row }
		csharp - cs 					{ FormatSyntaxCSHARP $RowNum $Row }
		c - cc - h						{ FormatSyntaxC $RowNum $Row }
		v									{ FormatSyntaxV $RowNum $Row }
		console							{ FormatSyntaxCONSOLE $RowNum $Row }
 		diff								{ FormatSyntaxDIFF $RowNum $Row }
		go 								{ FormatSyntaxGO $RowNum $Row }
		ini - toml						{ FormatSyntaxTOML $RowNum $Row }
		javascript - js - node - coffeescript - ecmascript - cjs  { FormatSyntaxJAVASCRIPT $RowNum $Row }
		java 								{  FormatSyntaxJAVA $RowNum $Row }
		php 								{ FormatSyntaxPHP $RowNum $Row }
		python - py						{ FormatSyntaxPYTHON $RowNum $Row }
		ruby - jruby - macruby - rake - rb - rbx { FormatSyntaxRUBY $RowNum $Row }
		rust - rs						{ FormatSyntaxRUST $RowNum $Row  }
		shell - sh - bash - zsh 	{ FormatSyntaxSHELL $RowNum $Row }
		tcl 								{ FormatSyntaxTCL $RowNum $Row }
		typescript - ts				{ FormatSyntaxTYPESCRIPT $RowNum $Row }
		html - xml - xhtml			{ FormatSyntaxHTML $RowNum $Row }
		perl - pl						{ FormatSyntaxPERL $RowNum $Row }
		dot - gv							{ FormatSyntaxDOT $RowNum $Row }
		yaml - yml						{ FormatSyntaxYAML $RowNum $Row }
		lua								{ FormatSyntaxLUA $RowNum $Row }
		json								{ FormatSyntaxJSON $RowNum $Row }

		asp - aspx {}
		clojure - clj - cljc - cljx {}
		curl {}
		d {}
		dart {}
		dockerfile {}
		erlang - erl {}
		graphql - gql {}
		groovy - gradle {}
		handlebars - hbs {}
		http {}
		jsx {}
		julia - jl {}
		kotlin - kt {}
		liquid {}
		makefile {}
		objectivec - objc {}
		objectivecplusplus - "objc++" - objcpp - objectivecpp {}
		ocaml - ml {}
		powershell - ps1 {}
		r {}
		scala {}
		solidity - sol {}
		sql - cql - mssql - mysql - plsql - postgres - postgresql - pgsql - sqlite {}
		swift {}
		default 	{}
	}
}


#===  GENERIC REGEX TO TAG ALL TEXT ( use with RowNum=1: done only once )
# Pattern for comment  /\*(\*(?!/)|[^*])*\*/
#  (searches for /* ,an * that is not followed by a /, any char except * , */)
proc TagCodeAll { tag pattern RowNum } {
	if { $RowNum eq 1 } {
		if {$pattern eq "GenericComment"} { set pattern {/\*(\*(?!/)|[^*])*\*/} }
		TagRegS $tag $pattern [ .fr.t get 1.0 "end-1c" ] 1
	}
}


#===  GENERIC REGEX TO TAG THE LINE Number 'RowNum' containing text 'Row'
proc TagCode { tag pattern Row RowNum } {
	foreach elt [regexp -indices -all -nocase -inline $pattern $Row] {
		.fr.t tag add $tag $RowNum.[lindex $elt 0] $RowNum.[lindex $elt 1]+1c
	}
}


#==  COMMON FORMATING  for SpecialChar, String and Variable
proc FormatSyntaxCommon { RowNum Row } {
	TagCode	Code_Variable		{\$\{?[0-9A-Za-z_!@#$*?-]+\}?} $Row $RowNum
	TagCode  Code_SpecialChar	{\(|\)|\;|`|\\|<-|->|<=|>=|=>|=<|:=|!|!=|==|\+=|-=|<<|>>|<<<|>>>|<<=|>>=|\^=|&=|\*=|/=|%=|\|=|&&|\|}  $Row $RowNum
	TagCode  Code_String			{'[^']+'|"[^"]+"} $Row $RowNum
}


#===  SPECIFIC TAG  FOR EACH CODE SYNTAX

proc FormatSyntaxCONSOLE { RowNum Row } {
   TagCode	Code_String 		{^\$} 	$Row $RowNum
}


proc FormatSyntaxDIFF { RowNum Row } {
   TagCode	Code_Comment			{^@@.*@@} 	$Row $RowNum
   if { [ regexp  {^\-.*} $Row] } { .fr.t tag add ModificationDeleted $RowNum.0 "$RowNum.0 lineend+1c" }
   if { [ regexp  {^\–.*} $Row] } { .fr.t tag add ModificationDeleted $RowNum.0 "$RowNum.0 lineend+1c" }
   if { [ regexp  {^\+.*} $Row] } { .fr.t tag add ModificationAdded $RowNum.0 "$RowNum.0 lineend+1c" }
	#--  Using linux wdiff command :
   #TagCode	ModificationDeleted 	{(?:\[-)(.*)(?:-\])}	$Row $RowNum
   #TagCode	ModificationAdded		{(?:\{\+)(.*)(?:\+\})}	$Row $RowNum
}


proc FormatSyntaxTCL { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*#.*} 	$Row $RowNum
   TagCode	Code_Comment     	{;\s+#.*}	$Row $RowNum; 			#inline comment
	TagCode 	Code_Command		{\y(after|append|array|auto_execok|auto_import|auto_load|auto_load_index|auto_qualify|binary|bgerror|break|case|catch|cd|clock|close|concat|continue|create|dde|default|encoding|eof|else|elseif|error|eval|exec|exit|expr|fblocked|fconfigure|fcopy|file|fileevent|flush|font|for|foreach|format|gets|glob|global|history|if|incr|info|interp|join|lappend|lindex|linsert|list|llength|load|lrange|lreplace|lsearch|lset|lsort|namespace|open|package|pid|puts|pwd|read|regexp|regsub|rename|return|scan|seek|set|socket|source|split|string|subst|switch|tag|tclLog|tell|time|trace|unknown|unset|update|uplevel|upvar|variable|vwait|while)\y}   $Row $RowNum
	TagCode 	Code_Command		{\y(alarm|auto_load_pkg|bsearch|catclose|catgets|catopen|ccollate|cconcat|cequal|chgrp|chmod|chown|chroot|cindex|clength|cmdtrace|commandloop|configure|crange|csubstr|ctoken|ctype|dup|echo|execl|fcntl|flock|fork|fstat|ftruncate|funlock|host_info|id|infox|keyldel|keylget|keylkeys|keylset|kill|lassign|lcontain|lempty|lgets|link|lmatch|loadlibindex|loop|lvarcat|lvarpop|lvarpush|max|min|nice|pkg_mkIndex|pipe|profile|random|readdir|replicate|resource|scancontext|scanfile|scanmatch|select|server_accept|server_create|signal|sleep|sync|system|tclx_findinit|tclx_fork|tclx_load_tndxs|tclx_sleep|tclx_system|tclx_wait|times|translit|try_eval|umask|wait)\y} $Row $RowNum
	TagCode 	Code_Command		{\y(anymore|donesearch|exists|get|names|nextelement|size|startsearch|statistics|unset)\y}  $Row $RowNum
	TagCode 	Code_Command		{\y(bytelength|compare|equal|first|index|last|length|map|match|range|repeat|replace|to|tolower|totitle|toupper|trim|trimleft|trimright|will|wordend|wordstart)\y}  $Row $RowNum
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
	TagCode  Code_Function	   {\y(proc|method)\y} $Row $RowNum
}


proc FormatSyntaxLUA { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*--.*} 		$Row $RowNum
	TagCode  Code_Command      {\y(and|break|do|else|elseif|end|false|for|function|goto|if|in|local|nil|not|or|repeat|return|then|true|until|while)\y} $Row $RowNum
	TagCode  Code_SubCommand	{\y(assert|collectgarbage|dofile|error|getfenv|getmetatable|ipairs|load|loadfile|module|next|pairs|pcall|print|rawequal|rawget|rawlen|rawset|require|select|setfenv|setmetatable|tonumber|tostring|type|unpack|xpcall)\y} $Row $RowNum
	TagCode  Code_Function	   {\{|\}|\[|\]|\[\[|\]\]} $Row $RowNum
}

proc FormatSyntaxSHELL { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*#.*} 		$Row $RowNum
   TagCode	Code_Comment     	{#.*}	$Row $RowNum; 			#inline comment
	TagCode  Code_Command      {\y(alias|case|do|done|elif|else|export|esac|fi|function|for|if|in|set|select|then|until|while)\y} $Row $RowNum
	TagCode  Code_SubCommand   {\y(apt|apt-get|apg|awk|bash|bc|cat|cd|clear|cut|cp|chattr|chown|chmod|csplit|column|cron|curl|date|dateadd|datediff|ddate|dd|df|dig|dnf|dmesg|disown|diff|dstat|du|echo|egrep|export|env|exit|factor|find|file|fdisk|fold|free|fuser|git|gpg|grep|hdparm|head|help|host|iconv|ip|ifconfig|iostat|iotop|join|kill|last|ldd|less|ls|ln|lockfile|logrotate|locate|lsblk|lshw|lscpu|lspci|lsusb|lsmod|lsof|make|mkdir|mkfs|man|modinfo|mount|mtr|mv|ncdu|netstat|nc|nl|nohup|ngrep|npm|pacman|paste|perl|pip|ps|pgrep|pkill|pstree|printf|python|python3|read|rename|rmdir|rsync|route|rm|sed|seq|sudo|screen|strptime|sh|shuf|split|ssh|sort|strace|strings|sysctl|su|sudo|tail|tac|tee|time|top|touch|traceroute|time|timeout|type|trap|tr|tree|truncate|tmux|uconv|uptime|updatedb|uname|uniq|units|unzip|wc|which|watch|wget|wdiff|whoami|xargs|yum|zless|zmore|zcat|zip|zgrep)\y} $Row $RowNum
	TagCode  Code_Function	   {\{|\}|\[|\]|\[\[|\]\]} $Row $RowNum
}

proc FormatSyntaxJAVASCRIPT { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
	TagCodeAll	Code_Comment	GenericComment $RowNum; # Block comment
   TagCode	Code_Comment 		{^\s*//.*} 		$Row $RowNum
   TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 			#inline comment
   TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 		#Block comment
	TagCode  Code_Command      {\y(async|block|break|case|class|const|continue|debugger|default|delete|do|else|export|extends|finally|for|from|function|if|import|in|instanceof|new|return|super|switch|this|throw|try|typeof|var|void|while|with|yield|enum|implements|interface|let|package|private|protected|public|static|await|abstract|boolean|byte|char|double|final|float|goto|int|long|native|short|synchronized|throws|transient|volatile)\y} $Row $RowNum
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}

proc FormatSyntaxPYTHON { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
	TagCodeAll	Code_Comment	{"""[^"]+?"""}  $RowNum; # Block comment
   TagCode	Code_Comment 		{^\s*#.*} 		$Row $RowNum
   TagCode	Code_Comment     	{#.*}	$Row $RowNum; 			#inline comment
	TagCode  Code_Command      {\y(and|as|assert|break|class|continue|def|del|elif|else|except|exec|False|finally|for|from|global|if|import|in|is|lambda|None|nonlocal|not|or|pass|print|raise|return|True|try|while|with|yield|yield)\y} $Row $RowNum
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}


proc FormatSyntaxCSS { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*//.*} 		$Row $RowNum
   TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 			#inline comment
   TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 		#Block comment
	TagCode	Code_Command		{\y(a\:link|root|area|articles|aside|audio|base|basefont|bdi|bdo|big|blockquote|body|br|button|canvas|caption|center|cite|code|col|colgroup|datalist|dd|del|details|dfn|dialog|dir|div|dl|dt|em|embed|fieldset|figcaption|figure|font|footer|form|frame|frameset|h1|h2|h3|h4|h5|h6|head|header|hr|html|iframe|img|input|ins|kbd|keygen|label|legend|li|link|main|map|mark|menu|menuitem|meta|meter|nav|noframes|noscript|object|ol|optgroup|option|output|p|param|pre|progress|rp|rt|ruby|samp|script|section|select|small|source|span|strike|strong|style|sub|summary|sup|table|tbody|td|textarea|tfoot|th|thead|time|title|tr|track|tt|ul|var|video|wbr)\y} $Row $RowNum;
	TagCode  Code_SubCommand   {\y(animation|animation-delay|animation-direction|animation-duration|animation-fill-mode|animation-iteration-count|animation-name|animation-play-state|animation-timing-function|appearance|backface-visibility|background|background-attachment|background-clip|background-color|background-image|background-origin|background-position|background-repeat|background-size|border|border-bottom|border-bottom-color|border-bottom-style|border-bottom-width|border-collapse|border-color|border-image|border-left|border-left-color|border-left-style|border-left-width|border-radius|border-right|border-right-color|border-right-style|border-right-width|border-style|border-top|border-top-color|border-top-style|border-top-width|border-width|bottom box-sizing|box-shadow|clear|clip|color|column-count|column-fill|column-gap|column-rule|column-rule-color|column-rule-style|column-rule-width|column-span|column-width|columns|cursor|direction|display|filter|float|font|font-family|font-size|font-stretch|font-style|font-variant|font-weight|hanging-punctuation|height|icon|left|letter-spacing|line-height|list-style|list-style-image|list-style-position|list-style-type|margin|margin-bottom|margin-left|margin-right|margin-top|max-height|max-width|min-height|min-width|nav-down|nav-index|nav-left|nav-right|nav-up|opacity|outline|outline-color|outline-offset|outline-style|outline-width|overflow|padding|padding-bottom|padding-left|padding-right|padding-top|perspective|perspective-origin|position|punctuation-trim|resize|right|src|tab-size|text-align|text-align-last|text-decoration|text-emphasis|text-indent|text-justify|text-outline|text-overflow|text-shadow|text-transform|text-wrap|top|transform|transform-origin|transform-style|transition|transition-delay|transition-duration|transition-property|transition-timing-function|unicode-bidi|unicode-range|vertical-align|visibility|white-space|width|word-break|word-spacing|word-wrap|z-index)\y} $Row $RowNum
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}

proc FormatSyntaxCPP { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
	TagCodeAll	Code_Comment	GenericComment $RowNum; # Block comment
   TagCode	Code_Comment 		{^\s*//.*} 		$Row $RowNum
   TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 			#inline comment
   TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 		#Block comment
	TagCode	Code_Command		{\y(alignas|alignof|and|and_eq|asm|auto|bitand|bitor|bool|break|case|catch|char|char8_t|char16_t|char32_t|class|compl|concept|const|const_cast|consteval|constexpr|constinit|continue|co_await|co_return|co_yield|decltype|default|define|delete|do|double|dynamic_cast|elif|else|error|endif|enum|explicit|export|extern|false|final|float|for|friend|goto|if|ifdef|ifndef|import|include|inline|int|line|long|module|mutable|namespace|new|noexcept|not|not_eq|nullptr|operator|or|or_eq|override|private|protected|public|register|reinterpret_cast|requires|return|short|signed|sizeof|static|static_assert|static_cast|struct|switch|template|this|thread_local|throw|true|try|typedef|typeid|typename|undef|union|unsigned|using|virtual|void|volatile|wchar_t|while|xor|xor_eq|xor_eq)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
	TagCode  Code_Function	   {(#if|#ifdef|#ifndef|#else|#endif|#define|#include)\y} $Row $RowNum
}

proc FormatSyntaxCSHARP { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
	TagCodeAll	Code_Comment	GenericComment $RowNum; # Block comment
   TagCode	Code_Comment 		{^\s*//.*} 		$Row $RowNum
   TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 			#inline comment
   TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 		#Block comment
	TagCode	Code_Command		{\y(abstract|as|base|bool|break|byte|case|catch|char|checked|class|const|continue|decimal|default|delegate|do|double|else|enum|event|explicit|extern|false|finally|fixed|float|for|foreach|goto|if|implicit|in|int|interface|internal|is|lock|long|namespace|new|null|object|operator|out|override|params|private|protected|public|readonly|ref|return|sbyte|sealed|short|sizeof|stackalloc|static|string|struct|switch|this|throw|true|try|typeof|unit|ulong|unchecked|unsafe|ushort|using|static|virtual|void|volatile|while|while)\y} $Row $RowNum;
	TagCode	Code_Command		{\y(add|alias|ascending|async|await|by|descending|dynamic|equals|from|get|global|group|into|join|let|nameof|on|orderby|partial|remove|select|set|value|var|when|where|yield|yield)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}

proc FormatSyntaxC { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
	TagCodeAll	Code_Comment	GenericComment $RowNum; # Block comment
	TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 			# inline comment
	TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 		#Block comment
   TagCode	Code_Comment     	{^//.*}	$Row $RowNum;
	TagCode  Code_SubCommand	{\y(aligned|asm|auto|Alignas|Alignof|Atomic|builtin|bool|Bool|Complex|class|char|const|double|explicit|enum|extern|friend|float|Generic|hidden|Imaginary|inline|int|long|mutable|namespace|Noreturn|override|packed|restrict|private|protected|public|register|restrict|section|short|signed|sizeof|static|Static_assert|struct|template|this|typename|typeof|Thread_local|typedef|using|union|unsigned|void|virtual|volatile|weak)\y} $Row $RowNum;
	TagCode	Code_Command		{\y(if|else|for|while|do|switch|case|default|try|throw|catch|operator|new|delete|break|continue|goto|return)\y} $Row $RowNum;
	TagCode  Code_Command		{\y(define|else|endif|elif|error|pragma|include|line|undef|warning)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
	TagCode  Code_Function	   {(#if|#ifdef|#ifndef|#else|#endif|#define|#include)\y} $Row $RowNum
}

proc FormatSyntaxV { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
	TagCodeAll	Code_Comment	GenericComment $RowNum; # Block comment
	TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 	# inline comment
   TagCode	Code_Comment     	{^//.*}	$Row $RowNum;
	TagCode  Code_SubCommand	{\y(bool|string|i8|i16|int|i64|i128|u8|u16|u32|u64|u128|rune|f32|f64|isize|usize|voidptr)\y} $Row $RowNum;
	TagCode	Code_Command		{\y(as|asm|assert|atomic|break|const|continue|defer|else|enum|false|fn|for|go|goto|if|import|in|interface|is|isreftype|lock|match|module|mut|none|or|pub|return|rlock|select|shared|sizeof|spawn|static|struct|true|type|typeof|union|unsafe|volatile|__global|__offsetof)\y} $Row $RowNum;
	#TagCode	Code_Command		{\y(print|println|eprint|eprintln|exit|panic|print_backtrace)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
	TagCode  Code_Function	   {(#include|#flag|#pkgconfig|@FN|@METHOD|@MOD|@STRUCT|@FILE|@LINE|@FILE_LINE|@COLUMN|@VEXE|@VEXEROOT|@VHASH|@VMOD_FILE|@VMODROOT|$if|$embed_file|$tmpl|$env|$compile_error|$compile_warn)\y} $Row $RowNum
}


proc FormatSyntaxRUBY { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*#.*} 	$Row $RowNum
   TagCode	Code_Comment 		{^=begin} 	$Row $RowNum
   TagCode	Code_Comment 		{^=end} 	$Row $RowNum
	TagCode	Code_Command		{\y(__ENCODING__|__LINE__|__FILE__|BEGIN|END|alias|and|begin|break|case|class|def|defined?|do|else|elsif|end|ensure|false|for|if|in|module|next|nil|not|or|redo|rescue|retry|return|self|super|then|true|undef|unless|until|when|while|yield|yield)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}

proc FormatSyntaxJAVA { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*//.*} 		$Row $RowNum
   TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 			#inline comment
   TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 		#Block comment
	TagCode	Code_Command		{\y(abstract|boolean|break|byte|case|catch|char|class|continue|default|do|double|else|enum|extends|final|finally|float|for|if|implements|import|instanceof|int|interface|long|native|new|null|package|private|protected|public|return|short|static|strictfp|super|switch|synchronized|this|throw|throws|transient|try|void|volatile|while|while)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}


proc FormatSyntaxGO { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
	TagCodeAll	Code_Comment	GenericComment $RowNum; # Block comment
   TagCode	Code_Comment 		{^\s*//.*} 	$Row $RowNum
   TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 	#inline comment
   TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 	#Block comment
	TagCode	Code_Command		{\y(break|case|chan|const|continue|default|defer|else|fallthrough|for|func|go|goto|if|import|interface|map|package|range|return|struct|switch|type|var)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}

proc FormatSyntaxRUST { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*//.*} 		$Row $RowNum
   TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 			#inline comment
   TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 		#Block comment
	TagCode	Code_Command		{\y(as|async|await|break|const|continue|crate|dyn|else|enum|extern|false|fn|for|if|impl|in|let|loop|match|mod|move|mut|pub|ref|return|self|Self|static|struct|super|trait|true|type|unsafe|use|where|while|while)\y} $Row $RowNum;
	TagCode	Code_Command		{\y(abstract|become|box|do|final|macro|override|priv|static|try|typeof|union|unsized|virtual|yield|yield)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}

proc FormatSyntaxPHP { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*//.*} 	$Row $RowNum
   TagCode	Code_Comment 		{^\s*#.*} 	$Row $RowNum
   TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 		#Block comment
	TagCode	Code_Command		{\y(abstract|and|array|as|break|callable|case|catch|class|clone|const|continue|declare|default|die|do|echo|else|elseif|empty|enddeclare|endfor|endforeach|endif|endswitch|endwhile|eval|exit|extends|final|finally|for|foreach|fn|function|global|goto|if|implements|include|include_once|instanceof|insteadof|interface|isset|list|match|namespace|new|or|print|private|protected|public|readonly|require|require_once|return|static|switch|throw|trait|try|unset|use|var|while|xor|yield|yield from|yield)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}

proc FormatSyntaxTYPESCRIPT { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
	TagCodeAll	Code_Comment	GenericComment $RowNum; # Block comment
   TagCode	Code_Comment 		{^\s*//.*} 		$Row $RowNum;  # Line comment
   TagCode	Code_Comment     	{\s+//.*}	$Row $RowNum; 			# inline comment
	TagCode	Code_Command		{\y(abstract|any|boolean|break|case|catch|continue|class|constructor|const|debugger|default|delete|do|enum|export|extends|else|false|finally|for|function|get|in|instanceof|import|if|declare|interface|let|private|protected|public|readonly|super|set|switch|typeof|this|true|try|throw|new|never|null|number|object|return|string|undefined|var|void|while|with)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}


proc FormatSyntaxHTML { RowNum Row } {
	TagCode	Code_Comment 		{<!--.*-->} 		$Row $RowNum;
	TagCode	Code_Command		{<[[:alpha:]/!?][^>]*>}  $Row $RowNum;
	TagCode  Code_Variable		{&[^;[:space:]]*;}  $Row $RowNum;  # Named Character
	TagCode  Code_Function	   {<!DOCTYPE.*?>}	$Row $RowNum
	TagCode  Code_String			{'[^']+'|"[^"]+"} $Row $RowNum
}

proc FormatSyntaxPERL { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*#.*} 	$Row $RowNum
	TagCode	Code_Command		{\y(continue|else|elsif|do|for|foreach|if|unless|until|while|eq|ne|lt|gt|le|ge|cmp|x|my|sub|use|package|can|isa)\y}  $Row $RowNum;
	TagCode  Code_SubCommand	{\y(accept|alarm|atan2|bin(d|mode)|c(aller|h(dir|mod|op|own|root)|lose(dir)?|onnect|os|rypt)|d(bm(close|open)|efined|elete|ie|o|ump)|e(ach|of|val|x(ec|ists|it|p))|f(cntl|ileno|lock|ork))\>" "\<(get(c|login|peername|pgrp|ppid|priority|pwnam|(host|net|proto|serv)byname|pwuid|grgid|(host|net)byaddr|protobynumber|servbyport)|([gs]et|end)(pw|gr|host|net|proto|serv)ent|getsock(name|opt)|gmtime|goto|grep|hex|index|int|ioctl|join)\>" "\<(keys|kill|last|length|link|listen|local(time)?|log|lstat|m|mkdir|msg(ctl|get|snd|rcv)|next|oct|open(dir)?|ord|pack|pipe|pop|printf?|push|q|qq|qx|rand|re(ad(dir|link)?|cv|do|name|quire|set|turn|verse|winddir)|rindex|rmdir|s|scalar|seek(dir)?)\>" "\<(se(lect|mctl|mget|mop|nd|tpgrp|tpriority|tsockopt)|shift|shm(ctl|get|read|write)|shutdown|sin|sleep|socket(pair)?|sort|spli(ce|t)|sprintf|sqrt|srand|stat|study|substr|symlink|sys(call|read|tem|write)|tell(dir)?|time|tr(y)?|truncate|umask)\>" "\<(un(def|link|pack|shift)|utime|values|vec|wait(pid)?|wantarray|warn|write)\y} $Row $RowNum;
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
}

proc FormatSyntaxDOT { RowNum Row } {
	FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*//.*} 		$Row $RowNum
   TagCode	Code_Comment 		{^\s*#.*} 	$Row $RowNum
   TagCode	Code_Comment     	{;\s+#.*}	$Row $RowNum; 			#inline comment
	TagCode  Code_Function	   {\{|\}|\[|\]} $Row $RowNum
	TagCode	Code_Command		{\y(graph|digraph|subgraph|node|edge|strict)\y}  $Row $RowNum;
	TagCode  Code_SubCommand	{\y(area|class|color|colorscheme|comment|distortion|fillcolor|fixedsize|fontcolor|fontname|fontsize|gradientangle|group|height|href|id|image|imagepos|imagescale|label|labelloc|layer|margin|nojustify|ordering|orientation|penwidth|peripheries|pin|pos|rects|regular|root|samplepoints|shape|shapefile|showboxes|sides|skew|sortv|style|target|tooltip|URL|vertices|width|xlabel|xlp)\y} $Row $RowNum;
	TagCode  Code_SubCommand	{\y(_background|bb|beautify|bgcolor|center|charset|class|clusterrank|colorscheme|comment|compound|concentrate|Damping|defaultdist|dim|dimen|diredgeconstraints|dpi|epsilon|esep|fontcolor|fontname|fontnames|fontpath|fontsize|forcelabels|gradientangle|href|id|imagepath|inputscale|label|label_scheme|labeljust|labelloc|landscape|layerlistsep|layers|layerselect|layersep|layout|levels|levelsgap|lheight|linelength|lp|lwidth|margin|maxiter|mclimit|mindist|mode|model|newrank|nodesep|nojustify|normalize|notranslate|nslimit|nslimit1|oneblock|ordering|orientation|outputorder|overlap|overlap_scaling|overlap_shrink|pack|packmode|pad|page|pagedir|quadtree|quantum|rankdir|ranksep|ratio|remincross|repulsiveforce|resolution|root|rotate|rotation|scale|searchsize|sep|showboxes|size|smoothing|sortv|splines|start|style|stylesheet|target|TBbalance|tooltip|truecolor|URL|viewport|voro_margin|xdotversion)\y} $Row $RowNum;
	TagCode  Code_SubCommand	{\y(arrowhead|arrowsize|arrowtail|class|color|colorscheme|comment|constraint|decorate|dir|edgehref|edgetarget|edgetooltip|edgeURL|fillcolor|fontcolor|fontname|fontsize|head_lp|headclip|headhref|headlabel|headport|headtarget|headtooltip|headURL|href|id|label|labelangle|labeldistance|labelfloat|labelfontcolor|labelfontname|labelfontsize|labelhref|labeltarget|labeltooltip|labelURL|layer|len|lhead|lp|ltail|minlen|nojustify|penwidth|pos|samehead|sametail|showboxes|style|tail_lp|tailclip|tailhref|taillabel|tailport|tailtarget|tailtooltip|tailURL|target|tooltip|URL|weight|xlabel|xlp)\y} $Row $RowNum;
}

proc FormatSyntaxYAML { RowNum Row } {
	#FormatSyntaxCommon $RowNum $Row
   TagCode	Code_Comment 		{^\s*#.*} 	$Row $RowNum
	TagCode	Code_Variable		{^\s.*?:$}  $Row $RowNum;
	TagCode	Code_Function		{^(?=\S).*:$}  $Row $RowNum;
}

proc FormatSyntaxTOML { RowNum Row } {
   TagCode	Code_Comment 		{^\s*#.*} 	$Row $RowNum
	TagCode	Code_Function		{^\[.*?\]$}  $Row $RowNum;
}

proc FormatSyntaxJSON { RowNum Row } {
   TagCode	Code_Comment     	{/\*.*\*/}	$Row $RowNum; 		#Block comment
	TagCode  Code_SpecialChar	{\{|\}|\[|\]}  $Row $RowNum
	TagCode	Code_Function		{"[^"]+"[:space:]*:}  $Row $RowNum;  #Name
	TagCode	Code_SubCommand		{".+"}  $Row $RowNum;  #Value
}
