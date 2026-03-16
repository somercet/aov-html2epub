
# page    bar/master.html page3
#
#    <pageTarget type="normal" id="pageix" value="ix">
#      <navLabel><text>ix</text></navLabel>
#      <content src="Text/part00e_introduction.xhtml#pageix"/>
#    </pageTarget>

/^page/ {
	printf  "    <pageTarget type=\"normal\" id=\"%s\" value=\"%s\">\n"	\
		"      <navLabel><text>%s</text></navLabel>\n"	\
		"      <content src=\"%s#%s\" />\n"	\
		"    </pageTarget>\n",			\
		$3, $4, $4, $2, $3
}

