
# https://www.w3.org/TR/epub-ssv-11/#sec-partitions

function vocab_landm(e) {
	e["apdx"] = "appendix"
	e["bibl"] = "bibliography"
	e["endn"] = "endnotes"
	e["errt"] = "errata"
	e["ftns"] = "footnotes"
	e["glss"] = "glossary"
	e["text"] = "text"
	e["lloi"] = "loi"
	e["llot"] = "lot"
	e["ttoc"] = "toc"
}

function vocab_long(e) {
	e["apdx"] = "Appendix"
	e["bibl"] = "Bibliography"
	e["endn"] = "Endnotes"
	e["errt"] = "Errata"
	e["ftns"] = "Footnotes"
	e["glss"] = "Glossary"
	e["text"] = "Start of Text"
	e["lloi"] = "List of Illustrations"
	e["llot"] = "List of Tables"
	e["ttoc"] = "Table of Contents"
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
	e["part"] = "part"
	e["prmb"] = "preamble"
	e["prfc"] = "preface"
	e["prlg"] = "prologue"
	e["ttpg"] = "title-page"
	e["volm"] = "volume"
	e["schp"] = "subchapter"
	e["chap"] = "chapter"
	e[""] = ""

	vocab_landm(e)
}

