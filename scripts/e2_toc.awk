#nnav	master.html	1	type	sec3	Title

function push(val) {
	stack[++sp] = val
}

function pop() {
	if (sp == 0)
		return ""
	val = stack[sp]
	delete stack[sp--]
	return val
}

function peek() {
	return (sp > 0 ? stack[sp] : "")
}

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
	body =	"<navPoint id=\"%s\" playOrder=\"%s\"><navLabel><text>%s</text></navLabel><content src=\"%s\" />"
	tail =	"</navPoint>"

	vocab_all(etAbbr)

	printf body, "navp" nid, nid, "Title page", "titlepage.xhtml"
	nid++
}

#printf "%s  </navPoint>\n", ogap

/^[in]nav/ {
	if ( $5 )
		s = "#" $5
	else
		s = ""

# increasing? push, skip
# decreasing? pop, skip.

	if ( $3 == prev )
		print tail
	else if ( $3 > prev )
		print "" # i need the loop that correctly extracts the missing depth #
	else
		for ( i = prev; i >= $3; i-- )
			print indent(i) tail

	printf indent($3) body, "navp" nid, nid, $6, $2 s
	nid++

	prev = $3
}

END {
	for ( i = prev; i >= 0; i-- )
		print indent(i) tail
}


