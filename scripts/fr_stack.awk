
function push(val) {
	stack[++sp] = val
}

function pop() {
	if (sp == 0)
		return 0
	val = stack[sp]
	delete stack[sp--]
	return val
}

function peek() {
	return (sp > 0 ? stack[sp] : "")
}

