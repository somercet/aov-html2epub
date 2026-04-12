
# https://www.w3.org/TR/epub-ssv-11/

function vocab_landm(e) {
	e["apdx"] = "appendix"
	e["bibl"] = "bibliography"
	e["endn"] = "endnotes"
	e["errt"] = "errata"
	e["ftns"] = "footnotes"
	e["glss"] = "glossary"
	e["text"] = "text"
}

function vocab_all(e) {
	e["ackn"] = "acknowledgements"
	e["afwd"] = "afterword"
	e["clpn"] = "colophon"
	e["cntr"] = "contributors"
	e["cprt"] = "copyright-page"
	e["dedi"] = "dedication"
	e["epgr"] = "epigraph"
	e["eplg"] = "epilogue"
	e["frwd"] = "foreword"
	e["impr"] = "imprimatur"
	e["intr"] = "introduction"
	e["prmb"] = "preamble"
	e["prfc"] = "preface"
	e["prlg"] = "prologue"
	e["ttpg"] = "title-page"
	e["volm"] = "volume"
	e[""] = "chapter"

	vocab_landm(e)
}

