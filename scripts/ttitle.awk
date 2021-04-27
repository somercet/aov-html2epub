#! /usr/bin/env -S gawk -f

# we need to create
# toc.ncx
# toc.xhtml
# content.opf HTML manifest

BEGIN {
	ogap = ""
	count = 2
	onest = 0
	oltrack = 1
	tocN = "toc2_1toc_TMP"
	tocX = "toc3_1toc_TMP"
	e2pl = "toc2_2pagelist_TMP"
	e3pl = "toc3_2pagelist_TMP"
	e2dtb = "toc2_dtbMeta_TMP"

	printf	"  <navMap>\n"	\
		"    <navPoint id=\"titlepage.xhtml\" playOrder=\"1\">\n"	\
		"      <navLabel><text>Title page</text></navLabel>\n"	\
		"      <content src=\"titlepage.xhtml\" />\n"		\
		> tocN

	printf	"    <nav epub:type=\"toc\" id=\"toc\">\n"	\
		"      <ol class=\"epub3toca\">\n"	\
		"        <li><a epub:type=\"titlepage\" href=\"titlepage.xhtml\">Cover</a>"	\
		> tocX
#	sub(/\/$/, "\\/", ops)
	sub(/\//, "", ops)
	sub(/^/, "/", ops)
	sub(/$/, "\\//", ops)
	dtbdepth = 0
	dtbmPN = 0
	dtbtPC = 0
}

BEGINFILE {
	ttout = 0
	ttresult = 0
	fn = FILENAME
	sub(ops, "", fn)
	fnID = fn
#	gsub(/[^[:alnum:]]/, "", fnID)
	sub(/.*\//, "", fnID)
}

/<!--[	 ]+TTITLE/ {
	if ( ttout == 0 )
		ttout++
	else
		next

	gsub(/	/, " ")
	gsub(/  +/, " ")
	sub(/ -->.*/, "")
	sub(/^.*<!-- +/, "")
	sub(/^TTITLE /, "0 ")
	sub(/^TTITLE/, "")
	sub(/ /, "	")
	ttresult = split($0, parts, "	")
	if ( ttresult < 2 )
		printf "Malformed TTITLE in \"%s\".\n", FILENAME > "/dev/stderr"

	ngap = sprintf("%*s",  parts[1] * 2, "")

	if ( dtbdepth < parts[1] )
		dtbdepth = parts[1]

	if ( onest >= parts[1] ) {
		printf "%s    </navPoint>\n", ogap > tocN

		printf "</li>\n" > tocX
	}

	for ( ; onest > parts[1] ; onest-- ) {
		printf	"%s        </ol>\n"	\
			"%s      </li>\n", ogap, ogap > tocX
		sub(/  /, "", ogap)
		printf "%s  </navPoint>\n", ogap > tocN
	}

	for ( ; onest < parts[1] ; onest++ ) {
		#echo > tocN

		printf "\n%s        <ol class=\"epub3toc%c epub3toc%d\">\n", \
			ngap, 97 + parts[1], oltrack++ > tocX
	}

	printf	"%s    <navPoint id=\"%s\" playOrder=\"%d\">\n"	\
		"%s      <navLabel><text>%s</text></navLabel>\n" \
		"%s      <content src=\"%s\" />\n",		\
		ngap, fnID, count,				\
		ngap, parts[2],					\
		ngap, fn > tocN

	sub(/([0-9]+|[ivxlcdm]+|[IVXLCDM]+|[A-Za-z])\. +/, "", parts[2])

	printf "%s        <li><a epub:type=\"chapter\" href=\"%s\">%s</a>", \
		ngap, fn, parts[2] > tocX
 
	ogap = ngap
	onest = parts[1]
	count++
}

#<span epub:type="pagebreak" class="pages" id="page207">207</span>
/epub:type=['"]pagebreak/ {
	sub(/.* id=['"]/, "")
	# pageid:
	sub(/['"].*/, "")
	pagenum = $0
	# must strip OPS builddir
	sub(/[pPaAgGeE]+[-_]*/, "", pagenum)
	printf	"    <pageTarget type=\"normal\" id=\"%s\" value=\"%s\">\n"	\
		"      <navLabel><text>%s</text></navLabel>\n"		\
		"      <content src=\"%s#%s\"/>\n"			\
		"    </pageTarget>\n", $0, pagenum, pagenum, fn, $0 > e2pl

	printf	"      <li><a href=\"%s#%s\">%s</a></li>\n", fn, $0, pagenum > e3pl
	dtbtPC++
	dtbmPN = pagenum
}


ENDFILE {
	if ( ttresult < 2 || ttout == 0 ) {
		printf	"%s    <navPoint id=\"%s\" playOrder=\"%d\">\n"	\
			"%s      <navLabel><text>%s</text></navLabel>\n" \
			"%s      <content src=\"%s\" />\n",		\
			ogap, fnID, count,				\
			ogap, count,					\
			ogap, fn > tocN

		printf "%s        <li><a epub:type=\"chapter\" href=\"%s\">%s</a>", \
			ogap, fn, count > tocX
	}
}


END {
	printf "</li>\n" > tocX

	printf "%d	%d	%d", dtbdepth + 1, dtbmPN, dtbtPC > e2dtb

	for ( ; onest > 0 ; onest-- ) {
		printf	"%s    </navPoint>\n", ogap > tocN

		printf	"%s        </ol>\n"	\
			"%s      </li>\n", ogap, ogap > tocX
		sub(/  /, "", ogap)
	}


	## end Tocs2 and 3
	printf	"    </navPoint>\n"	\
		"  </navMap>\n" > tocN

	printf	"      </ol>\n"		\
		"    </nav>\n"		\
		"  </section>\n" > tocX
}

# XHTML IDs: match  [A-Za-z][A-Za-z0-9:_.-]*
# https://www.w3.org/TR/xhtml1/#C_8
# HTML5 IDs: unique in the document; no spaces; at least one char

