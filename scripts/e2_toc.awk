#nnav	master.html	1	type	sec3	Title

@include "fr_stack.awk"

function indent(n) {
	if (! ind[n] ) {
		ind[n] = ind[0]
		for ( i = 0; i < n; i++ )
			ind[n] = ind[n] "  "
	}
	return ind[n]
}

BEGIN {
	FS = "	"
	prev = 0
	nid = 1
	sp = 0	# stack pointer

	ind[0] = "    "
	body = "%s<navPoint id=\"%s\" playOrder=\"%s\"><navLabel><text>%s</text></navLabel><content src=\"%s\" />"
	tail = "</navPoint>"

        print "  <navMap>"
	printf body, indent(0), "navp" nid, nid, "Title page", "titlepage.xhtml"
	print ""
	nid++
	printf body, indent(0), "navp" nid, nid, "Table of Contents", "toc.xhtml"
	nid++
}

#printf "%s  </navPoint>\n", ogap

/^nnav/ {
	if ( $5 )
		s = "#" $5
	else
		s = ""

	c = 0
	if ( $3 > prev ) {
		for ( i = prev; $3 > i + 1; i++ )
			push(i + 1);
		print ""
	} else if ( $3 < prev )
		for ( i = prev; $3 <= i; i-- )
			if ( peek() == i )
				pop()
			else
				print(c++ ? indent(i) tail : tail)
	else
		print tail

	printf body, indent($3), "navp" nid, nid, $6, $2 s
	nid++

	prev = $3
}

END {
	c = 0
	for ( i = prev + 1; i >= 0; i-- )
		if ( peek() == i )
			pop()
		else
			print ( c++ ? indent(i) tail : tail )
        print "  </navMap>"
}


