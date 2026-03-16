#nnav	master.html	1	type	sec3	Title

BEGIN {
	FS = "	"
	prev = 0
	nid = 1
	body =	"<navPoint id=\"%s\" playOrder=\"%s\"><navLabel><text>%s</text></navLabel><content src=\"%s\" />"

	tail =	"</navPoint>"

	printf body, "navp" nid, nid, "Title page", "titlepage.xhtml"
	nid++
}

function indent(n, i) {
	s=""
	for ( i = 0; i < n; i++ ) s = s"  "
	return s
}

#printf "%s  </navPoint>\n", ogap

/^[in]nav/ {
	if ( $3 < prev )
		for ( i = prev; i >= $3; i-- )
			print indent(i) tail
	else if ( $3 == prev )
		print indent(i) tail
	else
		print ""

	if ( $5 )
		s = "#" $5
	else
		s = ""
	printf indent($3) body, "navp" nid, nid, $6, $2 s
	nid++

	prev = $3
}

END {
	for ( i = prev; i >= 0; i-- )
		print indent(i) tail
}

