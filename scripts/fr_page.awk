
function pageno(p) {
	s = p
	sub(/[pPaAgGeE]+[-_]*/, "", s)
	return s
}

