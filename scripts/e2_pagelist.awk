
#page	b/master.html	page3	3

/^page/ {
	printf  "    <pageTarget type=\"normal\" id=\"%s\" value=\"%s\">\n"	\
		"      <navLabel><text>%s</text></navLabel>\n"	\
		"      <content src=\"%s#%s\" />\n"	\
		"    </pageTarget>\n",			\
		$3, $4, $4, $2, $3
}

