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

	ind[0] = "      "
	body = "<navPoint id=\"%s\" playOrder=\"%s\"><navLabel><text>%s</text></navLabel><content src=\"%s\" />"
	tail = "</navPoint>"

	printf indent(0) body, "navp" nid, nid, "Title page", "titlepage.xhtml"
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

	printf indent($3) body, "navp" nid, nid, $6, $2 s
	nid++

	prev = $3
}

END {
	c = 0
	for ( i = prev - 1; i >= 0; i-- )
		if ( peek() == i )
			pop()
		else
			print ( c++ ? indent(i) tail : tail )
}


