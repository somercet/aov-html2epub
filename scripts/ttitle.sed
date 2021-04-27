# reads in:
# OPS/Text/filename.xhtml:<!-- TTITLE2 3. Only In Threes -->
# spits out:
#   OPS/Text/filename.xhtml
#   2 <TAB> "3. Only In Threes"
/<!--[ 	]+TTITLE/ {
s/<!--[ 	]+//
s/[ 	]+-->//
s/	/    /g
s/^TTITLE +/0 /
s/^TTITLE//
s/ +/	/
F
p
}
