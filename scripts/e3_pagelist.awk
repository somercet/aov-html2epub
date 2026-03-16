
# page    bar/master.html page3
#        <li><a href="Text/part00e_introduction.xhtml#pagex">x</a></li>

/^page/ {
	printf "        <li><a href=\"%s#%s\">%s</a></li>\n", $2, $3, $4
}

