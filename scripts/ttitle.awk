#! /usr/bin/env -S gawk -f


BEGIN {

RS=">[^<]*<"

e2tocpf = \
	"%s    <navPoint id=\"%s\" playOrder=\"%d\">\n"  \
	"%s      <navLabel><text>%s</text></navLabel>\n" \
	"%s      <content src=\"%s\" />\n"

e3tocpf = "%s        <li><a epub:type=\"%s\" href=\"%s\">%s</a>"

#no toc/loi/lot cover part/notes/index text/bodymatter
etAbbr["ackn"] = "acknowledgements"
etAbbr["afwd"] = "afterword"
etAbbr["apdx"] = "appendix"
etAbbr["bibl"] = "bibliography"
etAbbr["clpn"] = "colophon"
etAbbr["cntr"] = "contributors"
etAbbr["cprt"] = "copyright-page"
etAbbr["dedi"] = "dedication"
etAbbr["epgr"] = "epigraph"
etAbbr["eplg"] = "epilogue"
etAbbr["errt"] = "errata"
etAbbr["ftns"] = "footnotes"
etAbbr["frwd"] = "foreword"
etAbbr["glss"] = "glossary"
etAbbr["intr"] = "introduction"
etAbbr["prmb"] = "preamble"
etAbbr["prfc"] = "preface"
etAbbr["prlg"] = "prologue"
etAbbr["ttpg"] = "title-page"
etAbbr["volm"] = "volume"

ogap	= ""
count	= 2
onest	= 0
oltrack	= 1
e3toc	= "toc3_toc_TMP"
e3pl	= "toc3_pagelist_TMP"
e3ldmrk	= "toc3_lndmrk_TMP"

e2toc	= "toc2_toc_TMP"
e2pl	= "toc2_pagelist_TMP"
e2guide = "toc2_guide_TMP"
e2dtb	= "toc2_dtbMeta_TMP"

e3loi	= "toc3_loi_TMP"
e3lot	= "toc3_lot_TMP"

dtbdepth = 0
dtbtPC = 0


	printf	"    <navPoint id=\"titlepage.xhtml\" playOrder=\"1\">\n"	\
		"      <navLabel><text>Title page</text></navLabel>\n"	\
		"      <content src=\"titlepage.xhtml\" />\n"		\
		> e2toc

	printf	"        <li><a epub:type=\"titlepage\" href=\"titlepage.xhtml\">Cover</a>"	\
		> e3toc
	if ( ops ) {
		sub(/\/+$/,  "", ops)
		sub(/^/,    "/", ops)
		sub(/$/, "\\//", ops)
	}
}

