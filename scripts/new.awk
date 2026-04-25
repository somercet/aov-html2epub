# AWKPATH=~/Code/aov-html2epub/scripts awk -f e3_toc.awk -v 'ops=OPS' ff | less

@include "fr_page.awk"

BEGIN {
	RS = ">[^<]*<"
	innav_ln = ""
	innav  = 0
	prev   = 0
	dtbPC  = 0
	dtbdep = 0

	if ( ops ) {
		gsub(/\/{2,}/, "/", ops)
		sub(/^\.\//, "",  ops)
		sub(/\/$/, "", ops)
	}
	print "ops	" ops
}

BEGINFILE {
	file = FILENAME
	sub(/.*\//, "", file)
	path = FILENAME
	if ( ops )
		sub(ops "/", "", path)
	fid = path
	gsub(/\//, "_", fid)

	if ( fid ~ /^[A-Za-z][A-Za-z0-9_:\.-]*$/ )
		print "file	" FILENAME "	" path "	" fid
	else
		print("Warning: illegal XHTML ID chars in '" FILENAME "'.") > "/dev/stderr"
}

# <!-- INAV 2+chap	1. Section One --> depth#+type
/^!--[	\n ]+[IN]NAV[	\n ]+[0-9]*\+/ {
	gsub(/[ \n\t]+/, " ")
	sub(/ --$/, "")
	if ( sub(/^!-- INAV /, "") )
		innav = 1
	else {
		sub(/^!-- NNAV /, "")
	}
	sub(/^\+/, "0+")
	sub(/+/, "	")

	split($0, parts, /	/)
	if ( parts[1] ~ /[^[:digit:]]/ )
		print "Warning: '" FILENAME "':" NR " depth not an ASCII digit: '" $0 "'" > "/dev/stderr"
	prev = parts[1]

	if ( dtbdep < parts[1] )
		dtbdep = parts[1]

	sub(/^/, "nnav	" path "	")

	if (innav)
		innav_ln = $0
	else {
		sub(/ /, "		")
		print
	}
}

innav && /[	\n ]+id=['"]/ {
	sub(/.*[	\n ]+id=['"]/, "")
	sub(/['"].*/, "")

	sub(/ /, "	" $0 "	", innav_ln)
	print innav_ln
	innav = 0
	innav_ln = ""
}

/epub:type=['"]pagebreak/ {
	sub(/.* id=['"]/, "")
	sub(/['"].*/, "")

	s = pageno($0)
	print "page	" path "	" $0 "	" s
	dtbPC++
}


END {
	print "dtbPC	" dtbPC
	print "dtbdep	" dtbdep + 1
}

# HTML 4.01 and XHTML IDs: [A-Za-z][A-Za-z0-9-_:\.]*
# HTML5 IDs: unique in the document; no spaces; at least one char

