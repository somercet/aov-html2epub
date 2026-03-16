
#file    foo/bar/master.html     bar/master.html bar_master.html
#    <item href="Text/part00b_notes.xhtml" id="part00b_notes.xhtml" media-type="application/xhtml+xml" />

/^file/ {
	printf "    <item href=\"%s\" id=\"%s\" media-type=\"application/xhtml+xml\" />\n", $3, $4
}