BEGINFILE {
	ttout = 0
	ttresult = 0
	fn = FILENAME
	lndmrk = 0
	if ( ops )
		sub(ops, "", fn)
	fnID = fn
#	gsub(/[^[:alnum:]]/, "", fnID)
	sub(/.*\//, "", fnID)
}

# NNAV [1,2,3...]+[epubtype] Chap title
# NNAV loi #illos01 My butt

/^!--[	\n ]+NNAV[	\n ]+[0-9]*\+/ {
	if ( ttout == 0 )
		ttout++
	else
		next

	gsub(/[ \n\t]+/, " ")
	sub(/ --$/, "")
	sub(/^!-- NNAV \+/, "0+")
	sub(/^!-- NNAV /, "")
	sub(/\+/, "	")
	sub(/ /, "	")


	ttresult = split($0, parts, /	/)
	if ( dtbdepth < parts[1] )
		dtbdepth = parts[1]

	if ( parts[3] ~ /[><"]/ ) {
		gsub(/</, "&lt;", parts[3])
		gsub(/>/, "&gt;", parts[3])
		gsub(/"/, "&quot;", parts[3])
	}

	if ( onest >= parts[1] ) {
		printf "%s    </navPoint>\n", ogap > e2toc

		printf "</li>\n" > e3toc
	}

	for ( ; onest > parts[1] ; onest-- ) {
		printf "%s  </navPoint>\n", ogap > e2toc

		printf	"%s        </ol>\n"	\
			"%s      </li>\n", ogap, ogap > e3toc
		sub(/  /, "", ogap)
	}

	ngap = sprintf("%*s",  parts[1] * 2, "")

	for ( ; onest < parts[1] ; onest++ ) {
		#echo > e2toc

		printf "\n%s        <ol class=\"epub3toc%c epub3toc%d\">\n", \
			ngap, 97 + parts[1], oltrack++ > e3toc
	}

	if ( parts[2] ~ /_$/ ) {
		sub(/_$/, "", parts[2])
		lndmrk = 1
	}

	if ( ! parts[2] )
		parts[2] = "chapter"

	if ( parts[2] in etAbbr )
		epbType = etAbbr[parts[2]]
	else
		epbType = parts[2]

	if ( lndmrk ) {
		if ( epbType == "text" )
			parts[3] = "Start of text"

		printf "    <reference href=\"%s\" type=\"%s\" title=\"%s\" />\n",	\
			fn, epbType, parts[3] > e2guide

		if ( epbType == "text" )
			epbType = "bodymatter"

		printf	"        <li><a href=\"%s\" epub:type=\"%s\">%s</a></li>\n",	\
			fn, epbType, parts[3] > e3ldmrk
	}

	printf e2tocpf, ngap, fnID, count,	\
			ngap, parts[3],		\
			ngap, fn		> e2toc

	sub(/([0-9]+|[ivxlcdm]+|[IVXLCDM]+|[A-Za-z])\. +/, "", parts[3])

	printf e3tocpf, ngap, epbType, fn, parts[3] > e3toc

	ogap = ngap
	onest = parts[1]
	count++
	next
}


/^!--[	 ]+NNAV/ {
	gsub(/[ \n	]+/, " ")
	sub(/ --$/, "")
	sub(/^!-- +NNAV /, "")
	#GUIDE / LANDMARKS
#	if ( epbType ) {
#		printf	"    <reference href=\"%s\" type=\"%s\" title=\"%s\" />\n",	\
#			fn, epbType, epName > e2guide
#
#		printf	"      <li><a href=\"%s\" epub:type=\"%s\">%s</a></li>\n",	\
#			fn, epbType, epName > e3ldmrk
#	}
}


/epub:type=['"]pagebreak/ {
	sub(/.* id=['"]/, "")
	sub(/['"].*/, "")	# pageid
	pagenum = $0
	sub(/[pPaAgGeE]+[-_]*/, "", pagenum)

	printf	"    <pageTarget type=\"normal\" id=\"%s\" value=\"%s\">\n"	\
		"      <navLabel><text>%s</text></navLabel>\n"		\
		"      <content src=\"%s#%s\"/>\n"			\
		"    </pageTarget>\n",					\
		$0, pagenum, pagenum, fn, $0 > e2pl

	printf	"        <li><a href=\"%s#%s\">%s</a></li>\n", fn, $0, pagenum > e3pl
	dtbtPC++
}


ENDFILE {
	if ( ttresult < 2 || ttout == 0 ) {
		printf "%s    </navPoint>\n" e2tocpf, \
			ogap,			\
			ogap, fnID, count,	\
			ogap, count,		\
			ogap, fn		> e2toc

		printf "</li>\n" e3tocpf, ogap, "chapter", fn, count++ > e3toc
	}
}


END {
	printf "ncxvals=(%d %d %d)\n", dtbdepth + 1, pagenum, dtbtPC > e2dtb

	printf "</li>\n" > e3toc
	for ( ; onest > 0 ; onest-- ) {
		printf	"%s    </navPoint>\n", ogap > e2toc

		printf	"%s        </ol>\n"	\
			"%s      </li>\n", ogap, ogap > e3toc
		sub(/  /, "", ogap)
	}
	printf "    </navPoint>\n" > e2toc
}

# XHTML IDs: match  [A-Za-z][A-Za-z0-9:_.-]*
# https://www.w3.org/TR/xhtml1/#C_8
# HTML5 IDs: unique in the document; no spaces; at least one char

