# 
#   <pageTarget type="normal" id="page752" value="752" playOrder="1">
#     <navLabel>
#       <text>752</text>
#     </navLabel>
#     <content src="georgia.xhtml#page752"/>
#   </pageTarget>
#
# with FOO filled with:
# Text/part-02-chap.xhtml	page1
# seq 52 927 | paste - FOO | sed -E -f epub2_pagelist.sed
#
# P N 1 N F P
#
#1 f p
#1 f p 1 f p 1 f p 1 f p
#    p     p 1   p   f p
# page6	6	57	6	OPS/Text/part-02-chap.xhtml	page6

s/.*/& a & b & c &/
s/[^	]+	[^	]+	//
s/[^ 	]+	[^	]+	[pagePAGE]+[_-]*//
s/	[^	]+	[pagePAGE]+[_-]*/	/
s/ c [^	]+//
s/ a /	/
s/ b /	/
s;^;    <pageTarget type="normal" id=";
s;	;" value=";
s;	;" playOrder=";
s;	;">\n      <navLabel><text>;
s;	;</text></navLabel>\n      <content src=";
s;	;#;
s;$;" />\n    </pageTarget>;
